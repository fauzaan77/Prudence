import 'dart:io';

import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/components/constants.dart';
import 'package:airshipxp_shipper/components/countryPicker.dart';
import 'package:airshipxp_shipper/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: profileController.backButtonPress,
      child: Obx(() => profileController.loadingData.value == true
          ? Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "profileDetails".tr,
                  style: kText24w600,
                ),
                centerTitle: true,
                leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 22,
                      color: black,
                    ),
                    onPressed: () {
                      profileController.backButtonPress;
                      Get.back();
                    }),
              ),
              body: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'personalInformation'.tr,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 26),
                                child: Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Obx(
                                          () => profileController
                                                      .temporaryImage.value ==
                                                  ""
                                              ? CircleAvatar(
                                                  radius: 40.0,
                                                  backgroundColor: lightGrey,
                                                  backgroundImage: NetworkImage(
                                                    '$baseUrl${profileController.profileData.value['data']?['imagepath']}',
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey.shade300,
                                                  radius: 40.0,
                                                  child: ClipOval(
                                                    child: Image.file(
                                                      File(profileController
                                                          .temporaryImage
                                                          .value),
                                                      width: 120,
                                                      height: 120,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                        Positioned(
                                            bottom: -12,
                                            right: -12,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                profileController
                                                    .showPickFromBottomSheet(
                                                        context);
                                              },
                                              constraints: const BoxConstraints(
                                                  minWidth: 30.0,
                                                  minHeight: 30.0),
                                              elevation: 2.0,
                                              fillColor: darkBlue,
                                              shape: CircleBorder(),
                                              padding: EdgeInsets.all(2.0),
                                              child: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: 18.0,
                                              ),
                                            )),
                                      ],
                                    ),
                                    // CircleAvatar(
                                    //   radius: 35,
                                    //   backgroundImage: NetworkImage(
                                    //     '${BASE_URL}${accountController.profileData.value['data']['imagepath']}',
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            '${profileController.firstName.text} ${profileController.lastName.text}',
                                            style: kText22w600,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            '${profileController.countryCode.text} ${profileController.phone.text}',
                                            style: kText18w400,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: inActiveGrey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextInputBox(
                                        outlineBorder: true,
                                        radius: BorderRadius.circular(10),
                                        controller: profileController.firstName,
                                        onValueChange: (value) {
                                          print(value);
                                        },
                                        placeHolder: 'fName'.tr,
                                        isEnabled: false,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: inActiveGrey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextInputBox(
                                        controller: profileController.lastName,
                                        onValueChange: (value) {
                                          print(value);
                                        },
                                        placeHolder: 'lName'.tr,
                                        isEnabled: false,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Seperator16(),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: inActiveGrey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextInputBox(
                                  controller: profileController.email,
                                  onValueChange: (value) {
                                    print(value);
                                  },
                                  placeHolder: 'emailAddress'.tr,
                                  isEnabled: false,
                                ),
                              ),
                              Seperator16(),
                              Row(
                                children: [
                                  CustomBox(
                                    height: 64,
                                    width: 75,
                                    alignment: Alignment.center,
                                    borderColor: greyOp2,
                                    link: false,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AbsorbPointer(
                                          child: CountryPicker(
                                            initialSelection: profileController
                                                .countryCode.text,
                                            isShowDownIcon: false,
                                            arrowDownIconColor: Colors.black54,
                                            onCountryCodeChange: (value) {
                                              profileController
                                                  .countryCode.text = value;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: inActiveGrey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextInputBox(
                                        controller: profileController.phone,
                                        onValueChange: (value) {
                                          print(value);
                                        },
                                        placeHolder: 'phoneNumber'.tr,
                                        isEnabled: false,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Seperator16(),
                              // OptionButton(
                              //   onTap: () {
                              //     showAlertDialog(context);
                              //   },
                              //   title: 'deleteAccount'.tr,
                              //   description: 'deleteAccountDesc'.tr,
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(16),
                          child: ButtonPrimary(
                              onPressed: () {
                                profileController.updateProfileDetails();
                              },
                              title: 'update'.tr),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        'cancel'.tr,
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text('confirm'.tr, style: TextStyle(color: Colors.black)),
      onPressed: () {
        // profileController.onDeleteAccount();
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        'deleteAccount'.tr,
        style: TextStyle(color: Colors.black),
      ),
      content: Text('areYouSureYouWantToDeleteYourAccount'.tr,
          style: TextStyle(color: Colors.black)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class OptionButton extends StatelessWidget {
  OptionButton({
    required this.onTap,
    required this.title,
    required this.description,
    super.key,
  });

  VoidCallback onTap;
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: inActiveGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: kText18w700.copyWith(color: Color(0xFF012B49)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  description,
                  style: kText14w400.copyWith(color: inActiveGreyText),
                )
              ],
            ),
            Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      ),
    );
  }
}

class Seperator16 extends StatelessWidget {
  const Seperator16({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 16,
    );
  }
}
