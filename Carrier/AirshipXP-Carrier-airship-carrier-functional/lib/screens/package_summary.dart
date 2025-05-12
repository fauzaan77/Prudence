import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageSummary extends StatefulWidget {
  PackageSummary({super.key, this.status});
  String? status;

  @override
  State<PackageSummary> createState() => _PackageSummaryState();
}

class _PackageSummaryState extends State<PackageSummary> {
  String delivered = 'Package Successfully Delivered';
  String upcoming = 'Upcoming Package Delivery';
  String cancelled = 'Package Cancelled';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        flex: true,
        style: kText20w500.copyWith(
          fontWeight: FontWeight.w600,
        ),
        customFlex: Container(
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.status == 'Completed'
                        ? delivered
                        : widget.status == 'Upcoming'
                            ? upcoming
                            : widget.status == 'Cancelled'
                                ? cancelled
                                : 'titleError',
                    style: kText20w500.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '22 March, 2022  3:00PM',
                    style: kText11w400,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              CustomBox(
                padding: EdgeInsets.all(15),
                link: false,
                bgColor: profileLinkIcon,
                child: Text(
                  widget.status == 'Completed'
                      ? delivered
                      : widget.status == 'Upcoming'
                          ? upcoming
                          : widget.status == 'Cancelled'
                              ? cancelled
                              : 'titleError',
                  style: kText18w600,
                ),
              ),
              Seperator(),
              CustomBox(
                link: false,
                shadow: true,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Column(
                      children: [
                        Icon(Icons.location_on_outlined),
                        DottedLine(
                          lineLength: 70,
                          direction: Axis.vertical,
                        ),
                        Icon(Icons.location_on_outlined),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'loremTxt'.tr,
                            style: kText14w400,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Text(
                            'loremTxt'.tr,
                            style: kText14w400,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Seperator(),
              CustomBox(
                link: false,
                padding: EdgeInsets.all(20),
                shadow: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'itemImage'.tr,
                      style: kText18w600,
                    ),
                    Seperator(),
                    Card(
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        height: 84,
                        width: 69,
                        child: Image.asset(
                          'assets/images/package.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Seperator(),
              CustomBox(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                padding: EdgeInsets.all(15),
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
              Seperator(),
              CustomBox(
                link: false,
                padding: EdgeInsets.all(20),
                shadow: true,
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.bookmark_border,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('paidOnline'.tr, style: kText16w600),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
