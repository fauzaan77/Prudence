import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/order_history_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dotted_line/dotted_line.dart';

class PackageStatus extends StatefulWidget {
  const PackageStatus({super.key});

  @override
  State<PackageStatus> createState() => _PackageStatusState();
}

class _PackageStatusState extends State<PackageStatus> {
  OrderHistoryController orderHistoryController = Get.find();
  RxInt bookingStatusId = 0.obs;

  @override
  void initState() {
    bookingStatusId.value =
        orderHistoryController.bookingDetails['bookingstatusid'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'packageStatus'.tr,
                style: kText24w600.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'trackPackage'.tr,
              style: kText18w700,
            ),
            // Text(
            //   'orderStatus'.tr,
            //   style: kText14w400.copyWith(color: greyOp6),
            // ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Icon(
                          bookingStatusId.value == 8 ||
                                  bookingStatusId.value == 9 ||
                                  bookingStatusId.value == 10 ||
                                  bookingStatusId.value == 11
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: black,
                        ),
                        bookingStatusId.value == 9 ||
                                bookingStatusId.value == 10 ||
                                bookingStatusId.value == 11
                            ? const SizedBox(
                                height: 67,
                                child: VerticalDivider(
                                  color: black,
                                  thickness: 2,
                                ),
                              )
                            : const DottedLine(
                                dashLength: 3,
                                direction: Axis.vertical,
                                dashGapLength: 2,
                                alignment: WrapAlignment.center,
                                lineLength: 67,
                                dashColor: black,
                              ),
                        Icon(
                          bookingStatusId.value == 9 ||
                                  bookingStatusId.value == 10 ||
                                  bookingStatusId.value == 11
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: black,
                        ),
                        bookingStatusId.value == 11
                            ? const SizedBox(
                                height: 67,
                                child: VerticalDivider(
                                  color: black,
                                  thickness: 2,
                                ),
                              )
                            : const DottedLine(
                                dashLength: 3,
                                direction: Axis.vertical,
                                dashGapLength: 2,
                                alignment: WrapAlignment.center,
                                lineLength: 67,
                                dashColor: black,
                              ),
                        Icon(
                          bookingStatusId.value == 11
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: black,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TrackContainer(
                            isActive: bookingStatusId.value == 8 ||
                                    bookingStatusId.value == 9 ||
                                    bookingStatusId.value == 10 ||
                                    bookingStatusId.value == 11
                                ? true
                                : false,
                            status: 'pickedUpParcel'.tr,
                            subtitle: 'pickedUpParcelDesc'.tr,
                            image: 'assets/images/status1.png',
                          ),
                          const Seperator(),
                          TrackContainer(
                            isActive: bookingStatusId.value == 9 ||
                                    bookingStatusId.value == 10 ||
                                    bookingStatusId.value == 11
                                ? true
                                : false,
                            status: 'reachedDropLocation'.tr,
                            subtitle: 'reachedDropLocationDesc'.tr,
                            image: 'assets/images/status2.png',
                          ),
                          const Seperator(),
                          TrackContainer(
                            isActive:
                                bookingStatusId.value == 11 ? true : false,
                            status: 'delivered'.tr,
                            subtitle: 'packageDelivered'.tr,
                            image: 'assets/images/status3.png',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TrackContainer extends StatelessWidget {
  TrackContainer(
      {super.key,
      required this.status,
      required this.subtitle,
      required this.isActive,
      required this.image});
  String status;
  String subtitle;
  String image;
  bool isActive;

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      bgColor: isActive ? statusActive : statusinActive,
      link: false,
      onTap: () {},
      child: Row(
        children: [
          CustomBox(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            bgColor: isActive ? black : statusBg,
            height: 70,
            width: 70,
            link: false,
            child: Image.asset(
              image,
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  status,
                  style: kText14w400,
                ),
                Text(
                  subtitle,
                  style: kText12w300.copyWith(color: greyOp4),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
