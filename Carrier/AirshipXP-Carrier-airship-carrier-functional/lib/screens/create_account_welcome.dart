import 'package:airship_carrier/bloc/create_account_welcome/create_acc_wel_bloc.dart';
import 'package:airship_carrier/bloc/create_account_welcome/create_acc_wel_event.dart';
import 'package:airship_carrier/bloc/create_account_welcome/create_acc_wel_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/screens/profileSetup/social_security_num.dart';
import 'package:airship_carrier/screens/profileSetup/bank_account_details.dart';
import 'package:airship_carrier/screens/profileSetup/drivingLicenseFrontImage.dart';
import 'package:airship_carrier/screens/profileSetup/passport_details.dart';
import 'package:airship_carrier/screens/profileSetup/personal_info.dart';
import 'package:airship_carrier/screens/profileSetup/terms_and_conditions.dart';
import 'package:airship_carrier/screens/profileSetup/upload_profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CreateAccountWelcome extends StatelessWidget {
  CreateAccountWelcome({super.key,this.isPersonalInfoSaved = false});

  bool isPersonalInfoSaved;
  bool? isDrivingLiceSaved;
  bool? isProfilePhotoSaved;
  bool? isBankDetailsSaved;
  bool? isSocialSecuritySaved;
  bool? isPassportSaved;

  CreateAccWelcomeBloc _accWelcomeBloc = CreateAccWelcomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: BlocProvider(
          create: (BuildContext context) => _accWelcomeBloc,
          child: BlocListener<CreateAccWelcomeBloc, CreateAccWelcomeState>(
            listener: (BuildContext bListenerCtx, state) {},
            child: BlocBuilder<CreateAccWelcomeBloc, CreateAccWelcomeState>(
                builder: (blocCtx, state) {
              return Stack(
                children: [
                  if (state is CreateAccWelcomeSetDataState)
                    CreateUI(blocCtx, state, context),
                ],
              );
            }),
          ),
        ),
      )),
    );
  }

  Widget CreateUI(BuildContext blocCtx, CreateAccWelcomeSetDataState state,
      BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Image.asset(
              'assets/images/welcome.png',
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'welcome'.tr,
            style: kText18w700,
          ),
          Text(
            'requiredSteps'.tr,
            style: kText14w400,
          ),
          const SizedBox(
            height: 20,
          ),
          StepsContainer(
            title: 'personalInfo'.tr,
            onTap: () {
              if (state.isPersonalInfoSaved == false && isPersonalInfoSaved == false) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PersonalInformation())).then((value) {
                  if (value != null) {
                    BlocProvider.of<CreateAccWelcomeBloc>(blocCtx).add(
                        CreateAccWelcomeDataEvent(
                            isPersonalInfoSaved: true,
                            isSocialSecuritySaved: false,
                            isProfilePhotoSaved: false,
                            isPassportSaved: false,
                            isDrivingLiceSaved: false,
                            isBankDetailsSaved: false));
                  }
                });
              }
            },
            uploaded: (state.isPersonalInfoSaved??false) || (isPersonalInfoSaved ??false),
          ),
          const Seperator(),
          StepsContainer(
            title: 'drivingLicense'.tr,
            onTap: () {
              if (state.isPersonalInfoSaved == true || isPersonalInfoSaved == true) {
                if (state.isDrivingLiceSaved == false) {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DrivingLicenseFrontImage()))
                      .then((value) {
                    if (value == true) {
                      BlocProvider.of<CreateAccWelcomeBloc>(blocCtx).add(
                          CreateAccWelcomeDataEvent(
                              isPersonalInfoSaved: true,
                              isDrivingLiceSaved: true,
                              isSocialSecuritySaved: false,
                              isProfilePhotoSaved: false,
                              isPassportSaved: false,
                              isBankDetailsSaved: false));
                    }
                  });
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please fill personal info first"),
                  ),
                );
              }
            },
            uploaded: state.isDrivingLiceSaved ?? false,
          ),
          const Seperator(),
          StepsContainer(
            title: 'uploadProfilePhoto'.tr,
            onTap: () {
              if (state.isDrivingLiceSaved == true) {
                if (state.isProfilePhotoSaved == false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => UploadProfilePhoto())).then((value) {
                    if (value == true) {
                      BlocProvider.of<CreateAccWelcomeBloc>(blocCtx).add(
                          CreateAccWelcomeDataEvent(
                              isPersonalInfoSaved: true,
                              isDrivingLiceSaved: true,
                              isProfilePhotoSaved: true,
                              isBankDetailsSaved: false,
                              isSocialSecuritySaved: false,
                              isPassportSaved: false));
                    }
                  });
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please fill Driving License details"),
                  ),
                );
              }
            },
            uploaded: state.isProfilePhotoSaved ?? false,
          ),
          const Seperator(),
          StepsContainer(
            title: 'bankDetails'.tr,
            onTap: () {
              if (state.isProfilePhotoSaved == true) {
                if (state.isBankDetailsSaved == false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BankAccountDetails())).then((value) {
                    if (value == true) {
                      BlocProvider.of<CreateAccWelcomeBloc>(blocCtx).add(
                          CreateAccWelcomeDataEvent(
                              isPersonalInfoSaved: true,
                              isDrivingLiceSaved: true,
                              isBankDetailsSaved: true,
                              isProfilePhotoSaved: true,
                              isSocialSecuritySaved: false,
                              isPassportSaved: false));
                    }
                  });
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please upload profile photo"),
                  ),
                );
              }
            },
            uploaded: state.isBankDetailsSaved ?? false,
          ),
          const Seperator(),
          StepsContainer(
            title: 'enterSocialSecurity'.tr,
            onTap: () {
              if (state.isBankDetailsSaved == true) {
                if (state.isSocialSecuritySaved == false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SocialSecurityNum())).then((value) {
                    if (value == true) {
                      BlocProvider.of<CreateAccWelcomeBloc>(blocCtx).add(
                          CreateAccWelcomeDataEvent(
                              isPersonalInfoSaved: true,
                              isDrivingLiceSaved: true,
                              isProfilePhotoSaved: true,
                              isBankDetailsSaved: true,
                              isSocialSecuritySaved: true,
                              isPassportSaved: false));
                    }
                  });
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please fill bank details"),
                  ),
                );
              }
            },
            uploaded: state.isSocialSecuritySaved ?? false,
          ),
          const Seperator(),
          StepsContainer(
            title: 'enterPassportDetails'.tr,
            onTap: () {
              if (state.isSocialSecuritySaved == true) {
                if (state.isPassportSaved == false) {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (_) => PassportDetails()))
                      .then((value) {
                    if (value == true) {
                      BlocProvider.of<CreateAccWelcomeBloc>(blocCtx)
                          .add(CreateAccWelcomeDataEvent(
                        isPersonalInfoSaved: true,
                        isDrivingLiceSaved: true,
                        isProfilePhotoSaved: true,
                        isBankDetailsSaved: true,
                        isSocialSecuritySaved: true,
                        isPassportSaved: true,
                      ));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TermsAndConditions()));
                    }
                  });
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please submit social security number"),
                  ),
                );
              }
            },
            uploaded: state.isPassportSaved ?? false,
          ),
          // SizedBox(height: 15.0),
          /*state.isPersonalInfoSaved == true ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
            child: ButtonPrimary(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TermsAndConditions()));
              },
              title: 'Continue',
            ),
          ):const SizedBox()*/
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class StepsContainer extends StatelessWidget {
  StepsContainer({
    super.key,
    required this.title,
    required this.onTap,
    required this.uploaded,
  });

  String title;
  VoidCallback onTap;
  bool uploaded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: greyOp2),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              const Icon(
                Icons.upload_file_sharp,
                color: greyOp5,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: kText16w500.copyWith(
                  fontWeight: FontWeight.w400,
                  color: greyOp5,
                ),
              ),
            ],
          ),
          if (uploaded)
            Container(
              padding: const EdgeInsets.all(6),
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: green),
              child: const Icon(
                Icons.done,
                size: 30,
                color: white,
              ),
            )
        ]),
      ),
    );
  }
}
