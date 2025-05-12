import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/orders_controller.dart';
import 'package:airshipxp_shipper/screens/common/request_summary.dart';
import 'package:airshipxp_shipper/screens/international/pickup_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageWeight extends StatefulWidget {
  PackageWeight({super.key, this.city, this.domestic});
  bool? city;
  bool? domestic;

  @override
  State<PackageWeight> createState() => _PackageWeightState();
}

class _PackageWeightState extends State<PackageWeight> {
  OrdersController ordersController = Get.find();
  RxInt selected = 0.obs;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ordersController.selectedPackageWeight.value =
          '${ordersController.selectedWeightSlot[0]['lowerlimit']} - ${ordersController.selectedWeightSlot[0]['upperlimit']} lbs';
      ordersController.selectedPackageBaseRate.value =
          ordersController.selectedWeightSlot[0]['baserate'].toDouble();
    });
    super.initState();
  }

  @override
  void dispose() {
    ordersController.selectedPackageWeight.value = "";
    ordersController.selectedPackageBaseRate.value = 0.0;
    print("Dispose of Weight called");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        titleText: 'selectWeight'.tr,
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
                itemCount: ordersController.selectedWeightSlot.length,
                itemBuilder: (context, index) => Obx(
                  () => WeightContainer(
                    weight: 'weightTxt'.tr,
                    description:
                        '${ordersController.selectedWeightSlot[index]['lowerlimit']} - ${ordersController.selectedWeightSlot[index]['upperlimit']} lbs',
                    isSelected: selected.value == index ? true : false,
                    onTap: () {
                      selected.value = index;
                      ordersController.selectedPackageWeight.value =
                          '${ordersController.selectedWeightSlot[index]['lowerlimit']} - ${ordersController.selectedWeightSlot[index]['upperlimit']} lbs';
                      ordersController.selectedPackageBaseRate.value =
                          ordersController.selectedWeightSlot[index]['baserate']
                              .toDouble();
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ButtonPrimary(
                onPressed: () {
                  if (ordersController.selectedPackageWeight.value != "" &&
                      ordersController.selectedPackageBaseRate.value != 0.0) {
                    print(ordersController.selectedPackageWeight.value);
                    print(ordersController.selectedPackageBaseRate.value);
                    Get.to(() => RequestSummary());
                  }

                  // if(widget.domestic == true){
                  //   Get.to(() => PickupDateSelect());
                  // }
                  // else{
                  //   Get.to(() => RequestSummary());
                  // }
                },
                title: 'continue'.tr),
          )
        ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class WeightContainer extends StatelessWidget {
  WeightContainer(
      {super.key,
      required this.weight,
      required this.onTap,
      required this.description,
      required this.isSelected});

  String weight;
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
              weight,
              style: kText20w500.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
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
