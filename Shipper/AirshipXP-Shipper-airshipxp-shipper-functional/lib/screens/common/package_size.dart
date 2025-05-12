import 'dart:ffi';

import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/orders_controller.dart';
import 'package:airshipxp_shipper/screens/common/package_weight.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageSize extends StatefulWidget {
  const PackageSize({super.key});

  @override
  State<PackageSize> createState() => _PackageSizeState();
}

class _PackageSizeState extends State<PackageSize> {
  OrdersController ordersController = Get.find();
  RxInt selected = 0.obs;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ordersController.selectedPackageSizeTitle.value =
          ordersController.selectedSizeSlots[0]['title'];
      ordersController.selectedPackageSizeDescription.value =
          ordersController.selectedSizeSlots[0]['description'];
    });
    super.initState();
  }

  @override
  void dispose() {
    ordersController.selectedPackageSizeTitle.value = "";
    ordersController.selectedPackageSizeDescription.value = "";
    print("Dispose of size called");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        titleText: 'packageSize'.tr,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Obx(
              () => ListView.separated(
                separatorBuilder: (context, index) => Seperator(),
                itemCount: ordersController.selectedSizeSlots.length,
                itemBuilder: (context, index) => Obx(
                  () => SizeContainer(
                    onTap: () {
                      selected.value = index;
                      ordersController.selectedPackageSizeTitle.value =
                          ordersController.selectedSizeSlots[index]['title'];
                      ordersController.selectedPackageSizeDescription.value =
                          ordersController.selectedSizeSlots[index]
                              ['description'];
                    },
                    isSelected: selected.value == index ? true : false,
                    size: ordersController.selectedSizeSlots[index]['title'],
                    description: ordersController.selectedSizeSlots[index]
                        ['description'],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ButtonPrimary(
                onPressed: () {
                  if (ordersController.selectedPackageSizeTitle.value != "" &&
                      ordersController.selectedPackageSizeDescription.value !=
                          "") {
                    print(ordersController.selectedPackageSizeTitle.value);
                    print(
                        ordersController.selectedPackageSizeDescription.value);
                    Get.to(() => PackageWeight());
                  }
                },
                title: 'continue'.tr),
          )
        ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class SizeContainer extends StatelessWidget {
  SizeContainer(
      {super.key,
      required this.size,
      required this.onTap,
      required this.description,
      required this.isSelected});

  String size;
  String description;
  bool isSelected;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? greyOp1 : white,
          border: Border.all(color: greyOp2),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 100,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              size,
              style: kText20w500.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              description,
              style: kText14w400.copyWith(color: greyOp5),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
