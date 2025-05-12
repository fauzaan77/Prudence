import 'package:airshipxp_shipper/components/customToast.dart';
import 'package:airshipxp_shipper/models/notification_response.dart';
import 'package:airshipxp_shipper/utilities/network_services/api_endpoints.dart';
import 'package:airshipxp_shipper/utilities/network_services/api_param.dart';
import 'package:airshipxp_shipper/utilities/network_services/network_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends NetworkClient {
  RxList allNotifications = [].obs;
  RxBool loading = false.obs;
  final scrollController = ScrollController();
  RxBool isLoadingMore = false.obs;
  RxInt skip = 0.obs;
  RxBool loadingData = false.obs;
  RxBool isFirstTimeLoadingData = true.obs;
  RxInt totalCount = 0.obs;

  resetNotification() {
    allNotifications.value = [];
    loading.value = false;
    isLoadingMore.value = false;
    skip.value = 0;
    loadingData.value = false;
    isFirstTimeLoadingData.value = true;
    totalCount.value = 0;
  }

  void scrollListener() {
    if (isLoadingMore.value) return;
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        skip.value <= totalCount.value) {
      isLoadingMore.value = true;

      skip.value = skip.value + 10;
      getNotifications(skip.value);

      isLoadingMore.value = false;
    }
  }

  getNotifications(int skip) async {
    if (isFirstTimeLoadingData.value == true) {
      loadingData.value = true;
      isFirstTimeLoadingData.value = false;
    }
    Map<String, Object> data = {};
    data[ApiParams.skip] = skip;
    data[ApiParams.limit] = 10;

    NotificationResponse notificationResponse;

    post(ApiEndPoints.getShipperNotifications, data).then((value) {
      notificationResponse = notificationResponseFromJson(value.toString());

      if (notificationResponse.status == 200) {
        notificationResponse.data?.notifications?.forEach((item) {
          allNotifications.add(item);
        });
        totalCount.value = (notificationResponse.data?.totalcount)!;
        loadingData.value = false;
      } else {
        CustomToast.show(notificationResponse.message!);
        loadingData.value = false;
      }
    }).catchError((onError) {
      print(onError);
    });
  }
}
