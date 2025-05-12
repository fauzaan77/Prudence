import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OrderController extends GetxController {
  static File? imagePath;
  RxString temporaryImage = ''.obs;

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

  List upcomingPackage = [
    {
      'id': '#hfe2345',
      'status': 'Upcoming',
      'fromDate': '22 March, 2022  2:00PM',
      'toDate': '22 March, 2022  2:00PM',
      'pickLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'destLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
    {
      'id': '#hfe2345',
      'status': 'Upcoming',
      'fromDate': '22 March, 2022  2:00PM',
      'toDate': '22 March, 2022  2:00PM',
      'pickLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'destLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
    {
      'id': '#hfe2345',
      'status': 'Upcoming',
      'fromDate': '22 March, 2022  2:00PM',
      'toDate': '22 March, 2022  2:00PM',
      'pickLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'destLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
    {
      'id': '#hfe2345',
      'status': 'Upcoming',
      'fromDate': '22 March, 2022  2:00PM',
      'toDate': '22 March, 2022  2:00PM',
      'pickLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'destLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
    {
      'id': '#hfe2345',
      'status': 'Upcoming',
      'fromDate': '22 March, 2022  2:00PM',
      'toDate': '22 March, 2022  2:00PM',
      'pickLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'destLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
  ];
  List historyPackage = [
    {
      'id': '#hfe2345',
      'status': 'Completed',
      'fromDate': '22 March, 2022  2:00PM',
      'toDate': '22 March, 2022  2:00PM',
      'pickLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'destLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
    {
      'id': '#hfe2345',
      'status': 'Completed',
      'fromDate': '22 March, 2022  2:00PM',
      'toDate': '22 March, 2022  2:00PM',
      'pickLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'destLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
    {
      'id': '#hfe2345',
      'status': 'Cancelled',
      'fromDate': '22 March, 2022  2:00PM',
      'toDate': '22 March, 2022  2:00PM',
      'pickLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'destLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
    {
      'id': '#hfe2345',
      'status': 'Cancelled',
      'fromDate': '22 March, 2022  2:00PM',
      'toDate': '22 March, 2022  2:00PM',
      'pickLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'destLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
    {
      'id': '#hfe2345',
      'status': 'Completed',
      'fromDate': '22 March, 2022  2:00PM',
      'toDate': '22 March, 2022  2:00PM',
      'pickLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'destLoc':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
  ];
}
