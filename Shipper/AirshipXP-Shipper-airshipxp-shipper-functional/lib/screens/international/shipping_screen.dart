import 'dart:async';

import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/components/customToast.dart';
import 'package:airshipxp_shipper/controllers/orders_controller.dart';
import 'package:airshipxp_shipper/screens/international/enter_order_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  OrdersController ordersController = Get.find();
  TextEditingController searchText = TextEditingController();
  RxString _query = "".obs;
  RxList filteredCities = [].obs;

  @override
  void dispose() {
    searchText.clear();
    _query.value = "";
    ordersController.selectedDestCountry.value = "";
    ordersController.selectedDestCity.value = "";
    ordersController.selectedDestCountryCode.value = "";
    ordersController.selectedDestCityId.value = 0;
    ordersController.allDestCities.value = [];
    ordersController.allDestCitiesResponseData.value = {};
    print("Dispose Called");
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ordersController.getAllDestinationCities(false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        titleText: 'sendPackage'.tr,
      ),
      body: Obx(
        () => ordersController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : ordersController.allDestCities.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height - 80,
                        ),
                        child: Column(children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Divider(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'shippingFrom'.tr,
                                        style: kText14w400.copyWith(
                                          color: greyOp5,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${ordersController.selectedCity.value ?? ''}, ${ordersController.selectedCountry.value ?? ''} - ${ordersController.selectedCountryCode.value ?? ""}',
                                        style: kText18w600,
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  Text(
                                    'whereToShip'.tr,
                                    style: kText30w500.copyWith(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Obx(
                                    () => ordersController
                                            .allDestCities.isNotEmpty
                                        ? InkWell(
                                            onTap: () =>
                                                showDestCitiesBottomSheet(
                                                    context),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border:
                                                    Border.all(color: greyOp2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              height: 50,
                                              child: Row(
                                                children: [
                                                  Obx(
                                                    () => ordersController
                                                                .selectedDestCountryCode
                                                                .value !=
                                                            ""
                                                        ? Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: const Color
                                                                  .fromRGBO(
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
                                                                        .selectedDestCountryCode
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
                                                        ordersController
                                                                    .selectedDestCountry
                                                                    .value ==
                                                                ""
                                                            ? 'selectDestinationCity'
                                                                .tr
                                                            : '${ordersController.selectedDestCity.value ?? ''}, ${ordersController.selectedDestCountry.value ?? ''}',
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
                                ]),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            child: ButtonPrimary(
                                onPressed: () {
                                  print(ordersController.selectedCityId.value);
                                  print(ordersController.selectedCity.value);
                                  print(ordersController.selectedCountry.value);
                                  print(ordersController
                                      .selectedCountryCode.value);
                                  print(
                                      "+++++++++++++++++++++++++++++++++++++++++");
                                  print(ordersController
                                      .selectedDestCityId.value);
                                  print(
                                      ordersController.selectedDestCity.value);
                                  print(ordersController
                                      .selectedDestCountry.value);
                                  print(ordersController
                                      .selectedDestCountryCode.value);
                                  if (ordersController
                                          .selectedDestCityId.value !=
                                      0) {
                                    Get.to(() => EnterOrderDetails());
                                  } else {
                                    CustomToast.show(
                                        "pleaseSelectDestCityToContinue".tr);
                                  }
                                },
                                title: 'next'.tr),
                          )
                        ]),
                      ),
                    ),
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

  showDestCitiesBottomSheet(context) {
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
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        ordersController
                                                .selectedDestCountry.value =
                                            filteredCities[index]['country'];
                                        ordersController
                                                .selectedDestCity.value =
                                            filteredCities[index]['city'];
                                        ordersController
                                                .selectedDestCountryCode.value =
                                            filteredCities[index]
                                                ['countrycode'];
                                        ordersController
                                                .selectedDestCityId.value =
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
                                itemCount:
                                    ordersController.allDestCities.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    ordersController.selectedDestCountry.value =
                                        ordersController.allDestCities[index]
                                            ['country'];
                                    ordersController.selectedDestCity.value =
                                        ordersController.allDestCities[index]
                                            ['city'];
                                    ordersController
                                            .selectedDestCountryCode.value =
                                        ordersController.allDestCities[index]
                                            ['countrycode'];
                                    ordersController.selectedDestCityId.value =
                                        ordersController.allDestCities[index]
                                            ['id'];

                                    Get.back();

                                    searchText.clear();
                                    _query.value = "";
                                    filteredCities.value = [];
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 14),
                                    child: Text(
                                      '${ordersController.allDestCities[index]['city'] ?? ""}, ${ordersController.allDestCities[index]['country'] ?? ""} (${ordersController.allDestCities[index]['countrycode'] ?? ""})',
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

    filteredCities.value = ordersController.allDestCities
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
