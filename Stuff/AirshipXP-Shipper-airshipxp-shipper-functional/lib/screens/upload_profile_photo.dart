import 'dart:io';

import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/authenticate_controller.dart';
import 'package:airshipxp_shipper/screens/terms_and_conditions.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;
  late List<CameraDescription> _cameras;
  XFile? imageFile;
  RxBool isBackCamera = false.obs;
  int camera = 1;
  RxBool isLoading = true.obs;

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

    _cameras = await availableCameras();
    print('========================$_cameras');
  }

  final AuthenticateController authController = Get.find();

  Future<XFile?> takePicture() async {
    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await controller.takePicture();
      return file;
    } on CameraException catch (e) {
      print(e);
      return null;
    }
  }

  void _initialize(int camNumber) {
    controller = CameraController(
      _cameras[camNumber],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      authController.isLoading.value = false;

      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void initState() {
    main().then((value) {
      _initialize(camera);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return authController.isLoading.value
        ? Center(
            child: CircularProgressIndicator(
              color: black,
            ),
          )
        : !controller.value.isInitialized
            ? Text('There Is A Problem while loading a camera')
            : Scaffold(
                appBar: CustomAppBar(
                  leading: true,
                  titleText: 'uploadProfilePhoto'.tr,
                ),
                body: Material(
                  color: const Color.fromRGBO(0, 0, 0, 0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: black, width: 4),
                                    shape: BoxShape.circle),
                                height: 200,
                                width: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: imageFile != null
                                      ? Image.file(
                                          File(imageFile!.path),
                                          height: 200,
                                          fit: BoxFit.cover,
                                        )
                                      : CameraPreview(controller),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                width: double.infinity,
                                color: white,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'photoRequirement'.tr,
                                        style: kText18w700.copyWith(
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      const Seperator(),
                                      Text(
                                        'keepFaceCenter'.tr,
                                        style: kText16w500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'brightPlace'.tr,
                                        style: kText16w500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'dontWear'.tr,
                                        style: kText16w500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'blurr'.tr,
                                        style: kText16w500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      imageFile != null
                          ? Padding(
                              padding: EdgeInsets.all(20),
                              child: ButtonPrimary(
                                  onPressed: () {
                                    // dispose();
                                    Get.to(() => TermsAndConditions());
                                  },
                                  title: 'Next'),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (camera == 1) {
                                            camera = 0;
                                            _initialize(camera);
                                          } else {
                                            camera = 1;
                                            _initialize(camera);
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.flip_camera_android,
                                          size: 30,
                                        ),
                                      ),
                                      Text(
                                        'flip'.tr,
                                        style: kText16w500,
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      takePicture().then((value) {
                                        imageFile = value;
                                        setState(() {});
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.camera,
                                      size: 50,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.image_outlined,
                                          size: 30,
                                        ),
                                      ),
                                      Text(
                                        'gallery'.tr,
                                        style: kText16w500,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              );
  }
}
