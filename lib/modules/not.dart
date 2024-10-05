import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class LocalNotificationService {
  // Singleton pattern
  static final LocalNotificationService _instance = LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _instance;
  }

  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Initialize timezone data
    tz_data.initializeTimeZones();

    // Android-specific initialization settings
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // Define platform-specific initialization settings
    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      // You can add iOS or macOS settings here if needed
    );

    // Initialize the plugin with platform-specific settings and the callback
    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onSelectNotification, // Corrected callback
    );
  }

// Callback function for when a notification is tapped
  void onSelectNotification(NotificationResponse notificationResponse) async {
    // Extract the payload from the NotificationResponse object
    final String? payload = notificationResponse.payload;

    // Perform the desired action with the payload
    if (payload != null) {
      print('Notification Payload: $payload');
      // You can navigate to a specific screen based on the payload or perform other actions.
    }
  }


  // Show a simple notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'main_channel',
      'Main Channel',
      channelDescription: 'Main channel notifications',
      importance: Importance.max,
      priority: Priority.high,
    );


    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformDetails,
      payload: payload,
    );
  }

  // Schedule a notification
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'main_channel',
          'Main Channel',
          channelDescription: 'Main channel notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  // Handle notification when app is in the foreground (iOS only)
  static Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // Handle your logic here, e.g., navigate to a specific screen
  }

  // Handle notification selection (payload)


  // Cancel a notification by its ID
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
