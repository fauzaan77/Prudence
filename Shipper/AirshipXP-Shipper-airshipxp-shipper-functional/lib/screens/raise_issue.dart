import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/components/customToast.dart';
import 'package:airshipxp_shipper/controllers/support_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RaiseIssue extends StatefulWidget {
  const RaiseIssue({super.key});

  @override
  State<RaiseIssue> createState() => _RaiseIssueState();
}

class _RaiseIssueState extends State<RaiseIssue> {
  var bookingId = Get.arguments;

  final SupportController supportController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'raiseIssue'.tr,
        leading: true,
      ),
      body: Obx(
        () => supportController.loadingData.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'pleaseLetUsKnow'.tr,
                          style: kText18w600,
                        ),
                        Text(
                          'howWeCanServeBetter'.tr,
                          style: kText22w600,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => Container(
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: greyOp2),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  size: 35,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                borderRadius: BorderRadius.circular(10),
                                isExpanded: true,
                                hint: Text(
                                  'selectIssue'.tr,
                                  style: kText18w600.copyWith(color: grey),
                                ),
                                items: supportController.items
                                    .map(
                                      (element) => DropdownMenuItem(
                                        value: element,
                                        child: Text(
                                          element,
                                          style: kText15w400,
                                        ),
                                      ),
                                    )
                                    .toList(),
                                value:
                                    supportController.selectedItem.value == ""
                                        ? null
                                        : supportController.selectedItem.value,
                                onChanged: (value) {
                                  supportController.selectedItem.value = value!;
                                },
                              ),
                            ),
                          ),
                        ),
                        Seperator(),
                        TextInputBox(
                          controller: supportController.issueDescription,
                          placeHolder: 'typeMsg'.tr,
                          onValueChange: (value) {},
                          outlineBorder: true,
                          borderColor: greyOp2,
                          radius: BorderRadius.circular(10),
                          minLine: 4,
                          maxLine: 4,
                        ),
                        SizedBox(
                          height: Get.height * 0.3,
                        ),
                        ButtonPrimary(
                            onPressed: () async {
                              if (supportController.selectedItem.value != "" &&
                                  supportController.issueDescription.text !=
                                      "") {
                                print(supportController.selectedItem.value);
                                print(supportController.issueDescription.text);
                                var res = await supportController
                                    .addComplaint(bookingId);
                                if (res == 'issueRaised') {
                                  supportController.selectedItem.value = "";
                                  supportController.issueDescription.text = "";
                                  Get.back(result: res);
                                }
                              } else {
                                CustomToast.show("pleaseFillAllDetails".tr);
                              }
                            },
                            title: 'submit'.tr),
                      ]),
                ),
              ),
      ),
    );
  }
}
