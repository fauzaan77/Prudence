import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/shared_pref.dart';

class SuccessAccountCreation extends StatelessWidget {
  SuccessAccountCreation({super.key});
  final SessionManager sessionManager = SessionManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/success_bg.png'),
              fit: BoxFit.contain,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/success.png',
                      height: 300,
                      width: 300,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'stepsComplete'.tr,
                      textAlign: TextAlign.center,
                      style: kText17w300.copyWith(
                          fontWeight: FontWeight.w400, color: darkBlue),
                    )
                  ],
                ),
                ButtonPrimary(
                    onPressed: () {
                      sessionManager.setBool(SessionManager.IS_LOGGED_IN, true);
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                      // Get.offAll(() => HomeScreen());
                    },
                    title: 'goToHome'.tr)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
