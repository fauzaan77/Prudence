import 'dart:io';

import 'package:airshipxp_shipper/components/customToast.dart';
import 'package:airshipxp_shipper/models/login_with_email_response.dart';
import 'package:airshipxp_shipper/models/registration_response.dart';
import 'package:airshipxp_shipper/models/send_otp_response.dart';
import 'package:airshipxp_shipper/models/verify_otp_response.dart';
import 'package:airshipxp_shipper/screens/create_account_welcome.dart';
import 'package:airshipxp_shipper/screens/home_screen.dart';
import 'package:airshipxp_shipper/screens/otp_screen.dart';
import 'package:airshipxp_shipper/screens/terms_and_conditions.dart';
import 'package:airshipxp_shipper/utilities/network_services/api_param.dart';
import 'package:airshipxp_shipper/utilities/network_services/network_client.dart';
import 'package:airshipxp_shipper/utilities/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

import '../utilities/network_services/api_endpoints.dart';

class AuthenticateController extends NetworkClient {
  RxBool personalInfo = false.obs;
  RxBool uploadPhoto = false.obs;
  RxBool bankDetails = false.obs;
  RxBool termsNConditions = false.obs;
  RxBool agree = false.obs;
  File? _image;
  RxString countrycode = '+1'.obs;
  RxString otp = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isEmail = false.obs;
  RxBool showPass = true.obs;
  bool isPersonalInfo = false;
  RxBool showRegPassword = true.obs;
  RxBool showRegConfirmPassword = true.obs;

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController branchNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();

  sendOtp() async {
    Map<String, Object> data = {};
    data[ApiParams.countrycode] = countrycode.value.toString();
    data[ApiParams.phone] = phoneNumberController.text.toString();

    SendOtpResponse sendOtpResponse;
    isLoading.value = true;
    print(data);
    post(ApiEndPoints.sendShipperOtp, data).then((value) {
      sendOtpResponse = sendOtpResponseFromJson(value.toString());

      if (sendOtpResponse.status == 200) {
        isLoading.value = false;
        Get.to(() => OtpScreen(),
            arguments: '${countrycode.value}${phoneNumberController.text}');
      } else {
        isLoading.value = false;
        print(sendOtpResponse.message);
        CustomToast.show(sendOtpResponse.message!);
        Get.to(() => CreateAccountWelcome());
      }
    }).catchError((onError) {
      print(onError);
      isLoading.value = false;
    });
  }

  verifyOtp() async {
    Map<String, Object> data = {};
    data[ApiParams.countrycode] = countrycode.value.toString();
    data[ApiParams.phone] = phoneNumberController.text.toString();
    data[ApiParams.otp] = otpController.text;

    VerifyOtpResponse verifyOtpResponse;
    isLoading.value = true;
    print(data);
    post(ApiEndPoints.verifyShipperOtp, data).then((value) async {
      verifyOtpResponse = verifyOtpResponseFromJson(value.toString());

      if (verifyOtpResponse.status == 200) {
        (SessionManager().setString(
            SessionManager.userToken, verifyOtpResponse.data?.token ?? ""));
        Get.offAll(() => HomeScreen());
        // commonController.setupPushNotification().then((value) {
        //   Get.offAll(() => BottomTabNavigator());
        // });
        isLoading.value = false;
      } else {
        isLoading.value = false;
        print(verifyOtpResponse.message);
        CustomToast.show(verifyOtpResponse.message!);
      }
    }).catchError((onError) {
      print(onError);
      isLoading.value = false;
    });
  }

  loginWithEmail() async {
    Map<String, Object> data = {};
    data[ApiParams.email] = emailController.text.toString();
    data[ApiParams.password] = passwordController.text.toString();

    LoginWithEmailResponse loginWithEmailResponse;
    isLoading.value = true;
    print(data);
    post(ApiEndPoints.shipperAuthenticate, data).then((value) async {
      loginWithEmailResponse = loginWithEmailResponseFromJson(value.toString());

      if (loginWithEmailResponse.status == 200) {
        isLoading.value = false;
        (SessionManager().setString(SessionManager.userToken,
            loginWithEmailResponse.data?.token ?? ""));
        Get.offAll(() => HomeScreen());
      } else {
        isLoading.value = false;
        CustomToast.show(loginWithEmailResponse.message!);
        Get.to(() => CreateAccountWelcome());
      }
    }).catchError((onError) {
      print(onError);
      isLoading.value = false;
    });
  }

  register() async {
    Map<String, Object> data = {};
    data[ApiParams.firstname] = firstnameController.text.toString();
    data[ApiParams.lastname] = lastnameController.text.toString();
    data[ApiParams.email] = emailController.text.toString();
    data[ApiParams.countrycode] = countrycode.value.toString();
    data[ApiParams.phone] = phoneNumberController.text.toString();
    data[ApiParams.address] = addressController.text.toString();
    data[ApiParams.password] = passwordController.text.toString();

    print(data);

    RegistrationResponse registrationResponse;
    isLoading.value = true;
    print(data);
    return post(ApiEndPoints.createshipper, data).then((value) {
      registrationResponse = registrationResponseFromJson(value.toString());

      if (registrationResponse.status == 200) {
        isLoading.value = false;

        (SessionManager().setString(
            SessionManager.userToken, registrationResponse.data?.token ?? ""));
        return "Success";
      } else {
        isLoading.value = false;
        print(registrationResponse.message);
        CustomToast.show(registrationResponse.message!);
        return 'failed';
      }
    }).catchError((onError) {
      print(onError);
      isLoading.value = false;
      return 'failed';
    });
  }
}
