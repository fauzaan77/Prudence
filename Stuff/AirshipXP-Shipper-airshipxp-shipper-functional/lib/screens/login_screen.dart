import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/components/countryPicker.dart';
import 'package:airshipxp_shipper/controllers/authenticate_controller.dart';
import 'package:airshipxp_shipper/screens/create_account_welcome.dart';
import 'package:airshipxp_shipper/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthenticateController authController =
      Get.put(AuthenticateController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => authController.isEmail.value
          ? _buildLoginWithEmail(context)
          : _buildLoginWithPhone(context),
    );
  }

  Widget _buildLoginWithPhone(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'login'.tr,
      ),
      body: Obx(
        () => authController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
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
                            height: Get.height * 0.5,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'letsStart'.tr,
                                    style: kText22w600.copyWith(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    'phone'.tr,
                                    style: kText32w700,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomBox(
                                        height: 64,
                                        width: 60,
                                        alignment: Alignment.center,
                                        borderColor: greyOp2,
                                        link: false,
                                        child: CountryPicker(
                                          isShowDownIcon: false,
                                          // arrowDownIconColor: Colors.black,
                                          onCountryCodeChange: (value) {
                                            authController.countrycode.value =
                                                value;
                                            // });
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: TextInputBox(
                                          controller: authController
                                              .phoneNumberController,
                                          outlineBorder: true,
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
                                        authController.isEmail.value =
                                            !authController.isEmail.value;
                                      },
                                    ),
                                  ),
                                ]),
                          ),
                          ButtonPrimary(
                            onPressed: () {
                              if (_formKey.currentState!.validate() == true) {
                                authController.sendOtp();
                              }
                            },
                            title: 'getOtp'.tr,
                          ),
                          const SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildLoginWithEmail(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'login'.tr,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                    height: Get.height * 0.5,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'letsStart'.tr,
                            style: kText22w600.copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            'emailTitle'.tr,
                            style: kText32w700,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextInputBox(
                            controller: authController.emailController,
                            outlineBorder: true,
                            radius: BorderRadius.circular(10),
                            // inputDecoration: InputDecoration(
                            //   hintText: 'enterPhone'.tr,
                            //   border: const OutlineInputBorder(),
                            // ),
                            onValueChange: (value) {},
                            placeHolder: 'emailAddress'.tr,
                            validationType: 'email',
                            keyboardType: 'email',
                          ),
                          Seperator(),
                          TextInputBox(
                            controller: authController.passwordController,
                            outlineBorder: true,
                            radius: BorderRadius.circular(10),
                            // inputDecoration: InputDecoration(
                            //   hintText: 'enterPhone'.tr,
                            //   border: const OutlineInputBorder(),
                            // ),
                            onValueChange: (value) {},
                            placeHolder: 'password'.tr,
                            validationType: 'password',
                            typePassword: true,
                            obscureText: authController.showPass.value,
                            onEyePress: () {
                              authController.showPass.value =
                                  !authController.showPass.value;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButtonPrimary(
                              label: 'loginWithPhone'.tr,
                              color: pinBg,
                              onPressed: () {
                                authController.isEmail.value =
                                    !authController.isEmail.value;
                              },
                            ),
                          ),
                        ]),
                  ),
                  ButtonPrimary(
                    onPressed: () {
                      // print(authController.emailController.text);
                      // print(authController.passwordController.text);
                      if (_formKey.currentState!.validate() == true) {
                        authController.loginWithEmail();
                      }
                    },
                    title: 'login'.tr,
                  ),
                  const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
