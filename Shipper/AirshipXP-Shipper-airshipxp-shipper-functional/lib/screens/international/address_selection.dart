import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/components/constants.dart';
import 'package:airshipxp_shipper/controllers/google_map_controller.dart';
import 'package:airshipxp_shipper/screens/international/order_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class AddressSelection extends StatefulWidget {
  const AddressSelection({super.key});

  @override
  State<AddressSelection> createState() => _AddressSelectionState();
}

class _AddressSelectionState extends State<AddressSelection> {
  final GoogleMapController mapController = Get.put(GoogleMapController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'addressSelection'.tr,
        leading: true,
        action: [
          TextButtonPrimary(
              onPressed: () {
                Get.to(
                  () => OrderTypeSelect(),
                );
              },
              label: 'done'.tr)
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GooglePlaceAutoCompleteTextField(
            textEditingController: mapController.inputText,
            googleAPIKey: google_map_key,
            inputDecoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.location_on_sharp,
                size: 35,
                color: black,
              ),
              hintText: 'search'.tr,
              hintStyle: kText16w500,
              border: InputBorder.none,
            ),
            getPlaceDetailWithLatLng: (Prediction prediction) {},
            // countries: const ["in"],
            isLatLngRequired: true,
            boxDecoration: BoxDecoration(
                border: Border.all(color: inActiveGrey),
                borderRadius: BorderRadius.circular(10)),
            itemClick: (Prediction prediction) async {},
            itemBuilder: (context, index, Prediction prediction) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(
                      width: 7,
                    ),
                    Expanded(
                        child: Text(
                      "${prediction.description ?? ""}",
                      style: kText14w500,
                    ))
                  ],
                ),
              );
            },
            seperatedBuilder: const Divider(),
            isCrossBtnShown: true,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () async {
            var resp = await mapController.requestPermission();
            print('response : $resp');
            if (resp != null) {
              var response = await mapController.getCurrentPosition();
              if (response == true) {
                print('TRUEE');
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.gps_fixed,
                  color: black,
                  size: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'currentLoc'.tr,
                  style: kText14w500.copyWith(color: black),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
