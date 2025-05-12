import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/orders_controller.dart';
import 'package:airshipxp_shipper/screens/common/coupon_screen.dart';
import 'package:airshipxp_shipper/screens/international/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_line/dotted_line.dart';

class RequestSummary extends StatefulWidget {
  const RequestSummary({super.key});

  @override
  State<RequestSummary> createState() => _RequestSummaryState();
}

class _RequestSummaryState extends State<RequestSummary> {
  OrdersController ordersController = Get.find();

  @override
  void initState() {
    ordersController.subTotal.value = 60.00;
    print(ordersController.tax.value);
    ordersController.updateTotalamount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'requestSummary'.tr,
          style: kText24w600,
        ),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 22,
              color: black,
            ),
            onPressed: () {
              ordersController.resetCoupon();
              Get.back();
            }),
      ),
      body: Column(children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            children: [
              //Location ui
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.trip_origin_outlined,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 18.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'pickupAddress'.tr,
                                          style: kText16w600,
                                        ),
                                        const SizedBox(
                                          height: 6.0,
                                        ),
                                        Text(
                                          '${ordersController.selectedCollectionCenterName.value}, ${ordersController.selectedAirportName.value}, ${ordersController.selectedCity.value}, ${ordersController.selectedCountry.value}, ${ordersController.selectedCountryCode.value}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: kText12w300.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: greyOp5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: 23,
                              left: 10.5,
                              bottom: 0,
                              child: Image.asset(
                                "assets/images/dottedLine.png",
                                width: 3,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 18.0,
                          ),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(
                                  'dropOffAddress'.tr,
                                  style: kText16w600,
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  '${ordersController.addressDescription.value}, ${ordersController.selectedDestCity.value}, ${ordersController.selectedDestCountry.value}, ${ordersController.selectedDestCountryCode.value}',
                                  style: kText12w300.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: greyOp5,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  ordersController.recipientName.text,
                                  style: kText14w400.copyWith(color: greyOp5),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      size: 18,
                                    ),
                                    Text(
                                      '${ordersController.recipientCountrycode.value}${ordersController.recipientPhone.text}',
                                      style:
                                          kText14w400.copyWith(color: greyOp5),
                                    ),
                                  ],
                                ),
                              ]))
                        ],
                      )
                    ],
                  ),
                ),
              ),

              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'packageDetails'.tr,
                          style: kText18w600,
                        ),
                        Text(
                          ordersController.selectedPackageSizeTitle.value,
                          style: kText14w400,
                        ),
                        Text(
                          ordersController.selectedPackageWeight.value,
                          style: kText14w400.copyWith(
                            color: greyOp5,
                          ),
                        ),
                      ]),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'deliveryFare'.tr,
                          style: kText18w600,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'subtotal'.tr,
                              style: kText14w600.copyWith(
                                fontWeight: FontWeight.w700,
                                color: greyOp5,
                              ),
                            ),
                            Obx(
                              () => Text(
                                '\$${ordersController.subTotal.value.toStringAsFixed(2)}',
                              ),
                            ),
                          ],
                        ),
                        Obx(() => ordersController.couponApplied.value ==
                                    true &&
                                ordersController.couponAmount.value > 0.0
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'discount'.tr,
                                    style: kText14w600.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: greyOp5,
                                    ),
                                  ),
                                  Text(
                                    '- \$${ordersController.couponAmount.value.toStringAsFixed(2)}',
                                    style:
                                        kText14w400.copyWith(color: Colors.red),
                                  ),
                                ],
                              )
                            : Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${'vat'.tr} (${ordersController.tax.value}%)',
                              style: kText14w600.copyWith(
                                fontWeight: FontWeight.w700,
                                color: greyOp5,
                              ),
                            ),
                            Obx(
                              () => Text(
                                '\$${ordersController.taxAmount.value.toStringAsFixed(2)}',
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'totalAmt'.tr,
                      style: kText18w600,
                    ),
                    Obx(
                      () => Text(
                          '\$${(ordersController.totalAmount.value).toStringAsFixed(2)}',
                          style: kText14w500),
                    ),
                  ],
                ),
              ),
              Seperator(),

              Obx(() => ordersController.couponApplied.value == true &&
                      ordersController.couponAmount.value > 0.0
                  ? CustomBox(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      link: true,
                      borderColor: greyOp2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'couponApplied'.tr,
                            style: kText14w600.copyWith(color: Colors.green),
                          ),
                          InkWell(
                              onTap: () {
                                ordersController.resetCoupon();
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              )),
                        ],
                      ),
                    )
                  : CustomBox(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      borderColor: greyOp2,
                      link: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'noCouponsAvailable'.tr,
                            style: kText14w400.copyWith(color: greyOp5),
                          ),
                          TextButton(
                            child: Text(
                              'applyCoupon'.tr,
                              style: kText16w500.copyWith(color: notiBorder),
                            ),
                            onPressed: () {
                              ordersController.resetCoupon();
                              Get.to(() => CouponsScreen(),
                                  arguments: ordersController.subTotal.value);
                            },
                          ),
                        ],
                      )))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          child: ButtonPrimary(
            onPressed: () {
              print(ordersController.subTotal.value);
              Get.to(() => PaymentSelection());
            },
            title: 'continue'.tr,
          ),
        )
      ]),
    );
  }
}
