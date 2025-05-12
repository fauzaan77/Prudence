import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DropPackage extends StatefulWidget {
  const DropPackage({super.key});

  @override
  State<DropPackage> createState() => _DropPackageState();
}

class _DropPackageState extends State<DropPackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        titleText: 'reachDrop'.tr,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomBox(
                    link: false,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    shadow: true,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.bookmark_border,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('paidOnline'.tr, style: kText16w600),
                            Text(
                              'Order ID : #hfe2345',
                              style: kText16w500.copyWith(
                                fontWeight: FontWeight.w400,
                                color: greyOp5,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Seperator(),
                  CustomBox(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    shadow: true,
                    link: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'orderDetails'.tr,
                          style: kText18w600,
                        ),
                        Seperator(),
                        Row(
                          children: [
                            Icon(
                              Icons.insert_drive_file_outlined,
                              size: 30,
                              color: greyOp5,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'document'.tr,
                                  style: kText16w600.copyWith(
                                    color: greyOp5,
                                  ),
                                ),
                                Seperator(),
                                Text(
                                  'weight'.tr,
                                  style: kText14w400,
                                ),
                                Text(
                                  'weight'.tr,
                                  style: kText14w400,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Seperator(),
                  CustomBox(
                    shadow: true,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    link: false,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.supervised_user_circle_outlined,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'customerDetails'.tr,
                              style: kText16w600.copyWith(
                                color: greyOp5,
                              ),
                            )
                          ],
                        ),
                        Seperator(),
                        Row(
                          children: [
                            Icon(
                              Icons.account_circle,
                              color: greyOp5,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'pickupCustomer'.tr,
                                  style: kText12w300.copyWith(
                                    color: greyOp3,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'martinJones'.tr,
                                  style: kText16w600,
                                ),
                                Text(
                                  'custAddress'.tr,
                                  style: kText12w300.copyWith(
                                      fontWeight: FontWeight.w400),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone_outlined,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '8989898989'.tr,
                                      style: kText14w500,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.account_circle,
                              color: greyOp5,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'pickupCustomer'.tr,
                                  style: kText12w300.copyWith(
                                    color: greyOp3,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'martinJones'.tr,
                                  style: kText16w600,
                                ),
                                Text(
                                  'custAddress'.tr,
                                  style: kText12w300.copyWith(
                                      fontWeight: FontWeight.w400),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone_outlined,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '8989898989'.tr,
                                      style: kText14w500,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomBox(
                link: false,
                shadow: true,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: ButtonPrimary(
                  height: 50,
                  onPressed: () {
                    Get.offAll(() => HomeScreen());
                  },
                  title: 'orderDelivered'.tr,
                  style: kText14w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
