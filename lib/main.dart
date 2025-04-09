import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_provider.dart';
import 'package:ecourse_flutter_v2/core/services/firebase_messaging_service.dart';
import 'package:ecourse_flutter_v2/core/utils/responsive_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/route_guard.dart';
import 'core/services/shared_prefs.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load();
  await SharedPrefs.init();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Set navigator key for FirebaseMessagingService
    FirebaseMessagingService().setNavigatorKey(_navigatorKey);
    await FirebaseMessagingService().initialize();
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProvider.providers,
      child: ScreenUtilInit(
        designSize:
            ResponsiveLayout.isDesktop(context)
                ? const Size(1920, 1080)
                : const Size(360, 800),
        builder:
            (_, __) => Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return MaterialApp(
                  title: 'ECourse'.tr(),
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  navigatorKey: _navigatorKey,
                  themeMode: themeProvider.themeMode,
                  theme: themeProvider.lightTheme,
                  darkTheme: themeProvider.darkTheme,
                  initialRoute: AppRoutes.splash,
                  routes: {
                    ...AppRoutes.getRoutes(),
                    // Thêm các route mới
                    AppRoutes.conversation: (context) {
                      final args =
                          ModalRoute.of(context)?.settings.arguments
                              as Map<String, dynamic>?;
                      final conversationId = args?['id'] as String?;
                      return ConversationScreen(conversationId: conversationId);
                    },
                    AppRoutes.eventDetail: (context) {
                      final args =
                          ModalRoute.of(context)?.settings.arguments
                              as Map<String, dynamic>?;
                      final eventId = args?['id'] as String?;
                      return EventDetailView(eventId: eventId);
                    },
                  },
                  onGenerateRoute: (settings) {
                    // Xử lý các route bổ sung cần tham số động
                    return null;
                  },
                  navigatorObservers: [RouteGuard()],
                );
              },
            ),
      ),
    );
  }
}

// Khai báo tạm thời để tránh lỗi biên dịch, cần thay thế bằng các component thực tế
class ConversationScreen extends StatelessWidget {
  final String? conversationId;

  const ConversationScreen({super.key, this.conversationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cuộc trò chuyện ${conversationId ?? ""}')),
      body: Center(
        child: Text('Conversation ID: ${conversationId ?? "Not provided"}'),
      ),
    );
  }
}

class EventDetailView extends StatelessWidget {
  final String? eventId;

  const EventDetailView({super.key, this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chi tiết sự kiện ${eventId ?? ""}')),
      body: Center(child: Text('Event ID: ${eventId ?? "Not provided"}')),
    );
  }
}
