import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/components/constants.dart';
import 'package:airshipxp_shipper/controllers/order_history_controller.dart';
import 'package:airshipxp_shipper/screens/package_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var bookingId = Get.arguments;
  OrderHistoryController orderHistoryController = Get.find();
  List stars = [1, 2, 3, 4, 5];

  @override
  void initState() {
    orderHistoryController.getBookingDetails(bookingId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        titleText: 'orderDetails'.tr,
      ),
      body: Obx(
        () => orderHistoryController.loadingTripDetailsData.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${'orderId'.tr} ${orderHistoryController.bookingDetails['bookingno']}',
                          style: kText20w500,
                        ),
                        Text(
                          orderHistoryController
                              .bookingDetails['bookingstatus'],
                          style: kText20w700.copyWith(
                              color: orderHistoryController.bookingDetails[
                                              'bookingstatusid'] ==
                                          4 ||
                                      orderHistoryController.bookingDetails[
                                              'bookingstatusid'] ==
                                          5 ||
                                      orderHistoryController.bookingDetails[
                                              'bookingstatusid'] ==
                                          6 ||
                                      orderHistoryController.bookingDetails[
                                              'bookingstatusid'] ==
                                          12 ||
                                      orderHistoryController.bookingDetails[
                                              'bookingstatusid'] ==
                                          13
                                  ? red
                                  : statusGreen),
                        ),
                        const Divider(),
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
                                        padding:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                    orderHistoryController
                                                            .bookingDetails[
                                                        'pickupaddress'],
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: kText12w300.copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Text(
                                            'dropOffAddress'.tr,
                                            style: kText16w600,
                                          ),
                                          const SizedBox(
                                            height: 6.0,
                                          ),
                                          Text(
                                            orderHistoryController
                                                .bookingDetails['dropaddress'],
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
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.phone,
                                                size: 18,
                                              ),
                                              Text(
                                                orderHistoryController
                                                        .bookingDetails[
                                                    'recipientphone'],
                                                style: kText14w400.copyWith(
                                                    color: greyOp5),
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
                                    orderHistoryController
                                            .bookingDetails['sizeslot'] ??
                                        "",
                                    style: kText14w400,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        orderHistoryController
                                            .bookingDetails['weightslot'],
                                        style: kText14w400.copyWith(
                                          color: greyOp5,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.bottomSheet(ReceiptContainer());
                                        },
                                        child: Text(
                                          'viewReceipt'.tr,
                                          style: kText16w600.copyWith(
                                            color: pinBg,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                        Divider(),
                        if (orderHistoryController.bookingDetails['carrier'] !=
                            "")
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'driverDetails'.tr,
                                      style: kText18w600,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        if (orderHistoryController
                                                    .bookingDetails[
                                                'carrierimagepath'] !=
                                            '')
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundImage: NetworkImage(
                                                '$baseUrl${orderHistoryController.bookingDetails['carrierimagepath']}'),
                                          ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${orderHistoryController.bookingDetails['carrier']}',
                                                style: kText16w700,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                      children: getStarRating(
                                                          orderHistoryController
                                                                  .bookingDetails[
                                                              'carrierrating'])),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                      "${orderHistoryController.bookingDetails['carrierrating'] ?? 0.0}")
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          children: [
                                            if (orderHistoryController.bookingDetails['bookingstatusid'] == 3 ||
                                                orderHistoryController
                                                            .bookingDetails[
                                                        'bookingstatusid'] ==
                                                    7 ||
                                                orderHistoryController
                                                            .bookingDetails[
                                                        'bookingstatusid'] ==
                                                    8 ||
                                                orderHistoryController
                                                            .bookingDetails[
                                                        'bookingstatusid'] ==
                                                    9)
                                              InkWell(
                                                onTap: () => callNumber(
                                                    orderHistoryController
                                                            .bookingDetails[
                                                        'carrierphone']),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: inActiveGrey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.phone,
                                                          color: Colors.red,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "call".tr,
                                                          style: kText16w500
                                                              .copyWith(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                            if (orderHistoryController
                                                        .bookingDetails[
                                                    'bookingstatusid'] ==
                                                11)
                                              InkWell(
                                                onTap: () {},
                                                child: Text(
                                                  'rateNow'.tr,
                                                  style: kText16w600.copyWith(
                                                    color: pinBg,
                                                  ),
                                                ),
                                              )
                                          ],
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    if (orderHistoryController
                                .bookingDetails['bookingstatusid'] !=
                            11 &&
                        (orderHistoryController
                                    .bookingDetails['bookingstatusid'] !=
                                4 ||
                            orderHistoryController
                                    .bookingDetails['bookingstatusid'] !=
                                5 ||
                            orderHistoryController
                                    .bookingDetails['bookingstatusid'] !=
                                6 ||
                            orderHistoryController
                                    .bookingDetails['bookingstatusid'] !=
                                12 ||
                            orderHistoryController
                                    .bookingDetails['bookingstatusid'] !=
                                13))
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ButtonPrimary(
                          onPressed: () {
                            // Get.to(() => PackageStatus());
                            Get.bottomSheet(
                              PackageStatus(),
                            );
                          },
                          title: 'checkPackageStatus'.tr,
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  callNumber(number) async {
    var url = Uri.parse("tel:$number");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getStarRating(value) {
    List<Widget> allStars = [];
    for (int i = 0; i < stars.length; i++) {
      if (value < i + 1) {
        allStars.add(const Icon(
          Icons.star,
          color: inActiveGreyText,
          size: 20,
        ));
      } else {
        allStars.add(const Icon(
          Icons.star,
          color: Color(0xFFED1B24),
          size: 20,
        ));
      }
    }
    return allStars.map((e) => e).toList();
  }
}

class ReceiptContainer extends StatelessWidget {
  ReceiptContainer({super.key});

  OrderHistoryController orderHistoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 320,
      color: white,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 270,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: greyOp3, blurRadius: 5, blurStyle: BlurStyle.outer)
            ]),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 150,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'deliveryFare'.tr,
                      style: kText20w700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'subtotal'.tr,
                          style:
                              kText14w600.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '\$ ${orderHistoryController.bookingDetails['subtotal'].toDouble().toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'discount'.tr,
                          style: kText14w400,
                        ),
                        Text(
                          '- \$ ${orderHistoryController.bookingDetails['discount'].toDouble().toStringAsFixed(2)}',
                          style: kText14w400.copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'vat'.tr,
                          style: kText14w400,
                        ),
                        Text(
                          '\$ ${orderHistoryController.bookingDetails['tax'].toDouble().toStringAsFixed(2)}',
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
                  style: kText20w700,
                ),
                Text(
                    '\$ ${orderHistoryController.bookingDetails['totalamount'].toDouble().toStringAsFixed(2)}',
                    style: kText20w700),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '${'paidBy'.tr} ${orderHistoryController.bookingDetails['paymenttype']}',
                style: kText16w700.copyWith(
                  color: pinBg,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
