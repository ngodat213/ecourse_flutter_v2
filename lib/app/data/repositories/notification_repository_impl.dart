import 'package:ecourse_flutter_v2/app/data/models/notification_model.dart';
import 'package:ecourse_flutter_v2/app/domain/repositories/notification_repository.dart';
import 'package:ecourse_flutter_v2/core/services/base_api.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final BaseAPI _api;

  NotificationRepositoryImpl({BaseAPI? api}) : _api = api ?? BaseAPI();

  @override
  Future<List<NotificationModel>> getNotifications({
    int page = 1,
    int limit = 20,
    bool unread = false,
  }) async {
    try {
      final response = await _api.fetchData(
        '/notifications',
        params: {'page': page, 'limit': limit, 'unread': unread},
        method: ApiMethod.GET,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      }
      throw Exception('Failed to load notifications');
    } catch (e) {
      throw Exception('Failed to load notifications: $e');
    }
  }

  @override
  Future<NotificationModel> markAsRead(String notificationId) async {
    try {
      final response = await _api.fetchData(
        '/notifications/$notificationId/read',
        method: ApiMethod.PUT,
      );

      if (response.statusCode == 200) {
        return NotificationModel.fromJson(response.data);
      }
      throw Exception('Failed to mark notification as read');
    } catch (e) {
      throw Exception('Failed to mark notification as read: $e');
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      final response = await _api.fetchData(
        '/notifications/read-all',
        method: ApiMethod.PUT,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to mark all notifications as read');
      }
    } catch (e) {
      throw Exception('Failed to mark all notifications as read: $e');
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    try {
      final response = await _api.fetchData(
        '/notifications/$notificationId',
        method: ApiMethod.DELETE,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete notification');
      }
    } catch (e) {
      throw Exception('Failed to delete notification: $e');
    }
  }

  @override
  Future<void> registerFCMToken(String token) async {
    try {
      final response = await _api.fetchData(
        '/notifications/register-token',
        method: ApiMethod.POST,
        body: {'token': token},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to register FCM token');
      }
    } catch (e) {
      throw Exception('Failed to register FCM token: $e');
    }
  }

  @override
  Future<void> unregisterFCMToken(String token) async {
    try {
      final response = await _api.fetchData(
        '/notifications/unregister-token',
        method: ApiMethod.POST,
        body: {'token': token},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to unregister FCM token');
      }
    } catch (e) {
      throw Exception('Failed to unregister FCM token: $e');
    }
  }
}
