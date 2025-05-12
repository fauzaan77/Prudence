import 'dart:convert';

import 'package:airship_carrier/backend/api_provider.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/models/personal_info_data_model.dart';
import 'package:airship_carrier/screens/home_screen.dart';
import 'package:airship_carrier/screens/login_screen.dart';
import 'package:airship_carrier/screens/my_packages.dart';
import 'package:airship_carrier/screens/notifications.dart';
import 'package:airship_carrier/screens/profileSetup/personal_info.dart';
import 'package:airship_carrier/screens/reports.dart';
import 'package:airship_carrier/screens/source_city.dart';
import 'package:airship_carrier/util/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final SessionManager sessionManager = SessionManager();
  String version = "";
  @override
  Widget build(BuildContext context) {
    return Drawer(
        clipBehavior: Clip.none,
        width: double.infinity,
        child: Scaffold(
          backgroundColor: screenBg,
          appBar: CustomAppBar(
            titleText: 'profile'.tr,
            leading: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomBox(
                    bgColor: Colors.transparent,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>PersonalInformation(personalInfoDataModel: personalInfoDataModel)));
                    },
                    link: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (personalInfoDataModel?.imagepath != null)
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage:
                            NetworkImage("${ApiProvider.image_base_url}${personalInfoDataModel?.imagepath}"),
                            backgroundColor: Colors.transparent,
                          ),
                          // Image.network(
                          //     "${ApiProvider.image_base_url}${personalInfoDataModel?.imagepath}" ??
                          //         "",
                          //     height: 70,
                          //     width: 70),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${personalInfoDataModel?.firstname} ${personalInfoDataModel?.lastname}",
                              style: kText18w600,
                            ),
                            Text(
                              personalInfoDataModel?.phone ?? "",
                              style: kText18w400,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomBox(
                    shadow: true,
                    link: false,
                    child: Column(
                      children: [
                        ProfileLinkContainer(
                          label: 'home'.tr,
                          icon: Icons.home,
                          onTap: () {
                            // _key.currentState?.closeDrawer();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>HomeScreen()),(route) => true,);
                            // Get.off(() => HomeScreen());
                          },
                        ),
                        ProfileLinkContainer(
                          label: 'myOrders'.tr,
                          icon: Icons.history,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>const MyPackages()));
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomBox(
                    shadow: true,
                    link: false,
                    child: Column(
                      children: [
                        ProfileLinkContainer(
                          label: 'notifications'.tr,
                          icon: Icons.notifications_none_rounded,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationScreen()));
                          },
                        ),
                        ProfileLinkContainer(
                          label: 'addTravelIterery'.tr,
                          icon: Icons.edit_outlined,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>PickupCityScreen()));
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomBox(
                    shadow: true,
                    link: false,
                    child: Column(
                      children: [
                        ProfileLinkContainer(
                          label: 'faqs'.tr,
                          icon: Icons.question_mark_sharp,
                          onTap: () {},
                        ),
                        ProfileLinkContainer(
                          label: 'reports'.tr,
                          icon: Icons.report_gmailerrorred_outlined,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>const ReportScreen()));
                          },
                        ),
                        ProfileLinkContainer(
                          label: 'settings'.tr,
                          icon: Icons.settings,
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomBox(
                    shadow: true,
                    link: false,
                    child: ProfileLinkContainer(
                      label: 'logout'.tr,
                      icon: Icons.home,
                      onTap: () {
                        sessionManager.setBool(SessionManager.IS_LOGGED_IN, false);
                        Navigator.of(context,rootNavigator: true).
                        pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>LoginScreen()), (route) => true);
                        // Get.offAll(() => LoginScreen());
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("App Version : $version",style: kText18w600)
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  SharedPreferences? prefs;
  PersonalInfoDataModel? personalInfoDataModel;

  void getData() async {
    prefs = await SharedPreferences.getInstance();
    String? profileData = prefs?.getString(SessionManager.USER_DATA);
    print("ACSLMSKD $profileData");
    personalInfoDataModel =
        PersonalInfoDataModel.fromJson(jsonDecode(profileData ?? ""));
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    version = packageInfo.version;

    setState(() {});
  }
}

class ProfileLinkContainer extends StatelessWidget {
  ProfileLinkContainer(
      {super.key,
      required this.label,
      required this.icon,
      required this.onTap});

  String label;
  IconData icon;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      padding: const EdgeInsets.all(10),
      link: true,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomBox(
                padding: const EdgeInsets.all(5),
                onTap: onTap,
                link: false,
                decoration: const BoxDecoration(
                  color: profileLinkIcon,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                label,
                style: kText16w500,
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
        ],
      ),
    );
  }
}
