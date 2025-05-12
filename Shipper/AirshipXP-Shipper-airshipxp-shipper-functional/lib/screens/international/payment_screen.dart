import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/orders_controller.dart';
import 'package:airshipxp_shipper/controllers/profile_controller.dart';
import 'package:airshipxp_shipper/controllers/wallet_controller.dart';
import 'package:airshipxp_shipper/screens/common/success_order_creation.dart';
import 'package:airshipxp_shipper/utilities/stripe_payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSelection extends StatefulWidget {
  const PaymentSelection({super.key});

  @override
  State<PaymentSelection> createState() => _PaymentSelectionState();
}

class _PaymentSelectionState extends State<PaymentSelection> {
  ProfileController profileController = Get.find();
  WalletController walletController = Get.put(WalletController());
  OrdersController ordersController = Get.find();

  @override
  void initState() {
    walletController.amount.text = "";
    walletController.getWalletBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        titleText: 'paymentMethod'.tr,
      ),
      body: Obx(
        () => ordersController.isLoading.value == true ||
                walletController.loadingData.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Column(children: [
                      CustomBox(
                        shadow: true,
                        bgColor: Color.fromRGBO(0, 0, 0, 0.08),
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        link: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'totalAmt'.tr,
                              style: kText16w700,
                            ),
                            Text(
                              '\$ ${ordersController.totalAmount.value.toStringAsFixed(2)}',
                              style: kText14w500,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      CustomBox(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          onTap: () {
                            ordersController.isWalletChecked.value =
                                !ordersController.isWalletChecked.value;
                          },
                          shadow: true,
                          link: true,
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                color: black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${'walletBalance'.tr} \$ ${walletController.balance.toStringAsFixed(2)}',
                                      style: kText14w600,
                                    ),
                                    Text(
                                      'wallet'.tr,
                                      style:
                                          kText14w400.copyWith(color: greyOp4),
                                    )
                                  ],
                                ),
                              ),
                              Obx(
                                () => Checkbox(
                                    activeColor: black,
                                    value:
                                        ordersController.isWalletChecked.value,
                                    onChanged: (value) {
                                      ordersController.isWalletChecked.value =
                                          value!;
                                    }),
                              )
                            ],
                          ))
                    ]),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                      child: ButtonPrimary(
                          onPressed: () {
                            print(ordersController.isWalletChecked.value);

                            ordersController.onPayNowButtonPress(
                                walletController.balance.toDouble(),
                                profileController.email.text,
                                context);
                          },
                          title: 'payNow'.tr),
                    ),
                  ]),
      ),
    );
  }
}
