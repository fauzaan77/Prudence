import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapController extends GetxController {
  TextEditingController inputText = TextEditingController();
  RxBool isLocationEnabled = false.obs;

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
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      isLocationEnabled.value = true;
      return position;
    }
  }

  getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return true;
  }
}
