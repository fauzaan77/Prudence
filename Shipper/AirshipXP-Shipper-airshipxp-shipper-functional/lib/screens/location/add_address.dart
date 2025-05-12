import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/orders_controller.dart';
import 'package:airshipxp_shipper/local_database/local_db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  OrdersController ordersController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        titleText: "confirmLocation".tr,
        style: kText24w600,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Stack(
            children: [
              Obx(
                () => GoogleMap(
                  onMapCreated: ordersController.onMapCreate,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(ordersController.tempLat.value,
                          ordersController.tempLng.value),
                      zoom: 15),
                  onCameraIdle: () {
                    ordersController.onCameraMove();
                  },
                  onCameraMove: (position) {
                    ordersController.tempLat.value = position.target.latitude;
                    ordersController.tempLng.value = position.target.longitude;
                  },
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/location-marker.png',
                  height: 35,
                  width: 35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'selectedLocation'.tr,
                style: kText18w400.copyWith(color: Colors.black38),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ordersController.tempShortAddress.value,
                            style: kText16w500.copyWith(color: black),
                          ),
                          Text(
                            ordersController.tempAddressDescription.value,
                            style: kText12w300.copyWith(color: black),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ButtonPrimary(
                onPressed: () async {
                  var allAddresses = await DatabaseHelper.getAddress();

                  if (allAddresses.isNotEmpty) {
                    var valueExists = false;
                    for (var element in allAddresses) {
                      if (element['description'] ==
                          ordersController.tempAddressDescription.value) {
                        valueExists = true;
                      }
                      print(element);
                      print(element['description']);
                    }

                    if (valueExists == false) {
                      await ordersController.addAddress();
                    }
                  } else {
                    await ordersController.addAddress();
                  }
                  ordersController.latitude.value =
                      ordersController.tempLat.value;
                  ordersController.longitude.value =
                      ordersController.tempLng.value;
                  ordersController.shortAddress.value =
                      ordersController.tempShortAddress.value;
                  ordersController.addressDescription.value =
                      ordersController.tempAddressDescription.value;

                  ordersController.tempShortAddress.value = "";
                  ordersController.tempAddressDescription.value = "";
                  ordersController.tempLat.value = 0.0;
                  ordersController.tempLng.value = 0.0;
                  Get.close(2);
                },
                title: 'confirmLocation'.tr,
              )
            ],
          ),
        )
      ]),
    );
  }
}
