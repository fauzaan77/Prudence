import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/orders_controller.dart';
import 'package:airshipxp_shipper/screens/international/pickup_collection_center.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickupAirportScreen extends StatefulWidget {
  const PickupAirportScreen({super.key});

  @override
  State<PickupAirportScreen> createState() => _PickupAirportScreenState();
}

class _PickupAirportScreenState extends State<PickupAirportScreen> {
  OrdersController ordersController = Get.find();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ordersController.getAllAirports();
    });
  }

  @override
  void dispose() {
    super.dispose();
    ordersController.selectedAirportId.value = 0;
    ordersController.allAirports.value = [];
    ordersController.allAirportsResponseData.value = {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        titleText: 'sendPackage'.tr,
        style: kText24w600,
      ),
      body: Obx(
        () => ordersController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : ordersController.allAirports.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(children: [
                      Expanded(
                        child: Column(children: [
                          Text(
                            'pickupAirport'.tr,
                            style: kText30w500.copyWith(
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: Obx(
                              () => ListView.separated(
                                itemCount: ordersController.allAirports.length,
                                separatorBuilder: (context, index) => Divider(),
                                itemBuilder: (context, index) {
                                  return Obx(
                                    () => CustomBox(
                                        padding: EdgeInsets.all(15),
                                        onTap: () {
                                          ordersController
                                                  .selectedAirportId.value =
                                              ordersController
                                                  .allAirports[index]['id'];
                                          ordersController
                                                  .selectedAirportName.value =
                                              ordersController
                                                  .allAirports[index]['name'];
                                        },
                                        bgColor: ordersController
                                                    .allAirports[index]['id'] ==
                                                ordersController
                                                    .selectedAirportId.value
                                            ? Colors.black12
                                            : Colors.transparent,
                                        link: true,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ordersController
                                                  .allAirports[index]['name'],
                                              style: kText16w500,
                                            ),
                                            Text(
                                              ordersController
                                                  .allAirports[index]['city'],
                                              style: kText12w300.copyWith(
                                                  color: grey),
                                            ),
                                          ],
                                        )),
                                  );
                                },
                              ),
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ButtonPrimary(
                            onPressed: () {
                              print(ordersController.selectedAirportId.value);
                              print(ordersController.selectedAirportName.value);
                              Get.to(() => PickupCollectionCenter());
                            },
                            title: 'next'.tr),
                      )
                    ]),
                  )
                : Center(
                    child: Text(
                      "noAirportsFound".tr,
                      style: kText16w600,
                    ),
                  ),
      ),
    );
  }
}
