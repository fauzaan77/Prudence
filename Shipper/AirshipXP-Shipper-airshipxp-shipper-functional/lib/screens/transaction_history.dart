import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  WalletController walletController = Get.find();

  @override
  void initState() {
    walletController.scrollController
        .addListener(walletController.scrollListener);

    walletController.getTransactionDetails(walletController.skip.value);
    super.initState();
  }

  @override
  void dispose() {
    walletController.isFirstTimeLodingData.value = true;
    walletController.skip.value = 0;
    walletController.transactions.value = [];
    print("Dispose tra hist");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        titleText: 'transactionHistory'.tr,
        style: kText22w600,
      ),
      body: Obx(
        () => walletController.loadingTransactionData.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    width: double.infinity,
                    alignment: Alignment.center,
                    color: noteBg,
                    child: Text(
                      'historyNote'.tr,
                      style: kText16w500.copyWith(
                        fontWeight: FontWeight.w400,
                        color: grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.separated(
                      controller: walletController.scrollController,
                      itemCount: walletController.transactions.length,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return TransactionContainer(
                            amount: walletController
                                .transactions[index].transactionamount
                                .toStringAsFixed(2),
                            transaction: walletController
                                .transactions[index].transactiontype,
                            time: walletController
                                .transactions[index].transactiondate);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TransactionContainer extends StatelessWidget {
  TransactionContainer({
    super.key,
    required this.amount,
    required this.transaction,
    required this.time,
  });

  String amount;
  String transaction;
  String time;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: greyOp2)),
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  transaction,
                  style: kText16w700.copyWith(color: black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${DateFormat.jm().format(DateTime.parse(time).toLocal())}, ${DateFormat('EEE, MMM d').format(DateTime.parse(time).toLocal())}',
                  style: kText14w500.copyWith(color: grey),
                )
              ],
            ),
            Text(
              '\$$amount',
              style: kText16w500.copyWith(
                  color: transaction == "Withdraw" ? Colors.red : Colors.green),
            ),
          ]),
    );
  }
}
