import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/components/constants.dart';
import 'package:airshipxp_shipper/controllers/orders_controller.dart';
import 'package:airshipxp_shipper/local_database/local_db_service.dart';
import 'package:airshipxp_shipper/screens/location/add_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({Key? key}) : super(key: key);

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  OrdersController ordersController = Get.find();

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  void getHistory() async {
    final data = await DatabaseHelper.getAddress();
    ordersController.myData.value = data;

    print("local history : $data");
  }

  @override
  void dispose() {
    super.dispose();
    ordersController.googlePlacesTextController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        titleText: "selectLocation".tr,
        style: kText24w600,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: GooglePlaceAutoCompleteTextField(
              textEditingController:
                  ordersController.googlePlacesTextController,
              googleAPIKey: google_map_key,
              inputDecoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  size: 25,
                ),
                hintText: 'searchLocation'.tr,
                hintStyle: kText16w500,
                border: InputBorder.none,
              ),
              getPlaceDetailWithLatLng: (Prediction prediction) {
                ordersController.tempLat.value = double.parse(prediction.lat!);
                ordersController.tempLng.value = double.parse(prediction.lng!);
              },
              // countries: ["in"],
              isLatLngRequired: true,
              boxDecoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(30.0)),
              itemClick: (Prediction prediction) async {
                ordersController.googlePlacesTextController.text =
                    prediction.description!;
                ordersController.tempAddressDescription.value =
                    prediction.description!;

                var latLngFound = await ordersController
                    .getLatLngFromAddress(prediction.description!);
                print("=================================");
                print(prediction.description!);
                print(
                    'temp latLng : ${ordersController.tempLat.value}, ${ordersController.tempLng.value}');
                print("=================================");
                if (latLngFound == true) {
                  ordersController.setShortAddress();
                  Get.to(() => AddAddress());
                }
              },
              itemBuilder: (context, index, Prediction prediction) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(
                        width: 7,
                      ),
                      Expanded(
                          child: Text(
                        prediction.description ?? "",
                        style: kText14w500,
                      ))
                    ],
                  ),
                );
              },
              seperatedBuilder: Divider(),
              isCrossBtnShown: true,
            ),
          ),
          InkWell(
            onTap: () async {
              var resp = await ordersController.requestPermission();
              print('response : $resp');
              if (resp != null) {
                var response = await ordersController.getCurrentPosition();

                if (response == true) {
                  ordersController.onCameraMove();
                  Get.to(() => AddAddress());
                }
              }
            },
            child: Container(
              color: whiteOp3,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.gps_fixed,
                    color: black,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'useCurrentLocation'.tr,
                    style: kText16w500.copyWith(color: black),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "recentLocations".tr,
                      style: kText16w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: Obx(
                      () => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: ordersController.myData
                              .map((element) => Container(
                                    margin: EdgeInsets.only(bottom: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(
                                            0.0,
                                            3.0,
                                          ),
                                          blurRadius: 3.0,
                                          spreadRadius: 1.0,
                                        ), //BoxShadow
                                        //BoxShadow
                                      ],
                                    ),
                                    child: ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      leading: Icon(Icons.history),
                                      onTap: () async {
                                        ordersController.latitude.value =
                                            element['latitude'];
                                        ordersController.longitude.value =
                                            element['longitude'];
                                        ordersController.shortAddress.value =
                                            element['shortaddress'];
                                        ordersController.addressDescription
                                            .value = element['description'];

                                        Get.close(1);
                                      },
                                      title: Text(
                                        element['shortaddress'],
                                        style: kText15w400.copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        element['description'],
                                        style: kText11w400,
                                      ),
                                    ),
                                  ))
                              .toList()),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
