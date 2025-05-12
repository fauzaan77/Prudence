import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print('Handling a background message: ${message.messageId}');
  print('Message notification title: ${message.notification?.title}');
  print('Message notification body: ${message.notification?.body}');
}

Future<void> setup() async {
  const androidInitializationSetting =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosInitializationSetting = DarwinInitializationSettings();
  const initSettings = InitializationSettings(
      android: androidInitializationSetting, iOS: iosInitializationSetting);
  await _flutterLocalNotificationsPlugin.initialize(initSettings);
}

class PushNotificationService {
  /// Initializes everything related to push notifications
  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();
    print("🚀 Push Notification Initialized");

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🔔 onMessageOpenedApp: $message");
    });

    await enableIOSNotifications();
    await registerNotificationListeners();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Enables iOS foreground notification presentation
  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// Registers foreground and background listeners
  Future<void> registerNotificationListeners() async {
    print("📡 Registering notification listeners...");

    AndroidNotificationChannel channel = androidNotificationChannel();

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    var iOSSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    var initSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("🔔 Notification tapped: ${response.payload}");
        // You can handle payload navigation here
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      print("📩 Foreground notification: ${message?.notification?.body}");

      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;

      if (notification != null && android != null) {
        _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
              playSound: true,
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
        );
      }
    });
  }

  /// Returns Android notification channel config
  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );
}
