import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PersonalDetailController extends GetxController {
  RxBool personalInfo = false.obs;
  RxBool drivingLicense = false.obs;
  RxBool profilePic = false.obs;
  RxBool bankDetails = false.obs;
  RxBool enterSocialSec = false.obs;
  RxBool passportDetail = false.obs;
  static File? imagePath;
  RxString temporaryImage = ''.obs;
  RxString drivingLicenseImage = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  RxBool camPermission = false.obs;

  // ====================================
  TextEditingController drivingLicenseNumberInputController = TextEditingController();
  TextEditingController licenseExpiryDateInputController = TextEditingController();
  TextEditingController passportNumberInputController = TextEditingController();
  TextEditingController passportExpiryDateInputController = TextEditingController();
  ScrollController scrollController = ScrollController();

  // ====================================

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imagePermanent = File(image.path);
      compressImage(image.path);

      imagePath = imagePermanent;
    } catch (e) {
      print(e);
    }
    print('====================== $imagePath');
  }

  Future compressImage(imagePath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      imagePath,
      imagePath + 'compressed.jpg',
      quality: 50,
    );
    temporaryImage.value = result!.path.toString();

    print(result.path);
  }

  Future<void> requestCameraPermission() async {
    var camstatus = await Permission.camera.status;
    if (camstatus.isGranted) {
      camPermission.value = true;
      print("isGranted");
    } else if (camstatus.isDenied) {
      if (await Permission.camera.request().isGranted) {
        print("Granted");
        camPermission.value = true;
      }
    } else if (camstatus.isPermanentlyDenied) {
      print("=================DENIEEDDD");
      // Get.snackbar('Access Denied', 'Go to Settings');
      openAppSettings();

      // await Permission.camera.request();
      // await Permission.microphone.request();
    }
  }
}
