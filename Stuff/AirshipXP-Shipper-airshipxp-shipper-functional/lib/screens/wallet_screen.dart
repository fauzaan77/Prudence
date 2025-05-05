import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/components/customToast.dart';
import 'package:airshipxp_shipper/controllers/profile_controller.dart';
import 'package:airshipxp_shipper/controllers/wallet_controller.dart';
import 'package:airshipxp_shipper/screens/transaction_history.dart';
import 'package:airshipxp_shipper/utilities/stripe_payment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  StripePayment stripePayment = Get.put(StripePayment());
  ProfileController profileController = Get.find();

  final WalletController walletController = Get.put(WalletController());
  var scrWidth = Get.width;
  RxInt chooseAmt = 0.obs;
  RxInt selectedId = 0.obs;
  dynamic transactionDetails = {};

  List amounts = [
    {"id": 1, "amount": 10},
    {"id": 2, "amount": 20},
    {"id": 3, "amount": 30},
    {"id": 4, "amount": 40},
    {"id": 5, "amount": 50},
    {"id": 6, "amount": 60}
  ];

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
        titleText: 'wallet'.tr,
        style: kText22w600,
        action: [
          CustomBox(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 40,
            borderRadius: BorderRadius.circular(15),
            borderColor: greyOp3,
            link: true,
            onTap: () {
              Get.to(() => TransactionHistoryScreen());
            },
            child: Text(
              'viewHistory'.tr,
              style: kText12w300.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => walletController.loadingData.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : SingleChildScrollView(
                child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        kToolbarHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: greyOp2)),
                            height: 170,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/images/wallet.png',
                                    height: 100,
                                    width: 140,
                                    fit: BoxFit.contain,
                                  ),
                                  VerticalDivider(
                                    indent: 15,
                                    endIndent: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'walletBalance'.tr,
                                          style: kText20w500,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '\$ ${walletController.balance.toStringAsFixed(2)}',
                                          style: kText30w500.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'addMoney'.tr,
                            style: kText16w700,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'chooseAmt'.tr,
                            style: kText12w300.copyWith(
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GridView.count(
                              childAspectRatio: 2.5,
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              crossAxisSpacing: scrWidth * 0.03,
                              mainAxisSpacing: scrWidth * 0.03,
                              padding: EdgeInsets.only(top: 8),
                              children: amounts
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () {
                                        selectedId.value = e['id'];
                                        chooseAmt.value = e['amount'];
                                        walletController.amount.text = '';
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        print(chooseAmt.value);
                                      },
                                      child: Obx(
                                        () => Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width:
                                                    selectedId.value == e['id']
                                                        ? 3
                                                        : 1,
                                                color:
                                                    selectedId.value == e['id']
                                                        ? Colors.black
                                                        : inActiveGreyText),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '\$ ${e['amount'].toStringAsFixed(2)}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()),
                          const SizedBox(height: 22),
                          TextField(
                            controller: walletController.amount,
                            textAlignVertical: TextAlignVertical.bottom,
                            keyboardType:
                                defaultTargetPlatform == TargetPlatform.iOS
                                    ? const TextInputType.numberWithOptions(
                                        decimal: true, signed: true)
                                    : const TextInputType.numberWithOptions(
                                        decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,3}')),
                              // FilteringTextInputFormatter.allow(
                              //     RegExp('[0-9.]')),
                            ],
                            decoration: const InputDecoration(
                              constraints: BoxConstraints(maxHeight: 50),
                              hintText: '\$ Enter an amount',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: inActiveGreyText,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.zero,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: inActiveGreyText,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onTap: () {
                              chooseAmt.value = 0;
                              selectedId.value = 0;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ButtonPrimary(
                        onPressed: () async {
                          if (chooseAmt.value > 0 ||
                              (walletController.amount.text != '' &&
                                  double.parse(walletController.amount.text) >=
                                      1)) {
                            var respData = await stripePayment.makePayment(
                              email: profileController.email.text,
                              amount: chooseAmt.value > 0
                                  ? chooseAmt.value.toString()
                                  : double.parse((double.parse(
                                              walletController.amount.text))
                                          .toStringAsFixed(2))
                                      .toString(),
                              context: context,
                            );

                            if (respData != "") {
                              print('respData : $respData');
                              walletController
                                  .rechargeWallet(
                                      "${chooseAmt.value > 0 ? chooseAmt.value : walletController.amount.text}",
                                      respData)
                                  .then((value) {
                                if (value == "WalletRecharged") {
                                  chooseAmt.value = 0;
                                  selectedId.value = 0;
                                  walletController.amount.text = "";
                                }
                              });
                            }
                          } else {
                            if (chooseAmt.value > 0 ||
                                (walletController.amount.text != '' &&
                                    double.parse(walletController.amount.text) <
                                        1)) {
                              CustomToast.show("Please enter a valid amount .");
                            } else {
                              CustomToast.show("Please enter amount.");
                            }
                          }
                        },
                        title: 'continue'.tr,
                      ),
                    ),
                  ],
                ),
              )),
      ),
    );
  }
}

// ignore: must_be_immutable
class AmountContainer extends StatelessWidget {
  AmountContainer(
      {super.key, required this.amount, this.onTap, required this.id});
  String amount;
  VoidCallback? onTap;
  final WalletController walletController = Get.find();
  int id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Container(
          height: 30,
          width: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
                color: walletController.selectedId == id ? black : greyOp2,
                width: walletController.selectedId == id ? 2 : 1),
          ),
          child: Text(
            '${'dollar'.tr} $amount',
            style: kText18w400.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
