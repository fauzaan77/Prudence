import 'package:airshipxp_shipper/components/customToast.dart';
import 'package:airshipxp_shipper/models/empty_response.dart';
import 'package:airshipxp_shipper/models/transaction_details_response.dart';
import 'package:airshipxp_shipper/models/wallet_balance_response.dart';
import 'package:airshipxp_shipper/utilities/network_services/api_endpoints.dart';
import 'package:airshipxp_shipper/utilities/network_services/api_param.dart';
import 'package:airshipxp_shipper/utilities/network_services/network_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WalletController extends NetworkClient {
  RxInt selectedId = 0.obs;
  TextEditingController walletAmtController = TextEditingController();

  List transactionHistory = [
    {
      'title': 'Refund payment',
      'date': '22 May, 2022 . 4:53 PM',
      'amount': '\$ 250',
    },
    {
      'title': 'Payment mode name',
      'date': '22 May, 2022 . 4:53 PM',
      'amount': '-\$ 150',
    },
    {
      'title': 'Refund payment',
      'date': '22 May, 2022 . 4:53 PM',
      'amount': '\$ 250',
    },
    {
      'title': 'Payment mode name',
      'date': '22 May, 2022 . 4:53 PM',
      'amount': '-\$ 150',
    },
    {
      'title': 'Refund payment',
      'date': '22 May, 2022 . 4:53 PM',
      'amount': '\$ 250',
    },
    {
      'title': 'Payment mode name',
      'date': '22 May, 2022 . 4:53 PM',
      'amount': '-\$ 150',
    },
  ];

  TextEditingController amount = TextEditingController();
  dynamic balance = 0;
  RxBool loadingData = false.obs;
  RxBool loadingTransactionData = false.obs;
  RxList transactions = [].obs;
  RxInt totalCount = 0.obs;
  final scrollController = ScrollController();
  RxBool isLoadingMore = false.obs;
  RxInt skip = 0.obs;
  RxBool isFirstTimeLodingData = true.obs;

  void getWalletBalance() async {
    Map<String, Object> data = {};
    loadingData.value = true;
    WalletBalanceResponse walletBalanceResponse;

    get(ApiEndPoints.getWalletBalance, data).then((value) {
      walletBalanceResponse = walletBalanceResponseFromJson(value.toString());

      if (walletBalanceResponse.status == 200) {
        balance = walletBalanceResponse.data!.balance ?? 0.00;
        loadingData.value = false;
        print(walletBalanceResponse.data!.balance);
      } else {
        CustomToast.show(walletBalanceResponse.message!);
        loadingData.value = false;
      }
    }).catchError((onError) {
      loadingData.value = false;

      print(onError);
    });
  }

  void scrollListener() {
    if (isLoadingMore.value) return;
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        skip.value <= totalCount.value) {
      isLoadingMore.value = true;

      skip.value = skip.value + 10;
      getTransactionDetails(skip.value);

      isLoadingMore.value = false;
    }
  }

  getTransactionDetails(int skip) async {
    Map<String, Object> data = {};
    data[ApiParams.skip] = skip;
    data[ApiParams.limit] = 10;

    if (isFirstTimeLodingData.value == true) {
      loadingTransactionData.value = true;
      isFirstTimeLodingData.value = false;
    }

    TransactionDetailsResponse transactionDetailsResponse;
    post(ApiEndPoints.walletDetails, data).then((value) {
      transactionDetailsResponse =
          transactionDetailsResponseFromJson(value.toString());

      if (transactionDetailsResponse.status == 200) {
        transactionDetailsResponse.data?.details?.forEach((item) {
          transactions.add(item);
        });
        totalCount.value = (transactionDetailsResponse.data?.totalcount)!;
        print(totalCount.value);
        loadingTransactionData.value = false;
      } else {
        CustomToast.show(transactionDetailsResponse.message!);
        loadingTransactionData.value = false;
      }
    }).catchError((onError) {
      loadingTransactionData.value = false;

      print(onError);
    });
  }

  rechargeWallet(String amount, String transactionId) async {
    Map<String, Object> data = {};
    data[ApiParams.amount] = amount;
    // data[ApiParams.transactionamount] = amount;
    data[ApiParams.transactionid] = transactionId;

    EmptyResponse emptyResponse;
    loadingData.value = true;

    return post(ApiEndPoints.walletRecharge, data).then((value) async {
      emptyResponse = emptyResponseFromJson(value.toString());

      if (emptyResponse.status == 200) {
        loadingData.value = false;

        getWalletBalance();
        CustomToast.show(emptyResponse.message!);
        return "WalletRecharged";
      } else {
        loadingData.value = false;
        CustomToast.show(emptyResponse.message!);
        return "";
      }
    }).catchError((onError) {
      print(onError);
      loadingData.value = false;
      return "";
    });
  }
}
