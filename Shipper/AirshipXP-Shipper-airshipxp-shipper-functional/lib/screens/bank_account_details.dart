import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/screens/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankAccountDetails extends StatefulWidget {
  const BankAccountDetails({super.key});

  @override
  State<BankAccountDetails> createState() => _BankAccountDetailsState();
}

class _BankAccountDetailsState extends State<BankAccountDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'enterBank'.tr,
        leading: true,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.6,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        TextInputBox(
                          onValueChange: () {},
                          placeHolder: 'ifsc'.tr,
                        ),
                        Seperator(),
                        TextInputBox(
                          onValueChange: () {},
                          placeHolder: 'branch'.tr,
                        ),
                        Seperator(),
                        TextInputBox(
                          onValueChange: () {},
                          placeHolder: 'accountNumber'.tr,
                        ),
                        Seperator()
                      ],
                    ),
                  ),
                  ButtonPrimary(
                    onPressed: () {
                      Get.to(() => TermsAndConditions());
                    },
                    title: 'next'.tr,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
