import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/screens/pick_package.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReachPickup extends StatefulWidget {
  ReachPickup({super.key});

  @override
  State<ReachPickup> createState() => _ReachPickupState();
}

class _ReachPickupState extends State<ReachPickup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'reachPickup'.tr,
        leading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              Seperator(),
              CustomBox(
                link: false,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 10),
                shadow: true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.bookmark_border,
                              color: greyOp5,
                            ),
                            SizedBox(
                              width: 10,
                            ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.bookmark_border,
                              color: greyOp5,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'PIN for this ride',
                              style: kText16w500.copyWith(
                                fontWeight: FontWeight.w400,
                                color: greyOp5,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            PinContainer(number: '5'),
                            PinContainer(number: '5'),
                            PinContainer(number: '5'),
                            PinContainer(number: '5'),
                          ],
                        )
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
                              'dimension'.tr,
                              style: kText14w400,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              ButtonPrimary(
                height: 50,
                onPressed: () {
                  Get.to(() => PickupPackage());
                },
                title: 'reachedCollectionCenter'.tr,
                style: kText14w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PinContainer extends StatelessWidget {
  PinContainer({super.key, required this.number});
  String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 20,
      width: 20,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(color: pinBg),
      child: Text(
        number,
        style: kText12w300.copyWith(color: white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
