import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/components/countryPicker.dart';
import 'package:airshipxp_shipper/components/customToast.dart';
import 'package:airshipxp_shipper/controllers/orders_controller.dart';
import 'package:airshipxp_shipper/screens/international/address_selection.dart';
import 'package:airshipxp_shipper/screens/international/order_type.dart';
import 'package:airshipxp_shipper/screens/location/select_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EnterOrderDetails extends StatefulWidget {
  const EnterOrderDetails({super.key});

  @override
  State<EnterOrderDetails> createState() => _EnterOrderDetailsState();
}

class _EnterOrderDetailsState extends State<EnterOrderDetails> {
  OrdersController ordersController = Get.find();

  @override
  void dispose() {
    super.dispose();
    ordersController.resetLocationDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        titleText: 'enterOrderDetails'.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'shippingTo'.tr,
                          style: kText14w400.copyWith(
                            color: greyOp5,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${ordersController.selectedDestCity.value ?? ''}, ${ordersController.selectedDestCountry.value ?? ''} - ${ordersController.selectedDestCountryCode.value ?? ""}',
                          style: kText18w600,
                        )
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'detailedAddress'.tr,
                      style: kText18w600,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        Get.to(() => SelectLocation());
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                        decoration: BoxDecoration(
                          color: lightGrey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Obx(
                                () => Text(
                                  ordersController
                                              .addressDescription.value !=
                                          ""
                                      ? ordersController
                                          .addressDescription.value
                                      : "enterAddress".tr,
                                  style: kText18w400.copyWith(
                                      color: ordersController
                                                  .addressDescription.value !=
                                              ""
                                          ? Colors.black
                                          : inActiveGreyText,
                                      fontWeight: FontWeight.w300),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            const Icon(
                              Icons.location_on_sharp,
                              color: black,
                            )
                          ],
                        ),
                      ),
                    ),
                    // Text(
                    //   'enterTheAddress'.tr,
                    //   style: kText11w400.copyWith(color: greyOp5),
                    // ),
                    const Seperator(),
                    TextInputBox(
                      controller: ordersController.recipientName,
                      fillColor: lightGrey,
                      isFilled: true,
                      suffixIcon: const Icon(
                        Icons.person,
                        color: black,
                      ),
                      onValueChange: (value) {},
                      placeHolder: 'contactPersonName'.tr,
                    ),
                    const Seperator(),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: lightGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 9),
                          child: CountryPicker(
                            isShowDownIcon: false,
                            // arrowDownIconColor: Colors.black,
                            onCountryCodeChange: (value) {
                              ordersController.recipientCountrycode.value =
                                  value;
                              // });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextInputBox(
                            controller: ordersController.recipientPhone,
                            keyboardType: 'number',
                            fillColor: lightGrey,
                            isFilled: true,
                            suffixIcon: const Icon(
                              Icons.phone,
                              color: black,
                            ),
                            onValueChange: (value) {},
                            placeHolder: 'phoneNumber'.tr,
                          ),
                        ),
                      ],
                    ),
                    const Seperator(),
                    const Seperator(),
                    CustomBox(
                      padding: const EdgeInsets.all(8.0),
                      bgColor: whiteGrey25,
                      link: true,
                      onTap: () {
                        Get.bottomSheet(ParcelInstruction());
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.document_scanner_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'instructionForParcel'.tr,
                                      style: kText14w400,
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      size: 35,
                                    )
                                  ],
                                ),
                                Text(
                                  'theParcelWillBuy'.tr,
                                  softWrap: false,
                                  style: kText10w400.copyWith(
                                      color: greyOp5,
                                      overflow: TextOverflow.ellipsis),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ButtonPrimary(
                      onPressed: () {
                        if (ordersController.addressDescription.value != "" &&
                            ordersController.latitude.value != 0.0 &&
                            ordersController.longitude.value != 0.0) {
                          if (ordersController.recipientName.text == "") {
                            CustomToast.show("pleaseEnterAValidName".tr);
                          } else if (ordersController.recipientPhone.text ==
                                  "" ||
                              ordersController.recipientPhone.text.length <
                                  10) {
                            CustomToast.show("pleaseEnterAValidPhoneNumber".tr);
                          } else {
                            print(ordersController.addressDescription.value);
                            print(ordersController.shortAddress.value);
                            print(ordersController.latitude.value);
                            print(ordersController.longitude.value);
                            print(ordersController.recipientCountrycode.value);
                            print(ordersController.recipientName.text);
                            print(ordersController.recipientPhone.text);
                            print(ordersController.instructions.text);
                            Get.to(
                              () => OrderTypeSelect(),
                            );
                          }
                        } else {
                          CustomToast.show("pleaseEnterAddress".tr);
                        }
                      },
                      title: 'proceed'.tr),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ParcelInstruction extends StatelessWidget {
  ParcelInstruction({super.key});

  OrdersController ordersController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: white),
        height: 300,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'instructionForParcel'.tr,
                style: kText24w600.copyWith(fontWeight: FontWeight.w700),
              ),
              TextInputBox(
                controller: ordersController.instructions,
                outlineBorder: true,
                radius: BorderRadius.circular(15),
                minLine: 2,
                maxLine: 2,
                onValueChange: (value) {},
                placeHolder: 'parcelInstruction'.tr,
              ),
              ButtonPrimary(
                  onPressed: () {
                    Get.back();
                  },
                  title: 'continue'.tr),
            ]),
      ),
    );
  }
}
