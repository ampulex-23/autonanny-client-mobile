import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

/// FE-MVP-019: Сервис для обработки уведомлений о статусе поездки
class TripStatusNotifications {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  /// Инициализация локальных уведомлений
  static Future<void> initialize() async {
    if (_initialized) return;

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _initialized = true;
    Logger().i('Trip status notifications initialized');
  }

  /// Обработка нажатия на уведомление
  static void _onNotificationTapped(NotificationResponse response) {
    Logger().i('Notification tapped: ${response.payload}');
    // Здесь можно добавить навигацию к экрану поездки
  }

  /// Показать локальное уведомление о статусе поездки
  static Future<void> showTripStatusNotification({
    required String title,
    required String body,
    required int statusId,
  }) async {
    if (!_initialized) {
      await initialize();
    }

    // Определяем важность уведомления в зависимости от статуса
    final importance = _getImportanceForStatus(statusId);
    final priority = _getPriorityForStatus(statusId);

    final androidDetails = AndroidNotificationDetails(
      'trip_status_channel',
      'Статусы поездки',
      channelDescription: 'Уведомления об изменении статуса поездки',
      importance: importance,
      priority: priority,
      icon: '@mipmap/ic_launcher',
      enableVibration: true,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      statusId, // Используем statusId как ID уведомления
      title,
      body,
      details,
      payload: 'trip_status_$statusId',
    );

    Logger().i('Trip status notification shown: $title - $body');
  }

  /// Обработка входящего Firebase сообщения о статусе
  static Future<void> handleFirebaseMessage(RemoteMessage message) async {
    Logger().i('Handling Firebase message: ${message.data}');

    // Проверяем, что это уведомление о статусе поездки
    if (message.data['type'] != 'trip_status') return;

    final title = message.notification?.title ?? 'Обновление статуса';
    final body = message.notification?.body ?? '';
    final statusId = int.tryParse(message.data['status_id']?.toString() ?? '0') ?? 0;

    if (statusId > 0) {
      await showTripStatusNotification(
        title: title,
        body: body,
        statusId: statusId,
      );
    }
  }

  /// Определить важность уведомления по статусу
  static Importance _getImportanceForStatus(int statusId) {
    switch (statusId) {
      case 4: // Ребенок в машине
        return Importance.high;
      case 5: // Поездка завершена
        return Importance.high;
      case 3: // Водитель прибыл
        return Importance.defaultImportance;
      case 2: // Водитель выехал
        return Importance.low;
      default:
        return Importance.defaultImportance;
    }
  }

  /// Определить приоритет уведомления по статусу
  static Priority _getPriorityForStatus(int statusId) {
    switch (statusId) {
      case 4: // Ребенок в машине
        return Priority.high;
      case 5: // Поездка завершена
        return Priority.high;
      case 3: // Водитель прибыл
        return Priority.defaultPriority;
      case 2: // Водитель выехал
        return Priority.low;
      default:
        return Priority.defaultPriority;
    }
  }

  /// Отменить все уведомления о поездке
  static Future<void> cancelAllTripNotifications() async {
    await _localNotifications.cancelAll();
  }

  /// Отменить конкретное уведомление
  static Future<void> cancelNotification(int notificationId) async {
    await _localNotifications.cancel(notificationId);
  }
}
