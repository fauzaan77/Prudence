import 'dart:convert';

import 'package:airshipxp_shipper/components/customToast.dart';
import 'package:airshipxp_shipper/models/booking_details_response.dart';
import 'package:airshipxp_shipper/models/order_history_response.dart';
import 'package:airshipxp_shipper/utilities/network_services/api_endpoints.dart';
import 'package:airshipxp_shipper/utilities/network_services/api_param.dart';
import 'package:airshipxp_shipper/utilities/network_services/network_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryController extends NetworkClient {
  final orderTypes = ['All', 'Upcoming', 'Ongoing', 'Past'];

  RxString selectedOrder = 'All'.obs;

  List orders = [
    'Delivered',
    'Canceled',
    'Delivered',
    'Canceled',
    'Pending',
  ];

  List ordersPending = [
    'Pending',
    'Pending',
    'Pending',
    'Pending',
    'Pending',
  ];

  RxList responseData = [].obs;
  RxInt skip = 0.obs;
  RxBool loadingData = false.obs;
  final scrollController = ScrollController();
  RxBool isLoadingMore = false.obs;
  RxInt total = 0.obs;
  RxBool isFirstTimeLoadingData = true.obs;
  RxMap<dynamic, dynamic> availableBookingResponse = {}.obs;
  RxBool loadingTripDetailsData = false.obs;
  RxMap<dynamic, dynamic> bookingDetails = {}.obs;
  RxMap<dynamic, dynamic> bookingDetailsResp = {}.obs;

  getOrders(myRideType, skip) async {
    print('$myRideType, $skip');
    Map<String, Object> data = {};

    data[ApiParams.status] = myRideType;
    data[ApiParams.skip] = skip;
    data[ApiParams.limit] = 5;

    OrderHistoryResponse orderHistoryResponse;

    if (isFirstTimeLoadingData.value == true) {
      loadingData.value = true;
      isFirstTimeLoadingData.value = false;
    }
    post(ApiEndPoints.getShipperBookings, data).then((value) async {
      orderHistoryResponse = orderHistoryResponseFromJson(value.toString());

      if (orderHistoryResponse.status == 200) {
        var strJsonData = jsonEncode(value.data);
        availableBookingResponse.value =
            Map<dynamic, dynamic>.from(json.decode(strJsonData));
        availableBookingResponse['data']['bookings'].forEach((item) {
          responseData.add(item);
        });

        total.value = availableBookingResponse['data']['totalcount'];
        print(total.value);
        loadingData.value = false;
      } else {
        loadingData.value = false;
        print(orderHistoryResponse.message);
        CustomToast.show(orderHistoryResponse.message!);
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
      print("inside scrollListener");
      isLoadingMore.value = true;

      skip.value = skip.value + 5;
      getOrders(selectedOrder.value, skip.value);

      isLoadingMore.value = false;
    }
  }

  getBookingDetails(bookingid) async {
    Map<String, Object> data = {};

    data[ApiParams.bookingid] = bookingid;

    BookingDetailsResponse bookingDetailsResponse;

    loadingTripDetailsData.value = true;

    post(ApiEndPoints.getShipperBooking, data).then((value) async {
      bookingDetailsResponse = bookingDetailsResponseFromJson(value.toString());

      if (bookingDetailsResponse.status == 200) {
        var strJsonData = jsonEncode(value.data);
        bookingDetailsResp.value =
            Map<dynamic, dynamic>.from(json.decode(strJsonData));
        bookingDetails.value = bookingDetailsResp['data'];

        print(bookingDetails.value);

        loadingTripDetailsData.value = false;
      } else {
        loadingTripDetailsData.value = false;
        print(bookingDetailsResponse.message);
        CustomToast.show(bookingDetailsResponse.message!);
      }
    }).catchError((onError) {
      print(onError);
      loadingTripDetailsData.value = false;
    });
  }
}
