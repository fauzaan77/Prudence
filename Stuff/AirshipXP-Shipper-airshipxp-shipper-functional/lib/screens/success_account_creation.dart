import 'dart:async';

import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessAccountCreation extends StatefulWidget {
  const SuccessAccountCreation({super.key});

  @override
  State<SuccessAccountCreation> createState() => _SuccessAccountCreationState();
}

class _SuccessAccountCreationState extends State<SuccessAccountCreation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    Get.offAll(() => HomeScreen());
                  },
                  title: 'goToHome'.tr)
            ],
          ),
        ),
      ),
    );
  }
}
