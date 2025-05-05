import 'dart:async';

import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/language/transalation.dart';
import 'package:airshipxp_shipper/screens/home_screen.dart';
import 'package:airshipxp_shipper/screens/slider_screen.dart';
import 'package:airshipxp_shipper/screens/welcome.dart';
import 'package:airshipxp_shipper/utilities/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'components/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = StripePublishKey;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token = "";

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      handleRouteChange();
    });
    super.initState();
  }

  void handleRouteChange() async {
    token = await SessionManager().getString(SessionManager.userToken) ?? '';

    print('User Token $token');
    if (token == '') {
      Get.to(() => SliderScreen());
    } else {
      // commonController.setupPushNotification().then((value) async {
      Get.offAll(() => HomeScreen());
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Translation(),
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'NotoSans',
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: Colors.white,
        // ),
        useMaterial3: true,
      ),
      home: WelcomeScreen(),
    );
  }
}
