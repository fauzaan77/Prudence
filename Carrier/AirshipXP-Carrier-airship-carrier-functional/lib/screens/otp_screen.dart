import 'dart:convert';

import 'package:airship_carrier/bloc/auth/verifyotp/verify_otp_bloc.dart';
import 'package:airship_carrier/bloc/auth/verifyotp/verify_otp_event.dart';
import 'package:airship_carrier/bloc/auth/verifyotp/verify_otp_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/models/otp_data_model.dart';
import 'package:airship_carrier/screens/create_account_welcome.dart';
import 'package:airship_carrier/screens/home_screen.dart';
import 'package:airship_carrier/util/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({
    super.key,
    this.isPersonalInfo,
    this.otpData,
    this.emailId
  });

  OtpData? otpData;
  bool? isPersonalInfo;
  String? emailId;
  final VerifyOtpBloc _verifyOtpBloc = VerifyOtpBloc();
  SessionManager sessionManager = SessionManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'verifyOtp'.tr,
        leading: true,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_)=>_verifyOtpBloc,
          child: BlocListener<VerifyOtpBloc,VerifyOtpState>(
            listener: (BuildContext blocListnCtx, state) {
              if(state is VerifyOtpStateConfirm){
                if(state.personalInfoDataModel!=null){
                  sessionManager.setString(SessionManager.USER_DATA,
                      jsonEncode(state.personalInfoDataModel));
                  if(state.personalInfoDataModel?.isdocumentsubmitted == true) {
                    sessionManager.setBool(SessionManager.IS_LOGGED_IN, true);
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()), (
                            route) => false);
                  }else{
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CreateAccountWelcome(isPersonalInfoSaved: true)),(route) => false,);
                  }
                }else {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CreateAccountWelcome()),(route) => false,);
                }
              }
              if (state is VerifyOtpStateError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message??""),
                  ),
                );
                Navigator.pop(context,"1");
              }
            },
            child: BlocBuilder<VerifyOtpBloc,VerifyOtpState>(
              builder: (blocCtx,state) {
                if(state is VerifyOtpInitialState) {
                  return otpScreen(context,blocCtx);
                }
                else if(state is VerifyOtpStateLoading) {
                  return Stack(
                    children: [
                      otpScreen(context,blocCtx),
                      Center(child: const CircularProgressIndicator())
                    ],
                  );
                }else if (state is VerifyOtpStateError || state is ResendOtpStateConfirm) {
                  return otpScreen(context,blocCtx);
                }else{
                  return Container();
                }
              }
            ),
          ),
        ),
      ),
    );
  }

  Widget otpScreen(BuildContext context, BuildContext blocCtx) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'weHaveSent'.tr,
                  style: kText18w400.copyWith(color: greyOp4),
                ),
                SizedBox(height: 16),
                Text(
                 emailId?? "${otpData?.countryCode} ${otpData?.mobileNumber}",
                  style: kText18w400,
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: PinCodeTextField(
                    // controller: authController.otpController,
                    appContext: context,
                    keyboardType: TextInputType.number,
                    length: 6,
                    cursorColor: green,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
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
                SizedBox(height: 16),
                InkWell(
                  onTap: (){
                    BlocProvider.of<VerifyOtpBloc>(blocCtx).add(
                        ResendOtpEvent(
                            countryCode: otpData?.countryCode??"",
                            mobileNumber: otpData?.mobileNumber??""
                        ));
                  },
                  child: Text(
                    'Resend',
                    style: kText18w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
          child: ButtonPrimary(
            onPressed: () {
              BlocProvider.of<VerifyOtpBloc>(blocCtx).add(
                  OtpConfirmEvent(
                      countryCode: otpData?.countryCode??"",
                      mobileNumber: otpData?.mobileNumber??"",
                      otp: otpData?.otp??""
                  ));
            },
            title: 'verifyOtp'.tr,
          ),
        )
      ],
    );
  }
}
