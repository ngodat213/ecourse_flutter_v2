import 'package:ecourse_flutter_v2/app/data/models/notification_model.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getNotifications({
    int page = 1,
    int limit = 20,
    bool unread = false,
  });

  Future<NotificationModel> markAsRead(String notificationId);

  Future<void> markAllAsRead();

  Future<void> deleteNotification(String notificationId);

  Future<void> registerFCMToken(String token);

  Future<void> unregisterFCMToken(String token);
}
