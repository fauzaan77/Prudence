import 'dart:async';

import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/screens/slider_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   Timer(Duration(seconds: 2), () {
  //     Get.to(() => SliderScreen());
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 85,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 110,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: kText26w600.copyWith(
                    fontWeight: FontWeight.w300, color: black, height: 1.3),
                children: [
                  TextSpan(text: 'splashText'.tr),
                  TextSpan(
                    text: 'destination'.tr,
                    style: kText26w600.copyWith(
                        color: cherryRed, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
