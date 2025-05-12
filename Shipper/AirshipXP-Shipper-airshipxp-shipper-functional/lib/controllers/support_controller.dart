import 'package:airshipxp_shipper/components/customToast.dart';
import 'package:airshipxp_shipper/models/empty_response.dart';
import 'package:airshipxp_shipper/models/issue_response.dart';
import 'package:airshipxp_shipper/utilities/network_services/api_endpoints.dart';
import 'package:airshipxp_shipper/utilities/network_services/api_param.dart';
import 'package:airshipxp_shipper/utilities/network_services/network_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportController extends NetworkClient {
  RxString selectedItem = "".obs;
  TextEditingController issueDescription = TextEditingController();
  RxBool loadingData = false.obs;
  final scrollController = ScrollController();
  RxBool isLoadingMore = false.obs;
  RxInt total = 0.obs;
  RxBool isFirstTimeLoadingData = true.obs;
  RxInt skip = 0.obs;

  RxList<String> items = [
    'Personal issue',
    'Package issue',
  ].obs;

  RxList myIssues = [].obs;

  addComplaint(bookingId) async {
    Map<String, Object> data = {
      ApiParams.issuetitle: selectedItem.value,
      ApiParams.issuedesc: issueDescription.text,
      // ApiParams.bookingid: bookingId,
    };
    print(data);

    EmptyResponse emptyResponse;
    loadingData.value = true;
    return post(ApiEndPoints.reportIssue, data).then((value) async {
      emptyResponse = emptyResponseFromJson(value.toString());

      if (emptyResponse.status == 200) {
        CustomToast.show(emptyResponse.message!);
        return "issueRaised";
      } else {
        loadingData.value = false;
        CustomToast.show(emptyResponse.message!);
        return "";
      }
    }).catchError((onError) {
      loadingData.value = true;
      print(onError);
      return "";
    });
  }

  getIssues(skip) async {
    Map<String, Object> data = {};

    data[ApiParams.skip] = skip;
    data[ApiParams.limit] = 5;

    IssueResponse issueResponse;

    if (isFirstTimeLoadingData.value == true) {
      loadingData.value = true;
      isFirstTimeLoadingData.value = false;
    }
    post(ApiEndPoints.issueList, data).then((value) async {
      issueResponse = issueResponseFromJson(value.toString());
      print('coupon.status : ${issueResponse.status}');

      if (issueResponse.status == 200) {
        issueResponse.data?.details?.forEach((item) {
          myIssues.add(item);
        });
        total.value = issueResponse.data!.totalcount!;
        loadingData.value = false;
      } else {
        loadingData.value = false;
        print(issueResponse.message);
        CustomToast.show(issueResponse.message!);
      }
    }).catchError((onError) {
      print(onError);
      loadingData.value = false;
    });
  }

  void scrollListener() {
    if (isLoadingMore.value == true) return;
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        skip.value <= total.value) {
      isLoadingMore.value = true;

      skip.value = skip.value + 5;
      getIssues(skip.value);

      isLoadingMore.value = false;
    }
  }
}
