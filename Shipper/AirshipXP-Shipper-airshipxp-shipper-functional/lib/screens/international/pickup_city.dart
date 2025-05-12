import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/components/customToast.dart';
import 'package:airshipxp_shipper/controllers/orders_controller.dart';
import 'package:airshipxp_shipper/screens/international/pickup_airport.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class PickupCityScreen extends StatefulWidget {
  const PickupCityScreen({super.key});

  @override
  State<PickupCityScreen> createState() => _PickupCityScreenState();
}

class _PickupCityScreenState extends State<PickupCityScreen> {
  OrdersController ordersController = Get.put(OrdersController());
  TextEditingController searchText = TextEditingController();
  RxString _query = "".obs;
  RxList filteredCities = [].obs;

  @override
  void dispose() {
    searchText.clear();
    _query.value = "";

    print("Dispose Called");
    super.dispose();
  }

  @override
  void initState() {
    ordersController.getAllCities(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'sendPackage'.tr,
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
              ordersController.resetBookingData();
              Get.back();
            }),
      ),
      body: Obx(
        () => ordersController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : ordersController.allCities.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      Column(
                        children: [
                          Text(
                            'pickupCity'.tr,
                            style: kText30w500.copyWith(
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Obx(
                            () => ordersController.allCities.isNotEmpty
                                ? InkWell(
                                    onTap: () => showCitiesBottomSheet(context),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: greyOp2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 50,
                                      child: Row(
                                        children: [
                                          Obx(
                                            () => ordersController
                                                        .selectedCountryCode
                                                        .value !=
                                                    ""
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          const Color.fromRGBO(
                                                              217,
                                                              217,
                                                              217,
                                                              0.5),
                                                    ),
                                                    height: 50,
                                                    width: 75,
                                                    child: Center(
                                                      child: Text(
                                                        ordersController
                                                                .selectedCountryCode
                                                                .value ??
                                                            "",
                                                        style: kText16w600
                                                            .copyWith(
                                                                color: Colors
                                                                    .green),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Obx(
                                              () => Text(
                                                ordersController.selectedCountry
                                                            .value ==
                                                        ""
                                                    ? 'selectPickupCity'.tr
                                                    : '${ordersController.selectedCity.value ?? ''}, ${ordersController.selectedCountry.value ?? ''}',
                                                style: kText14w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ButtonPrimary(
                            onPressed: () {
                              if (ordersController.selectedCityId.value != 0) {
                                Get.to(() => PickupAirportScreen());
                              } else {
                                CustomToast.show(
                                    "pleaseSelectPickupCityToContinue".tr);
                              }
                            },
                            title: 'next'.tr),
                      )
                    ]),
                  )
                : Center(
                    child: Text(
                      "noCitiesFound".tr,
                      style: kText16w600,
                    ),
                  ),
      ),
    );
  }

  showCitiesBottomSheet(context) {
    showModalBottomSheet(
        showDragHandle: true,
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
              width: Get.width,
              padding: EdgeInsets.only(
                  top: 0, bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Text(
                        "selectCity".tr,
                        style: kText22w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: TextFormField(
                      controller: searchText,
                      onChanged: (query) {
                        search(query);

                        if (query.isEmpty) {
                          filteredCities.value = [];
                        }
                      },
                      style: kText16w500.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: textboxDecoration(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "allCities".tr,
                      style: kText14w400,
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Obx(
                        () => filteredCities.isNotEmpty || _query.isNotEmpty
                            ? filteredCities.isEmpty
                                ? Center(
                                    child: Text(
                                      'noResultsFound'.tr,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  )
                                : ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                      height: 2,
                                      color: Colors.black12,
                                    ),
                                    itemCount: filteredCities.length,
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        ordersController.selectedCountry.value =
                                            filteredCities[index]['country'];
                                        ordersController.selectedCity.value =
                                            filteredCities[index]['city'];
                                        ordersController
                                                .selectedCountryCode.value =
                                            filteredCities[index]
                                                ['countrycode'];
                                        ordersController.selectedCityId.value =
                                            filteredCities[index]['id'];
                                        Get.back();
                                        searchText.clear();
                                        _query.value = "";
                                        filteredCities.value = [];
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 14),
                                        child: Text(
                                          '${filteredCities[index]['city'] ?? ""}, ${filteredCities[index]['country'] ?? ""} (${filteredCities[index]['countrycode'] ?? ""})',
                                          style: kText16w600,
                                        ),
                                      ),
                                    ),
                                  )
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  height: 2,
                                  color: Colors.black12,
                                ),
                                itemCount: ordersController.allCities.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    ordersController.selectedCountry.value =
                                        ordersController.allCities[index]
                                            ['country'];
                                    ordersController.selectedCity.value =
                                        ordersController.allCities[index]
                                            ['city'];
                                    ordersController.selectedCountryCode.value =
                                        ordersController.allCities[index]
                                            ['countrycode'];
                                    ordersController.selectedCityId.value =
                                        ordersController.allCities[index]['id'];
                                    Get.back();
                                    searchText.clear();
                                    _query.value = "";
                                    filteredCities.value = [];
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 14),
                                    child: Text(
                                      '${ordersController.allCities[index]['city'] ?? ""}, ${ordersController.allCities[index]['country'] ?? ""} (${ordersController.allCities[index]['countrycode'] ?? ""})',
                                      style: kText16w600,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ) // From with TextField inside
              );
        });
  }

  void search(String query) {
    print(query);
    _query.value = query;

    filteredCities.value = ordersController.allCities
        .where(
          (item) =>
              item['country'].toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
              item['city'].toLowerCase().contains(
                    query.toLowerCase(),
                  ),
        )
        .toList();
    filteredCities.forEach((element) {
      print(element['country']);
    });
  }

  InputDecoration textboxDecoration() {
    return kTextInputDecoration.copyWith(
      contentPadding:
          const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 14),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: inActiveGreyText,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: inActiveGrey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8)),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade200,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8)),
      errorMaxLines: 2,
      hintText: "searchCityCountry".tr,
      hintStyle: kText16w500.copyWith(color: inActiveGreyText),
      suffixIcon: IconButton(
        onPressed: () {
          filteredCities.value = [];
          _query.value = "";
          searchText.clear();
        },
        icon: const Icon(Icons.clear),
      ),
    );
  }
}
