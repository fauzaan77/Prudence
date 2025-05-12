import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/order_history_controller.dart';
import 'package:airshipxp_shipper/screens/order_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderHistoryController orderHistoryController = Get.put(OrderHistoryController());

  @override
  void initState() {
    orderHistoryController.scrollController.addListener(orderHistoryController.scrollListener);
    orderHistoryController.isFirstTimeLoadingData.value = true;
    orderHistoryController.responseData.value = [];
    orderHistoryController.selectedOrder.value = "All";
    orderHistoryController.getOrders("All", 0);
    orderHistoryController.skip.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'myOrders'.tr,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Material(
            color: black,
            borderRadius: BorderRadius.circular(10),
            child: DropdownButtonHideUnderline(
              child: Obx(
                () => DropdownButton(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  iconSize: 40,
                  iconDisabledColor: white,
                  iconEnabledColor: white,
                  dropdownColor: black,
                  isDense: true,
                  borderRadius: BorderRadius.circular(10),
                  isExpanded: true,
                  value: orderHistoryController.selectedOrder.value == "" ? null : orderHistoryController.selectedOrder.value,
                  items: orderHistoryController.orderTypes.map((e) => buildMenuItems(e)).toList(),
                  onChanged: (value) {
                    orderHistoryController.selectedOrder.value = value;
                    orderHistoryController.isFirstTimeLoadingData.value = true;

                    orderHistoryController.responseData.value = [];
                    orderHistoryController.skip.value = 0;

                    orderHistoryController.getOrders(orderHistoryController.selectedOrder.value, orderHistoryController.skip.value);
                  },
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => orderHistoryController.loadingData.value == true
                ? Container(
                    color: Colors.white,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : orderHistoryController.responseData.isNotEmpty
                    ? ListView.separated(
                        controller: orderHistoryController.scrollController,
                        itemCount: orderHistoryController.responseData.length,
                        itemBuilder: (context, index) {
                          return MyOrderContainer(
                            data: orderHistoryController.responseData[index],
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            orderHistoryController.selectedOrder.value == 'Upcoming'
                                ? 'noUpcomingBooking'.tr
                                : orderHistoryController.selectedOrder.value == 'Past'
                                    ? 'noPastBooking'.tr
                                    : orderHistoryController.selectedOrder.value == 'Ongoing'
                                        ? 'noOngoingBooking'.tr
                                        : "noBookings".tr,
                            style: kText16w700,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
          ),
        ),
      ]),
    );
  }
}

DropdownMenuItem buildMenuItems(String item) => DropdownMenuItem(
      value: item,
      child: Center(
        child: Text(
          item,
          style: kText20w700.copyWith(fontWeight: FontWeight.w400, color: white),
        ),
      ),
    );

class MyOrderContainer extends StatelessWidget {
  MyOrderContainer({super.key, required this.data});
  dynamic data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: greyOp2),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(3.0, 3.0),
            color: Colors.black12,
            blurRadius: 4,
          ) //BoxShadow
        ],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBox(
                height: 70,
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(border: Border.all(color: greyOp4), shape: BoxShape.circle),
                link: false,
                child: Image.asset(
                  'assets/images/package.png',
                  fit: BoxFit.fitHeight,
                  height: 35,
                )),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'sendPackage'.tr,
                    style: kText16w700,
                  ),
                  Text(
                    data['bookingstatus'],
                    // style: kText16w700.copyWith(
                    //     color: status == 'Delivered' ? statusGreen : statusRed),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${DateFormat.jm().format(DateTime.parse(data['bookingdatetime']).toLocal())}, ${DateFormat('EEE, MMM d yyyy').format(DateTime.parse(data['bookingdatetime']).toLocal())}',
                    style: kText14w400,
                  ),
                ],
              ),
            ),
          ],
        ),
        // =======================================================
        const SizedBox(
          height: 10,
        ),
        Text(
          'pickupAddress'.tr,
          style: kText14w600.copyWith(color: greyOp4),
        ),
        const SizedBox(
          height: 3,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.home_outlined),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'home'.tr,
                  //   maxLines: 1,
                  //   style: kText14w400,
                  // ),
                  Text(
                    data['pickupaddress'],
                    maxLines: 2,
                    style: kText14w400.copyWith(overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            )
          ],
        ),
        const Divider(
          color: greyOp2,
        ),

        Text(
          'dropOffAddress'.tr,
          style: kText14w600.copyWith(color: greyOp4),
        ),
        const SizedBox(
          height: 3,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.home_outlined),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'home'.tr,
                  //   maxLines: 1,
                  //   style: kText14w400,
                  // ),
                  Text(
                    data['dropaddress'],
                    style: kText14w400.copyWith(overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            )
          ],
        ),
        const Divider(
          color: greyOp2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print(data['bookingid']);
                Get.to(() => OrderDetails(), arguments: data['bookingid']);
              },
              child: Text(
                'viewDetails'.tr,
                style: kText16w600.copyWith(decoration: TextDecoration.underline),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'pinForRide'.tr,
                  style: kText10w400,
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: data['bookingotp']
                      .toString()
                      .split("")
                      .map(
                        (e) => PinContainer(
                          number: e,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ]),
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
