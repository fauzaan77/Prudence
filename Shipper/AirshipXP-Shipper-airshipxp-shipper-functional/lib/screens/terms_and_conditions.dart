import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/authenticate_controller.dart';
import 'package:airshipxp_shipper/screens/success_account_creation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  final AuthenticateController accountCreateController = Get.find();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'termsNConditions'.tr,
        leading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                'loremTextBrief'.tr,
                style: kText18w400.copyWith(color: grey, height: 1.7),
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Obx(
              () => ListTile(
                horizontalTitleGap: 0,
                contentPadding: EdgeInsets.all(0),
                leading: Checkbox(
                  onChanged: (value) {
                    accountCreateController.agree.value = value!;
                  },
                  fillColor: accountCreateController.agree.value
                      ? MaterialStateProperty.all(Colors.black)
                      : MaterialStateProperty.all(Colors.transparent),
                  value: accountCreateController.agree.value,
                ),
                title: Text(
                  'iHereby'.tr,
                  style: kText18w400,
                ),
                onTap: () {
                  accountCreateController.agree.value =
                      !accountCreateController.agree.value;
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ButtonPrimary(
                  onPressed: () {
                    if (accountCreateController.agree.value == true) {
                      Get.to(() => SuccessAccountCreation());
                    } else {
                      Get.snackbar(
                          'Pls Agree T&C', 'Check the box to move ahead...');
                    }
                  },
                  title: 'proceed'.tr),
            )
          ],
        ),
      ),
    );
  }
}
