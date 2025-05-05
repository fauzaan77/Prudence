import 'dart:async';

import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/authenticate_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({
    super.key,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var phoneNumber = Get.arguments;
  final AuthenticateController authController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startTimer();
    });
    super.initState();
  }

  late Timer _timer;
  RxInt count = 20.obs;

  startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count.value == 0) {
        _timer.cancel();
      } else {
        count.value--;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'verifyOtp'.tr,
        leading: true,
      ),
      body: Obx(
        () => authController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          kToolbarHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: Get.height * 0.6,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'weHaveSent'.tr,
                                  style: kText18w400.copyWith(color: greyOp4),
                                ),
                                Text(
                                  phoneNumber,
                                  style: kText18w400,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  // child: OTPTextField(
                                  //   inputFormatter: [
                                  //     FilteringTextInputFormatter.digitsOnly
                                  //   ],
                                  //   style: kText18w600,
                                  //   length: 6,
                                  //   fieldStyle: FieldStyle.box,
                                  //   fieldWidth: 50,
                                  //   onChanged: (value) {
                                  //     authController.otp.value = value;
                                  //   },

                                  //   otpFieldStyle: OtpFieldStyle(borderColor: black),
                                  // ),
                                  child: PinCodeTextField(
                                    controller: authController.otpController,
                                    autoDisposeControllers: false,
                                    appContext: context,
                                    keyboardType: defaultTargetPlatform ==
                                            TargetPlatform.iOS
                                        ? const TextInputType.numberWithOptions(
                                            decimal: true, signed: true)
                                        : const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                      // FilteringTextInputFormatter.allow(
                                      //     RegExp('[0-9.]')),
                                    ],
                                    length: 6,
                                    animationType: AnimationType.scale,
                                    pinTheme: PinTheme(
                                      fieldHeight: 45,
                                      fieldWidth: 45,
                                      inactiveFillColor: white,
                                      activeFillColor: inputBg,
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(5),
                                      selectedColor: greyOp2,
                                      inactiveColor: greyOp2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 30),
                                  child: count.value == 0
                                      ? InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () {
                                            authController.sendOtp();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: inActiveGrey),
                                            ),
                                            child: Text(
                                              'resendSms'.tr,
                                              style: kText18w400.copyWith(
                                                  color: greyOp3),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: inActiveGrey),
                                          ),
                                          child: Text(
                                            "${'resendOtpIn'.tr} ${count.value} ${'sec'.tr}",
                                            style: kText18w400.copyWith(
                                                color: greyOp3),
                                          ),
                                        ),
                                ),
                              ]),
                        ),
                        ButtonPrimary(
                          onPressed: () {
                            if (authController.otpController.text.length < 6) {
                              Get.snackbar(
                                  'Invalid OTP', 'Please Enter Valid OTP');
                            } else {
                              authController.verifyOtp();
                              // if (authController.isPersonalInfo == true) {
                              //   Get.to(() => TermsAndConditions());
                              // } else {
                              //   Get.to(() => CreateAccountWelcome());
                              // }
                              // authController.otpController.clear();
                            }
                          },
                          title: 'verifyOtp'.tr,
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
