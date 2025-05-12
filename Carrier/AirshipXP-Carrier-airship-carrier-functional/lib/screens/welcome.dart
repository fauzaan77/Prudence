import 'dart:async';

import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/screens/home_screen.dart';
import 'package:airship_carrier/screens/slider_screen.dart';
import 'package:airship_carrier/util/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final SessionManager sessionManager = SessionManager();
  @override
  void initState() {
    // TODO: implement initState
    // Timer(Duration(seconds: 3), () {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>SliderScreen()));
    // });
    Future.delayed(const Duration(seconds: 3), () {
      sessionManager.getBool(SessionManager.IS_LOGGED_IN).then((value) {
        if (value==true){
          Navigator.of(context,rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>HomeScreen()), (route) => false);
        }else{
          Navigator.of(context,rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>SliderScreen()), (route) => false);
        }
      }
      );

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 85,
                fit: BoxFit.contain,
              ),
              Text(
                'carrier'.tr,
                style: kText18w700,
              ),
              SizedBox(height: 40),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: kText18w600.copyWith(
                      fontWeight: FontWeight.w300, color: black),
                  children: [
                    TextSpan(text: 'splashText'.tr),
                    TextSpan(
                      text: 'destination'.tr,
                      style: kText20w700.copyWith(color: cherryRed),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
