import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/authenticate_controller.dart';
import 'package:airshipxp_shipper/screens/personal_info.dart';
import 'package:airshipxp_shipper/screens/terms_and_conditions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountWelcome extends StatefulWidget {
  const CreateAccountWelcome({super.key});

  @override
  State<CreateAccountWelcome> createState() => _CreateAccountWelcomeState();
}

class _CreateAccountWelcomeState extends State<CreateAccountWelcome> {
  RxBool isProfileCreated = false.obs;
  final AuthenticateController authController =
      Get.put(AuthenticateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/welcome.png',
              height: 235,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'welcome'.tr,
              style: kText40w700,
            ),
            Text(
              'requiredSteps'.tr,
              style: kText18w400,
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => StepsContainer(
                title: 'personalInfo'.tr,
                onTap: () async {
                  if (isProfileCreated.value == false) {
                    var res = await Get.to(() => PersonalInformation());
                    if (res == "Success") {
                      isProfileCreated.value = true;
                    }
                  }
                },
                uploaded: isProfileCreated.value,
              ),
            ),
            const Seperator(),
            Obx(
              () => AbsorbPointer(
                absorbing: isProfileCreated.value == true ? false : true,
                child: StepsContainer(
                  title: 'termsNConditions'.tr,
                  onTap: () {
                    Get.to(() => TermsAndConditions());
                  },
                  uploaded: false,
                ),
              ),
            ),
          ],
        ),
      )),
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
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.green),
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
