import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticateController extends GetxController {
  RxBool personalInfo = false.obs;
  RxBool uploadPhoto = false.obs;
  RxBool bankDetails = false.obs;
  RxBool termsNConditions = false.obs;
  RxBool agree = false.obs;
  File? _image;
  RxString countrycode = 'In'.obs;
  RxString otp = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isEmail = false.obs;
  RxBool showPass = true.obs;


  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController branchNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
}
