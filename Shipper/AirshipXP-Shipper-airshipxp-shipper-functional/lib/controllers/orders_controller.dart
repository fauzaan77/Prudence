import 'dart:convert';
import 'dart:ffi';

import 'package:airshipxp_shipper/components/customToast.dart';
import 'package:airshipxp_shipper/local_database/local_db_service.dart';
import 'package:airshipxp_shipper/models/all_airports_response.dart';
import 'package:airshipxp_shipper/models/all_cities_response.dart';
import 'package:airshipxp_shipper/models/coupons_response.dart';
import 'package:airshipxp_shipper/models/create_booking_response.dart';
import 'package:airshipxp_shipper/models/package_collection_center_response.dart';
import 'package:airshipxp_shipper/models/parcel_types_response.dart';
import 'package:airshipxp_shipper/screens/common/success_order_creation.dart';
import 'package:airshipxp_shipper/utilities/network_services/api_endpoints.dart';
import 'package:airshipxp_shipper/utilities/network_services/api_param.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import '../components/constants.dart';
import '../utilities/network_services/network_client.dart';
import '../utilities/stripe_payment.dart';

class OrdersController extends NetworkClient {
  StripePayment stripePayment = Get.put(StripePayment());

  RxBool isLoading = false.obs;

  RxString selectedCountry = "".obs;
  RxString selectedCity = "".obs;
  RxString selectedCountryCode = "".obs;
  RxInt selectedCityId = 0.obs;
  RxList allCities = [].obs;
  RxMap<dynamic, dynamic> allCitiesResponseData = {}.obs;

  getAllCities(isFilterCollectionCenter) async {
    Map<String, Object> data = {};

    data[ApiParams.isFilterCollectionCenter] = isFilterCollectionCenter;

    AllCitiesResponse allCitiesResponse;
    isLoading.value = true;

    post(ApiEndPoints.getCitiesForShipper, data).then((value) async {
      allCitiesResponse = allCitiesResponseFromJson(value.toString());

      if (allCitiesResponse.status == 200) {
        var strJsonData = jsonEncode(value.data);
        allCitiesResponseData.value =
            Map<dynamic, dynamic>.from(json.decode(strJsonData));

        allCitiesResponseData['data']['cities'].forEach((item) {
          allCities.add(item);
        });
        // if (allCities.isNotEmpty) {
        //   selectedCountry.value = allCities[0]['country'];
        //   selectedCity.value = allCities[0]['city'];
        //   selectedCountryCode.value = allCities[0]['countrycode'];
        //   selectedCityId.value = allCities[0]['id'];
        // }
        print("all cities : ${allCities.value}");
        isLoading.value = false;

        // // Perform an asynchronous operation on each map
        // Future.forEach(listOfCities, (item) async {
        //   var res = await checkAirportsAvailable(item['id']);
        //   if (res == 'Exists') {
        //     allCities.add(item);
        //   }
        // }).then((_) {
        //   if (allCities.isNotEmpty) {
        //     selectedCountry.value = allCities[0]['country'];
        //     selectedCity.value = allCities[0]['city'];
        //     selectedCountryCode.value = allCities[0]['countrycode'];
        //     selectedCityId.value = allCities[0]['id'];
        //   }
        //   print("all cities : ${allCities.value}");
        //   isLoading.value = false;
        // });
      } else {
        isLoading.value = false;
        CustomToast.show(allCitiesResponse.message!);
      }
    }).catchError((onError) {
      print(onError);
      isLoading.value = false;
    });
  }

  //====================================

  //====================================
  //Airports
  RxInt selectedAirportId = 0.obs;
  RxString selectedAirportName = "".obs;
  RxList allAirports = [].obs;
  RxMap<dynamic, dynamic> allAirportsResponseData = {}.obs;

  checkAirportsAvailable(id) async {
    Map<String, Object> data = {};

    data[ApiParams.cityid] = id;

    AllAirportsResponse allAirportsResponse;

    return post(ApiEndPoints.getAirports, data).then((value) async {
      allAirportsResponse = allAirportsResponseFromJson(value.toString());

      if (allAirportsResponse.status == 200) {
        var strJsonData = jsonEncode(value.data);
        allAirportsResponseData.value =
            Map<dynamic, dynamic>.from(json.decode(strJsonData));

        if (allAirportsResponseData['data']['airports'].length > 0) {
          return "Exists";
        } else {
          return "Empty";
        }
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  getAllAirports() async {
    Map<String, Object> data = {};

    data[ApiParams.cityid] = selectedCityId.value;

    AllAirportsResponse allAirportsResponse;
    isLoading.value = true;

    post(ApiEndPoints.getAirports, data).then((value) async {
      allAirportsResponse = allAirportsResponseFromJson(value.toString());

      if (allAirportsResponse.status == 200) {
        var strJsonData = jsonEncode(value.data);
        allAirportsResponseData.value =
            Map<dynamic, dynamic>.from(json.decode(strJsonData));

        allAirportsResponseData['data']['airports'].forEach((item) {
          allAirports.add(item);
        });

        if (allAirports.isNotEmpty) {
          selectedAirportId.value = allAirports[0]['id'];
          selectedAirportName.value = allAirports[0]['name'];
        }
        print("all cities : ${allAirports.value}");
        isLoading.value = false;

        // List listOfAirports = allAirportsResponseData['data']['airports'];
        //
        // // Perform an asynchronous operation on each map
        // Future.forEach(listOfAirports, (item) async {
        //   var res = await checkCollectionCenterAvailability(item['id']);
        //   if (res == 'Exists') {
        //     allAirports.add(item);
        //   }
        // }).then((_) {
        //   if (allAirports.isNotEmpty) {
        //     selectedAirportId.value = allAirports[0]['id'];
        //     selectedAirportName.value = allAirports[0]['name'];
        //   }
        //   print("all cities : ${allAirports.value}");
        //   isLoading.value = false;
        // });
      } else {
        isLoading.value = false;
        CustomToast.show(allAirportsResponse.message!);
      }
    }).catchError((onError) {
      print(onError);
      isLoading.value = false;
    });
  }
  //====================================

  //====================================
  //Collection Centers
  RxInt selectedCollectionCenterId = 0.obs;
  RxString selectedCollectionCenterName = "".obs;
  RxList allCollectionCenters = [].obs;
  RxMap<dynamic, dynamic> allCollectionCenterResponseData = {}.obs;

  checkCollectionCenterAvailability(id) async {
    Map<String, Object> data = {};

    data[ApiParams.airportid] = id;

    PackageCollectionCenterResponse packageCollectionCenterResponse;

    return post(ApiEndPoints.getCollectionCenters, data).then((value) async {
      packageCollectionCenterResponse =
          packageCollectionCenterResponseFromJson(value.toString());

      if (packageCollectionCenterResponse.status == 200) {
        var strJsonData = jsonEncode(value.data);
        allCollectionCenterResponseData.value =
            Map<dynamic, dynamic>.from(json.decode(strJsonData));

        if (allCollectionCenterResponseData['data']['collectionCenters']
                .length >
            0) {
          return "Exists";
        } else {
          return "Empty";
        }
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  getAllCollectionCenters() async {
    Map<String, Object> data = {};

    data[ApiParams.airportid] = selectedAirportId.value;

    PackageCollectionCenterResponse packageCollectionCenterResponse;
    isLoading.value = true;

    post(ApiEndPoints.getCollectionCenters, data).then((value) async {
      packageCollectionCenterResponse =
          packageCollectionCenterResponseFromJson(value.toString());

      if (packageCollectionCenterResponse.status == 200) {
        var strJsonData = jsonEncode(value.data);
        allCollectionCenterResponseData.value =
            Map<dynamic, dynamic>.from(json.decode(strJsonData));
        allCollectionCenterResponseData['data']['collectionCenters']
            .forEach((item) {
          allCollectionCenters.add(item);
        });
        if (allCollectionCenters.isNotEmpty) {
          selectedCollectionCenterId.value = allCollectionCenters[0]['id'];
          selectedCollectionCenterName.value = allCollectionCenters[0]['name'];
        }
        print("all Collection centers : ${allCollectionCenters.value}");
        isLoading.value = false;
      } else {
        isLoading.value = false;
        CustomToast.show(packageCollectionCenterResponse.message!);
      }
    }).catchError((onError) {
      print(onError);
      isLoading.value = false;
    });
  }
  //====================================

  //====================================
  //Destination City
  RxString selectedDestCountry = "".obs;
  RxString selectedDestCity = "".obs;
  RxString selectedDestCountryCode = "".obs;
  RxInt selectedDestCityId = 0.obs;
  RxList allDestCities = [].obs;
  RxMap<dynamic, dynamic> allDestCitiesResponseData = {}.obs;

  getAllDestinationCities(isFilterCollectionCenter) async {
    Map<String, Object> data = {};
    data[ApiParams.isFilterCollectionCenter] = isFilterCollectionCenter;

    AllCitiesResponse allCitiesResponse;
    isLoading.value = true;

    post(ApiEndPoints.getCitiesForShipper, data).then((value) async {
      allCitiesResponse = allCitiesResponseFromJson(value.toString());

      if (allCitiesResponse.status == 200) {
        var strJsonData = jsonEncode(value.data);
        allDestCitiesResponseData.value =
            Map<dynamic, dynamic>.from(json.decode(strJsonData));
        allDestCitiesResponseData['data']['cities'].forEach((item) {
          print(item['id']);
          if (item['id'] != selectedCityId.value) {
            allDestCities.add(item);
          }
        });
        // if (allDestCities.isNotEmpty) {
        //   selectedDestCountry.value = allCities[0]['country'];
        //   selectedDestCity.value = allCities[0]['city'];
        //   selectedDestCountryCode.value = allCities[0]['countrycode'];
        //   selectedDestCityId.value = allCities[0]['id'];
        // }
        print("all cities : ${allDestCities.value}");
        isLoading.value = false;
      } else {
        isLoading.value = false;
        CustomToast.show(allCitiesResponse.message!);
      }
    }).catchError((onError) {
      print(onError);
      isLoading.value = false;
    });
  }
  //====================================

  //====================================
  //Delivery Address
  GoogleMapController? mapController;
  TextEditingController googlePlacesTextController = TextEditingController();
  RxString tempShortAddress = "".obs;
  RxString tempAddressDescription = "".obs;
  RxDouble tempLat = 0.0.obs;
  RxDouble tempLng = 0.0.obs;
  RxList<Map<String, dynamic>> myData = <Map<String, dynamic>>[].obs;

  RxString shortAddress = "".obs;
  RxString addressDescription = "".obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString recipientCountrycode = '+1'.obs;
  TextEditingController recipientPhone = TextEditingController();
  TextEditingController recipientName = TextEditingController();
  TextEditingController instructions = TextEditingController();

  getLatLngFromAddress(address) async {
    print(address);
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      tempLat.value = locations[0].latitude;
      tempLng.value = locations[0].longitude;

      return true;
    } else {
      return false;
    }
  }

  setShortAddress() async {
    List p = await placemarkFromCoordinates(tempLat.value, tempLng.value);

    Placemark place = p[0];

    tempShortAddress.value = "${place.locality}";
    print(tempShortAddress.value);
  }

  void onMapCreate(GoogleMapController controller) {
    print('==========================Called======================');
    mapController = controller;
  }

  onCameraMove() async {
    List p = await placemarkFromCoordinates(tempLat.value, tempLng.value);

    Placemark place = p[0];
    tempShortAddress.value = "${place.locality}";
    tempAddressDescription.value =
        "${place.name}, ${place.subAdministrativeArea}, ${place.subLocality}, ${place.administrativeArea}, ${place.postalCode}.";

    // await (SessionManager().setString(SessionManager.address2, address2.value));
  }

  requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    print("====================" '$permission' '==================');

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print(permission);
    }
    if (permission == LocationPermission.deniedForever) {
      Future permission = Geolocator.openAppSettings();
      print(permission);
    }
    if (permission == LocationPermission.denied) {
      return null;
      // return Future.error('Location permission is denied');
    }
    if (permission != LocationPermission.denied) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        return position;
      } catch (e) {
        print(e);
        return null;
      }
    }
  }

  getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    tempLat.value = position.latitude;
    tempLng.value = position.longitude;

    return true;
  }

  Future<void> addAddress() async {
    await DatabaseHelper.createAddress(tempShortAddress.value,
        tempAddressDescription.value, tempLat.value, tempLng.value);
    refreshData();
  }

  refreshData() async {
    final data = await DatabaseHelper.getAddress();
    myData.value = data;
  }

  resetLocationDetails() {
    googlePlacesTextController.text = "";
    tempShortAddress.value = "";
    tempAddressDescription.value = "";
    tempLat.value = 0.0;
    tempLng.value = 0.0;
    myData.value = [];

    shortAddress.value = "";
    addressDescription.value = "";
    latitude.value = 0.0;
    longitude.value = 0.0;

    recipientPhone.text = "";
    recipientName.text = "";
    instructions.text = "";
  }

  //End Delivery Address
  //====================================
  //================================================================
  //====================================
  //Parcel Types

  var tax = 0.0.obs;
  RxInt selectedParcelTypeId = 0.obs;
  RxString selectedParcelTypeName = "".obs;
  RxList selectedSizeSlots = [].obs;
  RxList selectedWeightSlot = [].obs;
  RxList allParcelTypes = [].obs;
  var selectedConveniencefee = 0.0.obs;
  RxMap<dynamic, dynamic> allParcelTypesResponseData = {}.obs;
  RxString selectedPackageSizeTitle = "".obs;
  RxString selectedPackageSizeDescription = "".obs;
  var selectedPackageWeight = ''.obs;
  var selectedPackageBaseRate = 0.0.obs;

  getAllParcelTypes() async {
    Map<String, Object> data = {};

    ParcelTypesResponse parcelTypesResponse;
    isLoading.value = true;

    get(ApiEndPoints.getParcelTypes, data).then((value) async {
      parcelTypesResponse = parcelTypesResponseFromJson(value.toString());

      if (parcelTypesResponse.status == 200) {
        var strJsonData = jsonEncode(value.data);
        allParcelTypesResponseData.value =
            Map<dynamic, dynamic>.from(json.decode(strJsonData));
        allParcelTypesResponseData['data']['parceltypes'].forEach((item) {
          allParcelTypes.add(item);
        });

        tax.value = (allParcelTypesResponseData['data']['tax']).toDouble();

        print('TAX : ${allParcelTypesResponseData['data']['tax'].toDouble()}');
        if (allParcelTypes.isNotEmpty) {
          selectedWeightSlot.value = allParcelTypes[0]['weightslots'];
          selectedSizeSlots.value = allParcelTypes[0]['sizeslots'];
          selectedParcelTypeId.value = allParcelTypes[0]['id'];
          selectedParcelTypeName.value = allParcelTypes[0]['title'];
          selectedConveniencefee.value =
              allParcelTypes[0]['conveniencefee'].toDouble();
        }
        print("all parcel types : ${allParcelTypes.value}");
        isLoading.value = false;
      } else {
        isLoading.value = false;
        CustomToast.show(parcelTypesResponse.message!);
      }
    }).catchError((onError) {
      print(onError);
      isLoading.value = false;
    });
  }

  //End Parcel Types
  //====================================

  //================================================================

  //====================================
  //Coupons

  RxList allCoupons = [].obs;
  RxBool couponApplied = false.obs;
  RxDouble couponAmount = 0.0.obs;
  RxInt couponId = 0.obs;

  getCoupons() async {
    Map<String, Object> data = {};

    CouponsResponse couponsResponse;
    isLoading.value = true;

    get(ApiEndPoints.getCoupons, data).then((value) async {
      couponsResponse = couponsResponseFromJson(value.toString());

      if (couponsResponse.status == 200) {
        allCoupons.value = couponsResponse.data!.coupons!;
        print("all Collection centers : ${allCoupons.value}");
        isLoading.value = false;
      } else {
        isLoading.value = false;
        CustomToast.show(couponsResponse.message!);
      }
    }).catchError((onError) {
      print(onError);
      isLoading.value = false;
    });
  }

  resetCoupon() {
    couponId.value = 0;
    couponAmount.value = 0.0;
    couponApplied.value = false;
    allCoupons.value = [];
    updateTotalamount();
  }

  //End Coupons
  //====================================

  //================================================================

  //====================================
  //Fare calculation

  RxDouble taxAmount = 0.0.obs;
  RxDouble subTotal = 0.0.obs;
  RxDouble totalAmount = 0.0.obs;

  updateTotalamount() {
    taxAmount.value = (subTotal.value - couponAmount.value) * (tax.value / 100);

    totalAmount.value = subTotal.value - couponAmount.value + taxAmount.value;
  }

  //End Fare calculation
  //====================================

  //================================================================

  //====================================
  //Payment Method

  RxBool isWalletChecked = false.obs;
  RxDouble walletAmount = 0.0.obs;
  RxDouble cardAmount = 0.0.obs;
  RxString transactionId = "".obs;
  RxInt paymentType = 0.obs;

  //1)card 2)wallet 3)both

  onPayNowButtonPress(walletBalance, email, context) async {
    print("walletBalance : $walletBalance");
    if (isWalletChecked.value == true && totalAmount.value <= walletBalance) {
      walletAmount.value = totalAmount.value.toDouble();
      cardAmount.value = 0;
      paymentType.value = 2;
      transactionId.value = '';
      createBooking();

      // print('Card amount is ${cardAmount}');
      // print('Wallet amount is ${walletAmount}');
      // print('Payment type is ${paymentType}');
      // print('Transaction Id is ${transactionId}');
    } else if (isWalletChecked.value == true &&
        totalAmount.value > walletBalance) {
      walletAmount.value = walletBalance;
      cardAmount.value = totalAmount.value - walletBalance;
      paymentType.value = 3;
      transactionId.value = '';
      var respData = await stripePayment.makePayment(
          email: email,
          amount: cardAmount.value.toStringAsFixed(2),
          context: context);
      if (respData != "") {
        transactionId.value = respData;
        print("transactionId.value : ${transactionId.value}");
        createBooking();
      }

      print('3 Card amount is ${cardAmount}');
      print('3 Wallet amount is ${walletAmount}');
      print('3 Payment type is ${paymentType}');
      print('3 Transaction Id is ${transactionId}');
    } else {
      cardAmount.value = totalAmount.value;
      walletAmount.value = 0;
      paymentType.value = 1;
      transactionId.value = '';

      var respData = await stripePayment.makePayment(
          email: email,
          amount: cardAmount.value.toStringAsFixed(2),
          context: context);
      if (respData != "") {
        transactionId.value = respData;
        print("transactionId.value : ${transactionId.value}");
        createBooking();
      }
      print('1 Card amount is ${cardAmount}');
      print('1 Wallet amount is ${walletAmount}');
      print('1 Payment type is ${paymentType}');
      print('1 Transaction Id is ${transactionId}');
    }
  }

  //End Payment Method
  //====================================

  //================================================================

  //====================================
  //Create Booking

  createBooking() async {
    Map<String, Object> data = {};

    data[ApiParams.sourcecityid] = selectedCityId.value;
    data[ApiParams.sourceairportid] = selectedAirportId.value;
    data[ApiParams.sourcecollectioncenterid] = selectedCollectionCenterId.value;
    data[ApiParams.destinationcityid] = selectedDestCityId.value;
    data[ApiParams.recipientname] = recipientName.text;
    data[ApiParams.recipientphone] =
        '${recipientCountrycode.value}${recipientPhone.text}';
    data[ApiParams.recipientaddress] = addressDescription.value;
    data[ApiParams.recipientzipcode] = "000000";
    data[ApiParams.recipientlat] = latitude.value;
    data[ApiParams.recipientlng] = longitude.value;
    data[ApiParams.parceltypeid] = selectedParcelTypeId.value;
    data[ApiParams.instruction] = instructions.text;
    data[ApiParams.weightslot] = selectedPackageWeight.value;
    data[ApiParams.sizeslot] = selectedPackageSizeTitle.value;
    data[ApiParams.couponid] = couponId.value;
    data[ApiParams.walletamount] = walletAmount.value;
    data[ApiParams.cardamount] = cardAmount.value;
    data[ApiParams.transactionid] = transactionId.value;
    data[ApiParams.paymentstatus] = "Completed";
    data[ApiParams.paymenttype] = paymentType.value;
    data[ApiParams.subtotal] = subTotal.value;
    data[ApiParams.discount] = couponAmount.value;
    data[ApiParams.tax] = taxAmount.value;
    data[ApiParams.totalamount] = totalAmount.value;

    print(data);
    CreateBookingResponse createBookingResponse;
    isLoading.value = true;

    post(ApiEndPoints.createBooking, data).then((value) async {
      createBookingResponse = createBookingResponseFromJson(value.toString());

      if (createBookingResponse.status == 200) {
        CustomToast.show(createBookingResponse.message!);
        Get.offAll(() => SuccessOrderCreation());
        isLoading.value = false;
      } else {
        isLoading.value = false;
        CustomToast.show(createBookingResponse.message!);
      }
    }).catchError((onError) {
      print(onError);
      isLoading.value = false;
    });
  }

  //End Create Booking
  //====================================
  //================================================================

  //====================================
//Reset Booking Data
  resetBookingData() {
    selectedCountry.value = "";
    selectedCity.value = "";
    selectedCountryCode.value = "";
    selectedCityId.value = 0;
    allCities.value = [];
    allCitiesResponseData.value = {};
    //===============================
    selectedAirportId.value = 0;
    allAirports.value = [];
    allAirportsResponseData.value = {};
    selectedAirportName.value = "";
    //===============================
    selectedCollectionCenterId.value = 0;
    selectedCollectionCenterName.value = "";
    allCollectionCenters.value = [];
    allCollectionCenterResponseData.value = {};
    //===============================
    selectedDestCountry.value = "";
    selectedDestCity.value = "";
    selectedDestCountryCode.value = "";
    selectedDestCityId.value = 0;
    allDestCities.value = [];
    allDestCitiesResponseData.value = {};
    //===============================
    resetLocationDetails();
    //===============================
    selectedParcelTypeId.value = 0;
    selectedParcelTypeName.value = "";
    allParcelTypes.value = [];
    allParcelTypesResponseData.value = {};
    tax.value = 0.0;
    selectedWeightSlot.value = [];
    selectedSizeSlots.value = [];
    selectedConveniencefee.value = 0.0;
    selectedPackageSizeTitle.value = "";
    selectedPackageSizeDescription.value = "";
    selectedPackageWeight.value = '';
    selectedPackageBaseRate.value = 0.0;
  }

  //====================================
  //End of Booking Order...
  //====================================
}
