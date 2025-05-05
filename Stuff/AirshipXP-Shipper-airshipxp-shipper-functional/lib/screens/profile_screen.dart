import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/components/constants.dart';
import 'package:airshipxp_shipper/controllers/profile_controller.dart';
import 'package:airshipxp_shipper/screens/login_screen.dart';
import 'package:airshipxp_shipper/screens/notification_screen.dart';
import 'package:airshipxp_shipper/screens/profile_details.dart';
import 'package:airshipxp_shipper/screens/report_issue.dart';
import 'package:airshipxp_shipper/screens/wallet_screen.dart';
import 'package:airshipxp_shipper/utilities/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../local_database/local_db_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.find();
  RxString appVersion = "".obs;

  @override
  void initState() {
    getAppVersion();
    super.initState();
  }

  getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
    print(appVersion.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'myProfile'.tr,
        leading: false,
      ),
      body: Obx(
        () => profileController.loadingData.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : Column(children: [
                InkWell(
                  onTap: () {
                    Get.to(() => ProfileDetails());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        profileController.profileData.value['data']
                                    ?['imagepath'] !=
                                null
                            ? CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                  '$baseUrl${profileController.profileData.value['data']['imagepath']}',
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${profileController.firstName.text ?? ""} ${profileController.lastName.text ?? ""}',
                              style: kText16w500,
                            ),
                            Text(
                              profileController.email.text ?? "",
                              style: kText16w500.copyWith(
                                  fontWeight: FontWeight.w400, color: grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      LinksContainer(
                        title: 'wallet'.tr,
                        onPressed: () {
                          Get.to(() => WalletScreen());
                        },
                      ),
                      LinksContainer(
                        title: 'support'.tr,
                        onPressed: () {
                          Get.to(() => ReportIssue());
                        },
                      ),
                      LinksContainer(
                        title: 'notification'.tr,
                        onPressed: () {
                          Get.to(() => NotificationScreen(
                                isFromBottomTab: false,
                              ));
                        },
                      ),
                      LinksContainer(
                        title: 'logout'.tr,
                        onPressed: () async {
                          await (SessionManager().onLogout().then((value) {
                            DatabaseHelper.deleteAddress();
                            Get.offAll(() => const LoginScreen());
                          }));
                        },
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Text(
                    appVersion.value != "" ? "Version ${appVersion.value}" : "",
                    style: kText12w300,
                  ),
                ),
                const SizedBox(
                  height: 8,
                )
              ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class LinksContainer extends StatelessWidget {
  LinksContainer({super.key, required this.title, this.onPressed});

  String title;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          border: BorderDirectional(bottom: BorderSide(color: greyOp1)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: kText16w500,
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
