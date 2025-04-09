import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/user_repository_impl.dart';
import 'package:ecourse_flutter_v2/app/domain/repositories/user_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'shared_prefs.dart';
import '../routes/app_routes.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();
  factory FirebaseMessagingService() => _instance;
  FirebaseMessagingService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final UserRepository _userRepository = UserRepositoryImpl();

  String? _fcmToken;
  GlobalKey<NavigatorState>? _navigatorKey;

  // Store pending notifications to handle when app is opened
  Map<String, dynamic>? _pendingNotificationData;

  String? get fcmToken => _fcmToken;
  Map<String, dynamic>? get pendingNotificationData => _pendingNotificationData;

  void setNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  Future<void> initialize() async {
    try {
      await Firebase.initializeApp();

      // Request permission
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Get FCM token
      _fcmToken = await FirebaseMessaging.instance.getToken();
      debugPrint('FCM Token: $_fcmToken');

      // Listen for token refresh
      FirebaseMessaging.instance.onTokenRefresh.listen((token) {
        _fcmToken = token;
        _registerTokenIfLoggedIn(token);
      });

      // Configure handlers
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

      // Initialize local notifications
      await _initLocalNotifications();

      // Get initial message
      final initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        _handleInitialMessage(initialMessage);
      }

      // Register token if user is logged in
      if (_fcmToken != null) {
        await _registerTokenIfLoggedIn(_fcmToken!);
      }
    } catch (e) {
      debugPrint('Error initializing Firebase: $e');
    }
  }

  Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Received foreground message: ${message.messageId}');
    _showLocalNotification(message);
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('App opened from notification: ${message.messageId}');
    _storeAndProcessNotificationData(message.data);
  }

  void _handleInitialMessage(RemoteMessage message) {
    debugPrint('Initial message received: ${message.messageId}');
    _storeAndProcessNotificationData(message.data);
  }

  void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    debugPrint('Notification tapped: ${response.payload}');

    if (response.payload != null) {
      try {
        final Map<String, dynamic> data = jsonDecode(response.payload!);
        _storeAndProcessNotificationData(data);
      } catch (e) {
        debugPrint('Error parsing notification payload: $e');
      }
    }
  }

  void _storeAndProcessNotificationData(Map<String, dynamic> data) {
    _pendingNotificationData = data;

    final String? actionUrl = data['action_url'];

    if (actionUrl != null && actionUrl.isNotEmpty) {
      debugPrint('Processing action URL: $actionUrl');

      if (actionUrl.startsWith('http://') || actionUrl.startsWith('https://')) {
        _launchUrl(actionUrl);
      }
    }

    _tryNavigateBasedOnNotificationData();
  }

  void _tryNavigateBasedOnNotificationData() {
    if (_navigatorKey?.currentContext == null ||
        _pendingNotificationData == null) {
      return;
    }

    final data = _pendingNotificationData!;
    final context = _navigatorKey!.currentContext!;
    final String? type = data['type'];
    final String? actionUrl = data['action_url'];

    // First try to navigate using actionUrl if it's an internal route
    if (actionUrl != null &&
        actionUrl.isNotEmpty &&
        !actionUrl.startsWith('http://') &&
        !actionUrl.startsWith('https://')) {
      _navigateBasedOnActionUrl(context, actionUrl);
      _pendingNotificationData = null;
      return;
    }

    // Otherwise try to navigate based on notification type
    if (type != null) {
      switch (type) {
        case 'message':
          final String? conversationId = data['conversation_id'];
          if (conversationId != null) {
            AppRoutes.push(
              context,
              AppRoutes.conversation,
              arguments: {'id': conversationId},
            );
          }
          break;
        case 'course':
          final String? courseId = data['course_id'];
          if (courseId != null) {
            AppRoutes.push(
              context,
              AppRoutes.courseDetail,
              arguments: courseId,
            );
          }
          break;
        case 'event':
          final String? eventId = data['event_id'];
          if (eventId != null) {
            AppRoutes.push(
              context,
              AppRoutes.eventDetail,
              arguments: {'id': eventId},
            );
          }
          break;
        default:
          debugPrint('Unknown notification type: $type');
          break;
      }
    }

    // Clear pending data after processing
    _pendingNotificationData = null;
  }

  void _navigateBasedOnActionUrl(BuildContext context, String actionUrl) {
    // Remove leading slash if present
    final route =
        actionUrl.startsWith('/') ? actionUrl.substring(1) : actionUrl;

    // Check if the route contains path parameters
    if (route.contains('/')) {
      final segments = route.split('/');

      if (segments.length >= 2) {
        final basePath = segments[0];
        final parameter = segments[1];

        switch (basePath) {
          case 'conversation':
            AppRoutes.push(
              context,
              AppRoutes.conversation,
              arguments: {'id': parameter},
            );
            break;
          case 'course-detail':
            AppRoutes.push(
              context,
              AppRoutes.courseDetail,
              arguments: parameter,
            );
            break;
          case 'event-detail':
            AppRoutes.push(
              context,
              AppRoutes.eventDetail,
              arguments: {'id': parameter},
            );
            break;
          default:
            debugPrint('Unknown route in action_url: $route');
            break;
        }
      }
    } else {
      // Try to navigate to the route directly
      try {
        AppRoutes.push(context, '/$route');
      } catch (e) {
        debugPrint('Error navigating to route $route: $e');
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch URL: $url');
    }
  }

  // Method to be called from UI to check for pending notifications
  void checkAndProcessPendingNotifications() {
    if (_pendingNotificationData != null) {
      _tryNavigateBasedOnNotificationData();
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? 'Notification',
      message.notification?.body ?? '',
      details,
      payload: jsonEncode(message.data),
    );
  }

  Future<void> _registerTokenIfLoggedIn(String token) async {
    final authToken = SharedPrefs.getToken();
    if (authToken == null) return;

    try {
      String deviceInfo = await _getDeviceInfo();

      final response = await _userRepository.registerFcmToken(
        fcmToken: token,
        deviceInfo: deviceInfo,
      );

      if (response.allGood) {
        debugPrint('FCM token registered successfully');
      } else {
        debugPrint('Error registering FCM token: ${response.message}');
      }
    } catch (e) {
      debugPrint('Error registering FCM token: $e');
    }
  }

  Future<String> _getDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        return jsonEncode({
          'platform': 'android',
          'model': androidInfo.model,
          'manufacturer': androidInfo.manufacturer,
          'version': androidInfo.version.release,
        });
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        return jsonEncode({
          'platform': 'ios',
          'model': iosInfo.model,
          'name': iosInfo.name,
          'systemVersion': iosInfo.systemVersion,
        });
      }
    } catch (e) {
      debugPrint('Error getting device info: $e');
    }

    return Platform.operatingSystem;
  }

  // Public method to manually register token
  Future<void> registerFcmToken() async {
    if (_fcmToken != null) {
      await _registerTokenIfLoggedIn(_fcmToken!);
    } else {
      _fcmToken = await FirebaseMessaging.instance.getToken();
      if (_fcmToken != null) {
        await _registerTokenIfLoggedIn(_fcmToken!);
      }
    }
  }
}
