import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/components/countryPicker.dart';
import 'package:airshipxp_shipper/components/customToast.dart';
import 'package:airshipxp_shipper/controllers/authenticate_controller.dart';
import 'package:airshipxp_shipper/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final GlobalKey<FormState> _personalInfoKey = GlobalKey<FormState>();
  final AuthenticateController authController =
      Get.put(AuthenticateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'yourPersonalInfo'.tr,
        leading: true,
      ),
      body: Obx(
        () => authController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : Form(
                key: _personalInfoKey,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          kToolbarHeight),
                  child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextInputBox(
                                outlineBorder: true,
                                validationType: 'firstName',
                                controller: authController.firstnameController,
                                onValueChange: (value) {},
                                placeHolder: 'firstname'.tr,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextInputBox(
                                outlineBorder: true,
                                validationType: 'lastname',
                                controller: authController.lastnameController,
                                onValueChange: (value) {},
                                placeHolder: 'lastname'.tr,
                              ),
                            ),
                          ],
                        ),
                        Seperator(),
                        TextInputBox(
                          outlineBorder: true,
                          validationType: 'email',
                          controller: authController.emailController,
                          onValueChange: (value) {},
                          placeHolder: 'emailAddress'.tr,
                          keyboardType: 'email',
                        ),
                        Seperator(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  authController.countrycode.value = value;
                                  // });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextInputBox(
                                controller:
                                    authController.phoneNumberController,
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
                        Seperator(),
                        TextInputBox(
                          outlineBorder: true,
                          validationType: 'address',
                          controller: authController.addressController,
                          onValueChange: (value) {},
                          placeHolder: 'address'.tr,
                        ),
                        Seperator(),
                        Obx(
                          () => TextInputBox(
                            outlineBorder: true,
                            validationType: 'password',
                            controller: authController.passwordController,
                            onValueChange: (value) {},
                            placeHolder: 'password'.tr,
                            typePassword: true,
                            obscureText: authController.showRegPassword.value,
                            onEyePress: () {
                              authController.showRegPassword.value =
                                  !authController.showRegPassword.value;
                            },
                          ),
                        ),
                        Seperator(),
                        Obx(
                          () => TextInputBox(
                            outlineBorder: true,
                            validationType: 'password',
                            controller:
                                authController.confirmPasswordController,
                            onValueChange: (value) {},
                            placeHolder: 'confirmPassword'.tr,
                            typePassword: true,
                            obscureText:
                                authController.showRegConfirmPassword.value,
                            onEyePress: () {
                              authController.showRegConfirmPassword.value =
                                  !authController.showRegConfirmPassword.value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        ButtonPrimary(
                          onPressed: () async {
                            if (_personalInfoKey.currentState!.validate() &&
                                authController.confirmPasswordController.text ==
                                    authController.passwordController.text) {
                              var res = await authController.register();
                              if (res == "Success") {
                                Get.back(result: res);
                              }
                            } else if (authController
                                    .confirmPasswordController.text !=
                                authController.passwordController.text) {
                              CustomToast.show(
                                  "Password & Confirm password doesn't match.");
                            } else {
                              CustomToast.show(
                                  "Please fill all details to continue");
                            }
                          },
                          title: 'next'.tr,
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        )
                      ]),
                ),
              ),
      ),
    );
  }
}
