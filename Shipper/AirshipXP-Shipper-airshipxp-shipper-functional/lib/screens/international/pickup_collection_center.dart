import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/orders_controller.dart';
import 'package:airshipxp_shipper/screens/international/shipping_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PickupCollectionCenter extends StatefulWidget {
  const PickupCollectionCenter({super.key});

  @override
  State<PickupCollectionCenter> createState() => _PickupCollectionCenterState();
}

class _PickupCollectionCenterState extends State<PickupCollectionCenter> {
  OrdersController ordersController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ordersController.getAllCollectionCenters();
    });
  }

  @override
  void dispose() {
    super.dispose();
    ordersController.selectedCollectionCenterId.value = 0;
    ordersController.selectedCollectionCenterName.value = "";
    ordersController.allCollectionCenters.value = [];
    ordersController.allCollectionCenterResponseData.value = {};
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
            : ordersController.allCollectionCenters.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'pickupCollectionCenter'.tr,
                              style: kText30w500.copyWith(
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Expanded(
                              child: Obx(
                                () => ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      Seperator(),
                                  itemCount: ordersController
                                      .allCollectionCenters.length,
                                  itemBuilder: (context, index) => Obx(
                                    () => CustomBox(
                                        bgColor: ordersController
                                                        .allCollectionCenters[
                                                    index]['id'] ==
                                                ordersController
                                                    .selectedCollectionCenterId
                                                    .value
                                            ? greyOp1
                                            : Colors.transparent,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        onTap: () {
                                          ordersController
                                              .selectedCollectionCenterId
                                              .value = ordersController
                                                  .allCollectionCenters[index]
                                              ['id'];
                                        },
                                        link: true,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                ordersController
                                                        .allCollectionCenters[
                                                    index]['name'],
                                                style: kText16w500,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Radio(
                                                activeColor: black,
                                                value: ordersController
                                                        .allCollectionCenters[
                                                    index]['id'],
                                                groupValue: ordersController
                                                    .selectedCollectionCenterId
                                                    .value,
                                                onChanged: (value) {
                                                  ordersController
                                                      .selectedCollectionCenterId
                                                      .value = value!;
                                                })
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: ButtonPrimary(
                            onPressed: () {
                              print(ordersController
                                  .selectedCollectionCenterId.value);
                              print(ordersController
                                  .selectedCollectionCenterName.value);
                              Get.to(() => ShippingScreen());
                            },
                            title: 'next'.tr),
                      )
                    ]),
                  )
                : Center(
                    child: Text(
                      "noPickupCollectionCenterFound".tr,
                      style: kText16w600,
                    ),
                  ),
      ),
    );
  }
}
