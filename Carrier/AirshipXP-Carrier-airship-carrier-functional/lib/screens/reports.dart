import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/controllers/order_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final OrderController orderController = Get.put(OrderController());
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: CustomAppBar(
        leading: true,
        titleText: 'reports'.tr,
        titleColor: white,
        leadingIconColor: white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ColoredBox(
              color: white,
              child: TabBar(
                controller: _tabController,
                indicatorColor: black,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: black,
                indicator: BoxDecoration(color: greyOp2),
                unselectedLabelColor: grey,
                tabs: [
                  Tab(
                    child: Text(
                      'currentWeek'.tr,
                      style: kText18w700,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'history'.tr,
                      style: kText18w700,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                  controller: _tabController,
                  // viewportFraction: 1,
                  children: [
                    _buildCurrentWeek(context),
                    _buildHistory(context),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWeek(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        CustomBox(
          bgColor: white,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.symmetric(horizontal: 15),
          link: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_month),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '8 Jan - 15 Jan',
                        style:
                            kText24w600.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ 4,523',
                    style: kText18w700,
                  ),
                  Text(
                    'paid'.tr,
                    style: kText18w700.copyWith(color: green),
                  ),
                ],
              ),
            ],
          ),
        ),
        Seperator(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'breakdown'.tr,
            style:
                kText24w600.copyWith(fontWeight: FontWeight.w700, color: white),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ReportContainer(
            label1: 'orderId'.tr,
            label2: 'dropOffDatetime'.tr,
            label3: 'amount'.tr,
          ),
        ),
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15),
          itemCount: orderController.historyPackage.length,
          itemBuilder: (context, index) {
            return ReportContainer(
              label1: '05856',
              label2: '23-7-2021 9:10 AM',
              label3: '5',
            );
          },
        ))
      ],
    );
  }

  Widget _buildHistory(BuildContext context) {
    return Column(
      children: [],
    );
  }
}

class ReportContainer extends StatelessWidget {
  ReportContainer(
      {super.key,
      required this.label1,
      required this.label2,
      required this.label3});
  String label1;
  String label2;
  String label3;

  @override
  Widget build(BuildContext context) {
    return CustomBox(
        bgColor: Colors.transparent,
        borderRadius: BorderRadius.zero,
        padding: EdgeInsets.symmetric(vertical: 15),
        border: Border(
          bottom: BorderSide(
            color: bottomBorder,
          ),
        ),
        link: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 80,
              child: Text(
                textAlign: TextAlign.center,
                label1,
                style: kText16w600.copyWith(
                  color: white,
                ),
              ),
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                label2,
                style: kText16w600.copyWith(
                  color: white,
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                textAlign: TextAlign.center,
                label3,
                style: kText16w600.copyWith(
                  color: white,
                ),
              ),
            ),
          ],
        ));
  }
}
