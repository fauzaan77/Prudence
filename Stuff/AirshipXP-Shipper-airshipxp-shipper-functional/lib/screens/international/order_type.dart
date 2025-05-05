import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/orders_controller.dart';
import 'package:airshipxp_shipper/screens/common/package_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OrderTypeSelect extends StatefulWidget {
  OrderTypeSelect({super.key});

  @override
  State<OrderTypeSelect> createState() => _OrderTypeSelectState();
}

class _OrderTypeSelectState extends State<OrderTypeSelect> {
  OrdersController ordersController = Get.find();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ordersController.getAllParcelTypes();
    });
  }

  @override
  void dispose() {
    ordersController.selectedParcelTypeId.value = 0;
    ordersController.selectedParcelTypeName.value = "";
    ordersController.allParcelTypes.value = [];
    ordersController.allParcelTypesResponseData.value = {};
    ordersController.tax.value = 0.0;
    ordersController.selectedWeightSlot.value = [];
    ordersController.selectedSizeSlots.value = [];
    ordersController.selectedConveniencefee.value = 0.0;
    super.dispose();
  }

  RxInt seletedValue = 1.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: true,
          titleText: 'selectParclType'.tr,
        ),
        body: Obx(
          () => ordersController.isLoading.value == true
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
              : ordersController.allParcelTypes.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: Obx(
                            () => ListView.separated(
                              separatorBuilder: (context, index) => Seperator(),
                              itemCount: ordersController.allParcelTypes.length,
                              itemBuilder: (context, index) => Obx(
                                () => RadioContainer(
                                  onTap: () {
                                    ordersController
                                            .selectedParcelTypeId.value =
                                        ordersController.allParcelTypes[index]
                                            ['id'];
                                    ordersController.selectedWeightSlot.value =
                                        ordersController.allParcelTypes[index]
                                            ['weightslots'];
                                    ordersController.selectedSizeSlots.value =
                                        ordersController.allParcelTypes[index]
                                            ['sizeslots'];
                                    ordersController
                                            .selectedConveniencefee.value =
                                        ordersController.allParcelTypes[index]
                                                ['conveniencefee']
                                            .toDouble();
                                  },
                                  onChanged: (value) {
                                    ordersController
                                        .selectedParcelTypeId.value = value!;
                                    ordersController.selectedWeightSlot.value =
                                        ordersController.allParcelTypes[index]
                                            ['weightslots'];
                                    ordersController.selectedSizeSlots.value =
                                        ordersController.allParcelTypes[index]
                                            ['sizeslots'];
                                    ordersController
                                            .selectedConveniencefee.value =
                                        ordersController.allParcelTypes[index]
                                                ['conveniencefee']
                                            .toDouble();
                                  },
                                  title: ordersController.allParcelTypes[index]
                                      ['title'],
                                  subtitle: ordersController
                                      .allParcelTypes[index]['description'],
                                  value: ordersController.allParcelTypes[index]
                                      ['id'],
                                  groupValue: ordersController
                                      .selectedParcelTypeId.value,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ButtonPrimary(
                            onPressed: () {
                              if (ordersController.selectedParcelTypeId.value !=
                                      0 &&
                                  ordersController
                                      .selectedSizeSlots.isNotEmpty &&
                                  ordersController
                                      .selectedWeightSlot.isNotEmpty) {
                                print(ordersController
                                    .selectedParcelTypeId.value);
                                print(ordersController
                                    .selectedConveniencefee.value
                                    .toDouble());
                                print(ordersController.selectedSizeSlots.value);
                                print(
                                    ordersController.selectedWeightSlot.value);
                                Get.to(() => PackageSize());
                              }
                            },
                            title: 'proceed'.tr,
                          ),
                        )
                      ]),
                    )
                  : Center(
                      child: Text(
                        "noParcelTypesFound".tr,
                        style: kText16w600,
                      ),
                    ),
        ));
  }
}

// ignore: must_be_immutable
class RadioContainer extends StatelessWidget {
  RadioContainer(
      {super.key,
      required this.onTap,
      required this.onChanged,
      required this.title,
      required this.subtitle,
      required this.value,
      required this.groupValue});

  VoidCallback onTap;
  ValueChanged onChanged;
  String title;
  String subtitle;
  int value;
  int groupValue;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: lightGrey75,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(children: [
            Radio(
              activeColor: black,
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: kText20w700,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: kText16w500.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
