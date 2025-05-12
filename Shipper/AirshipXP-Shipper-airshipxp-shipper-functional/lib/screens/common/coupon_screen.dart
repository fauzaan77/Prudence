import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/components/constants.dart';
import 'package:airshipxp_shipper/controllers/orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  var totalAmount = Get.arguments;
  OrdersController ordersController = Get.find();

  @override
  void initState() {
    print(totalAmount);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ordersController.getCoupons();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        titleText: 'coupons'.tr,
      ),
      body: Obx(
        () => ordersController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : ordersController.allCoupons.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'availableCoupons'.tr,
                          style: kText16w500,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: Obx(
                            () => ListView(
                              children: ordersController.allCoupons
                                  .map(
                                    (element) => CouponContainer(
                                      couponCode: element.title,
                                      index: element.id,
                                      couponDesc: element.coupondesc,
                                      image: element.imagepath ?? "",
                                      validityEndDate: DateTime.parse(
                                          element.validityrangeend),
                                      amount: totalAmount.toDouble(),
                                      couponType: element.discounttype,
                                      couponValue:
                                          element.couponvalue.toDouble(),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: ListView(children: [
                        //     CouponContainer(
                        //       couponCode: 'x123112',
                        //       index: 2,
                        //       couponDesc: 'description',
                        //       image: 'assets/images/couponBg.png',
                        //       validityEndDate: DateTime.now(),
                        //       amount: 25,
                        //       couponType: 'percent',
                        //       couponValue: 1.1,
                        //     ),
                        //   ]),
                        // ),
                      ],
                    ),
                  )
                : Center(
                    child: Text(
                      "noCouponsFound".tr,
                      style: kText16w600,
                    ),
                  ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CouponContainer extends StatelessWidget {
  CouponContainer(
      {super.key,
      required this.couponCode,
      required this.index,
      this.image,
      required this.couponDesc,
      required this.validityEndDate,
      required this.amount,
      required this.couponType,
      required this.couponValue});
  String couponCode;
  String couponDesc;
  String? image;
  int index;
  DateTime validityEndDate;
  double amount;
  String couponType;
  dynamic couponValue;

  OrdersController ordersController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: const Offset(0.0, 2.0),
            color: Colors.black12,
            blurRadius: 3,
          )
        ],
      ),
      child: IntrinsicHeight(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          image != ""
              ? Container(
                  width: 90,
                  child: Image.network(
                    '${baseUrl}${image}',
                    fit: BoxFit.cover,
                  ),
                )
              : couponType == "Percentage"
                  ? Container(
                      width: 90,
                      decoration: BoxDecoration(color: Color(0xFFF62146)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${(couponValue).toStringAsFixed(0)}',
                            style: kText30w500.copyWith(
                              color: Colors.white,
                              height: 1.1,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "%",
                                style:
                                    kText14w400.copyWith(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                "OFF",
                                style:
                                    kText14w400.copyWith(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(
                      width: 90,
                      decoration: BoxDecoration(color: Colors.black),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$${(couponValue).toStringAsFixed(0)}',
                            style: kText30w500.copyWith(
                              color: Colors.white,
                              height: 1.1,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "OFF",
                            style: kText14w400.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  couponDesc,
                  style: kText14w500.copyWith(height: 1.2),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  couponCode,
                  style: kText11w400,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${daysBetween(DateTime.now(), validityEndDate.toLocal())} days remaining',
                  style: kText10w400,
                ),
                ElevatedButton(
                    onPressed: () async {
                      var couponAmount = await getCouponAmount(
                          amount, couponType, couponValue);
                      print(amount);
                      if (couponAmount > 0) {
                        ordersController.couponId.value = index;
                        ordersController.couponApplied.value = true;
                        ordersController.couponAmount.value = couponAmount;
                        ordersController.updateTotalamount();
                        Get.back();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'apply'.tr,
                        style: kText14w400.copyWith(color: white),
                      ),
                    )),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  getCouponAmount(amount, couponType, couponValue) async {
    if (couponType == 'Value') {
      return double.tryParse(couponValue.toStringAsFixed(2));
    } else if (couponType == 'Percentage') {
      var percentAmount = amount * (couponValue / 100);

      return double.tryParse(percentAmount.toStringAsFixed(2));
    }
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
