import 'dart:async';

import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessOrderCreation extends StatefulWidget {
  const SuccessOrderCreation({super.key});

  @override
  State<SuccessOrderCreation> createState() => _SuccessOrderCreationState();
}

class _SuccessOrderCreationState extends State<SuccessOrderCreation> {
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), () {
      Get.offAll(() => HomeScreen());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/success_bg.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/success.png',
                height: 300,
                width: 300,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'orderCreated'.tr,
                textAlign: TextAlign.center,
                style: kText17w300.copyWith(fontWeight: FontWeight.w400,color: darkBlue),
              )
            ],
          ),
        ),
      ),
    );
  }
}
