import 'dart:async';

import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/customToast.dart';
import 'package:airshipxp_shipper/controllers/profile_controller.dart';
import 'package:airshipxp_shipper/screens/home.dart';
import 'package:airshipxp_shipper/screens/notification_screen.dart';
import 'package:airshipxp_shipper/screens/orders_screen.dart';
import 'package:airshipxp_shipper/screens/profile_screen.dart';
import 'package:airshipxp_shipper/utilities/pushNotification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProfileController profileController = Get.put(ProfileController());
  int _currentIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setupPushNotification()
          .then((value) => profileController.getProfileData());
    });

    super.initState();
  }

  //For Push notification

  Future<void> setupPushNotification() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    try {
      print(settings.authorizationStatus);
      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional ||
          settings.authorizationStatus == AuthorizationStatus.notDetermined) {
        print(settings.authorizationStatus);
        final RemoteMessage? remoteMessage =
            await FirebaseMessaging.instance.getInitialMessage();
        await PushNotification.initialize(flutterLocalNotificationsPlugin);
        profileController.updateFCMToken();

        FirebaseMessaging.onBackgroundMessage(
            _firebaseMessagingBackgroundHandler);
      } else {
        print(
            'settings.authorizationStatus ==> ${settings.authorizationStatus}');

        CustomToast.show(
            "Notification permission denied! Allow notification permission to get notifications from LuxuryFastRide-Driver");
        Timer(Duration(seconds: 4), () async {
          openAppSettings();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  //For Push notification

  final tabs = [
    Home(),
    OrderScreen(),
    NotificationScreen(
      isFromBottomTab: true,
    ),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: black,
          unselectedItemColor: Color.fromRGBO(255, 255, 255, 0.4),
          selectedItemColor: white,
          selectedLabelStyle: kText11w400,
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add_sharp),
              label: 'Order',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.notifications),
              icon: Icon(Icons.notifications_outlined),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.person_2_rounded),
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            )
          ]),
      body: tabs[_currentIndex],
    );
  }
}
