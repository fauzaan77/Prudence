import 'dart:convert';

import 'package:airship_carrier/bloc/auth/mobile_login_bloc.dart';
import 'package:airship_carrier/bloc/auth/mobile_login_event.dart';
import 'package:airship_carrier/bloc/auth/mobile_login_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/screens/create_account_welcome.dart';
import 'package:airship_carrier/screens/home_screen.dart';
import 'package:airship_carrier/screens/otp_screen.dart';
import 'package:airship_carrier/util/shared_pref.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final MobileLoginBloc _mobileLoginBloc = MobileLoginBloc();
  final TextEditingController _mobileTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  String phoneCode = "+91";
  String countryCode = "IN";
  SessionManager sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: true,
        child: BlocProvider(
          create: (_) => _mobileLoginBloc,
          child: BlocListener<MobileLoginBloc, MobileLoginStateA>(
            listener: (BuildContext bCtx, MobileLoginStateA state) {
              if (state is MobileLoginStateError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message ?? ""),
                  ),
                );
                if (state.code == 400) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CreateAccountWelcome()));
                }
              }
              if (state is EmailLoginSuccess) {
                if (state.personalInfoDataModel != null) {
                  sessionManager.setString(SessionManager.USER_DATA, jsonEncode(state.personalInfoDataModel));
                  if (state.personalInfoDataModel?.isdocumentsubmitted == true) {
                    sessionManager.setBool(SessionManager.IS_LOGGED_IN, true);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false,
                    );
                  } else {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => CreateAccountWelcome(isPersonalInfoSaved: true)),
                      (route) => false,
                    );
                  }
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => CreateAccountWelcome()),
                    (route) => false,
                  );
                }
              }
              if (state is MobileLoginStateResponse) {
                state.otpData.mobileNumber = _mobileTextController.text;
                state.otpData.countryCode = phoneCode;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpScreen(
                      otpData: state.otpData,
                      emailId: _emailTextController.text.isEmpty ? null : _emailTextController.text,
                    ),
                  ),
                ).then((value) {
                  _emailTextController.text = "";
                  BlocProvider.of<MobileLoginBloc>(bCtx).add(
                    MobileLoginChangeEvent(isEmail: false, countryCode: countryCode),
                  );
                });
              }
            },
            child: BlocBuilder<MobileLoginBloc, MobileLoginStateA>(
              builder: (blocBuilderCtx, state) {
                if (state is MobileLoginStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is MobileLoginChangeState) {
                  return state.isEmail ? _buildLoginWithEmail(blocBuilderCtx) : _buildLoginWithPhone(blocBuilderCtx, state);
                }
                return SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginWithPhone(BuildContext context, MobileLoginChangeState state) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('letsStart'.tr, style: kText20w500),
                  Text('phone'.tr, style: kText32w700),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomBox(
                        height: 64,
                        width: 60,
                        alignment: Alignment.center,
                        borderColor: greyOp2,
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: true,
                            onSelect: (value) {
                              phoneCode = value.phoneCode;
                              countryCode = value.countryCode;
                              BlocProvider.of<MobileLoginBloc>(context).add(
                                MobileLoginChangeEvent(
                                  isEmail: false,
                                  countryCode: value.countryCode,
                                ),
                              );
                            },
                          );
                        },
                        link: true,
                        child: Image.asset(
                          'assets/images/usa.png',
                          height: 35,
                          width: 35,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextInputBox(
                          outlineBorder: true,
                          controller: _mobileTextController,
                          radius: BorderRadius.circular(10),
                          onValueChange: (value) {},
                          placeHolder: 'phoneNumber'.tr,
                          validationType: 'phoneNumber',
                          keyboardType: 'number',
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButtonPrimary(
                      label: 'loginWithEmail'.tr,
                      color: pinBg,
                      onPressed: () {
                        BlocProvider.of<MobileLoginBloc>(context).add(
                          MobileLoginChangeEvent(
                            isEmail: true,
                            countryCode: countryCode,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ButtonPrimary(
                onPressed: () {
                  BlocProvider.of<MobileLoginBloc>(context).add(
                    SendOtpEvent(
                      mobileNumber: _mobileTextController.text,
                      countryCode: phoneCode,
                    ),
                  );
                },
                title: 'getOtp'.tr,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLoginWithEmail(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('letsStart'.tr, style: kText20w500),
                  Text('emailTitle'.tr, style: kText32w700),
                  const SizedBox(height: 20),
                  TextInputBox(
                    outlineBorder: true,
                    radius: BorderRadius.circular(10),
                    controller: _emailTextController,
                    onValueChange: (value) {},
                    placeHolder: 'emailAddress'.tr,
                    validationType: 'email',
                    keyboardType: 'email',
                  ),
                  SizedBox(height: 10),
                  TextInputBox(
                    outlineBorder: true,
                    radius: BorderRadius.circular(10),
                    controller: _passwordTextController,
                    onValueChange: (value) {},
                    placeHolder: 'password'.tr,
                    obscureText: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButtonPrimary(
                      label: 'loginWithPhone'.tr,
                      color: pinBg,
                      onPressed: () {
                        BlocProvider.of<MobileLoginBloc>(context).add(
                          MobileLoginChangeEvent(
                            isEmail: false,
                            countryCode: countryCode,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ButtonPrimary(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<MobileLoginBloc>(context).add(
                      SendEmailOtpEvent(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      ),
                    );
                  }
                },
                title: 'login'.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
