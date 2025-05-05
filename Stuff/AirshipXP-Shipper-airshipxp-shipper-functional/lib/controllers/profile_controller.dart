import 'dart:convert';
import 'dart:io';

import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/customToast.dart';
import 'package:airshipxp_shipper/models/empty_response.dart';
import 'package:airshipxp_shipper/models/profile_response.dart';
import 'package:airshipxp_shipper/screens/login_screen.dart';
import 'package:airshipxp_shipper/utilities/network_services/api_endpoints.dart';
import 'package:airshipxp_shipper/utilities/network_services/api_param.dart';
import 'package:airshipxp_shipper/utilities/network_services/network_client.dart';
import 'package:airshipxp_shipper/utilities/session_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';

class ProfileController extends NetworkClient {
  RxBool loadingData = false.obs;
  late Rx<Map<dynamic, dynamic>> profileData = Rx({});

  RxString temporaryImage = ''.obs;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController countryCode = TextEditingController();
  TextEditingController phone = TextEditingController();

  getProfileData() async {
    loadingData.value = true;

    Map<String, Object> data = {};

    ProfileResponse profileResponse;
    get(ApiEndPoints.getShipperProfile, data).then((value) {
      profileResponse = profileResponseFromJson(value.toString());

      if (profileResponse.status == 200) {
        var strJsonData = jsonEncode(value.data);
        profileData.value =
            Map<dynamic, dynamic>.from(json.decode(strJsonData));
        firstName.text = profileData.value['data']['firstname'];
        lastName.text = profileData.value['data']['lastname'];
        email.text = profileData.value['data']['email'];
        countryCode.text = profileData.value['data']['countrycode'];
        phone.text = profileData.value['data']['phone'];
        loadingData.value = false;
      } else {
        CustomToast.show(profileResponse.message!);
        loadingData.value = false;
      }
    }).catchError((onError) {
      print('onError : $onError');
      loadingData.value = false;
    });
  }

  void backButtonPress(data) async {
    print("object");
    temporaryImage.value = '';
    // Get.back();
  }

  static File? imagePath;

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

  void showPickFromBottomSheet(context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageUploadButton(
                title: "Pick from gallery",
                onPress: () {
                  Get.back();
                  getImage(ImageSource.gallery);
                },
              ),
              ImageUploadButton(
                title: "Pick from camera",
                onPress: () {
                  Get.back();
                  getImage(ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateProfileDetails() async {
    if (temporaryImage.value != '') {
      loadingData.value = true;
      String? fileName = temporaryImage.value.split('/').last;

      var formData = dio.FormData.fromMap({
        'fileInput': await dio.MultipartFile.fromFile(temporaryImage.value,
            filename: fileName),
        'firstname': firstName.text,
        'lastname': lastName.text
      });

      EmptyResponse emptyResponse;

      postFormData(ApiEndPoints.updateShipperProfile, formData).then((value) {
        emptyResponse = emptyResponseFromJson(value.toString());

        if (emptyResponse.status == 200) {
          loadingData.value = false;
          getProfileData();
          CustomToast.show(emptyResponse.message!);
        } else {
          CustomToast.show(emptyResponse.message!);
          loadingData.value = false;
        }
      }).catchError((onError) {
        print(onError);
        loadingData.value = false;
      });
    } else {
      CustomToast.show("Please select an image to continue.");
    }
  }

  onLogout() async {
    await (SessionManager().onLogout().then((value) {
      Get.offAll(() => LoginScreen());
    }));
  }

  // onDeleteAccount() async {
  //   Map<String, Object> data = {};
  //
  //   EmptyResponse emptyResponse;
  //
  //   post(ApiEndPoints.deleteCustomer, data).then((value) async {
  //     emptyResponse = emptyResponseFromJson(value.toString());
  //     print('coupon.status : ${emptyResponse.status}');
  //
  //     if (emptyResponse.status == 200) {
  //       onLogout();
  //       CustomToast.show(emptyResponse.message!);
  //     } else {
  //       CustomToast.show(emptyResponse.message!);
  //     }
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  // }

  updateFCMToken() async {
    Map<String, Object> data = {};

    data[ApiParams.fcmtoken] = (await FirebaseMessaging.instance.getToken())!;

    EmptyResponse emptyResponse;
    print(data);
    post(ApiEndPoints.updateShipperFcmToken, data).then((value) {
      emptyResponse = emptyResponseFromJson(value.toString());

      if (emptyResponse.status == 200) {
        // CustomToast.show(emptyResponse.message!);
      } else {
        // CustomToast.show(emptyResponse.message!);
      }
    }).catchError((onError) {
      print(onError);
    });
  }
}

class ImageUploadButton extends StatelessWidget {
  ImageUploadButton({required this.title, required this.onPress});

  String title;
  VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPress,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          title,
          style: kText18w700.copyWith(color: Colors.black54),
        ));
  }
}
