import 'dart:async';
import 'dart:io';
import 'package:airship_carrier/bloc/carrier_lic_update/carrier_license_update_bloc.dart';
import 'package:airship_carrier/bloc/carrier_lic_update/carrier_license_update_event.dart';
import 'package:airship_carrier/bloc/carrier_lic_update/carrier_license_update_state.dart';
import 'package:airship_carrier/bloc/passport_details/passport_details_bloc.dart';
import 'package:airship_carrier/bloc/passport_details/passport_details_event.dart';
import 'package:airship_carrier/bloc/passport_details/passport_details_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/controllers/personal_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PassportDetails extends StatelessWidget {
  PassportDetails({super.key});

  void _showDatePicker(BuildContext context, BuildContext blocBuilderCtx) {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().add(const Duration(days: 0)),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Colors.black, // <-- SEE HERE
                  onPrimary: Colors.white, // <-- SEE HERE
                  onSurface: Colors.black, // <-- SEE HERE
                ),
              ),
              child: child!);
        }).then((value) {
      passportExpiryDateInputController.text =
          DateFormat('yyyy-MM-d').format(DateTime.parse(value!.toString()));
      BlocProvider.of<PassportDetailsBloc>(blocBuilderCtx).add(
          SelectPassportDataEvent(
              passportexpirydate: passportExpiryDateInputController.text, fileInput: file));
    });
  }

  TextEditingController passportNumberInputController = TextEditingController();
  TextEditingController passportExpiryDateInputController = TextEditingController();

  final PassportDetailsBloc _updateCarrierLicenseBloc = PassportDetailsBloc();
  String temporaryImage = "";
  String passportLicenseImage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        flex: true,
        titleText: "Take a photo of your passport",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        toolbarHeight: 80,
        leading: true,
      ),
      body: BlocProvider(
        create: (_) => _updateCarrierLicenseBloc,
        child:
        BlocListener<PassportDetailsBloc, PassportUpdateState>(
          listener: (BuildContext context, PassportUpdateState state) {
            if (state is PassportUpdateStateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
            if (state is PassportUpdateStateCompleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.baseResponseModel.message??""),
                ),
              );
              Navigator.pop(context,true);
            }
          },
          child:
          BlocBuilder<PassportDetailsBloc, PassportUpdateState>(
              builder: (blocBuilderCtx, state) {
                return Stack(
                  children: [
                    if (state is SetPassportDataState)
                      DrivingLicenseView(context, state, blocBuilderCtx),
                    if (state is PassportUpdateStateLoading)
                      const Center(child: CircularProgressIndicator())
                  ],
                );
                // return DrivingLicenseView(context);
              }),
        ),
      ),
    );
  }

  Widget DrivingLicenseView(
      BuildContext context, SetPassportDataState state, BuildContext blocBuilderCtx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            state.file != null
                ? Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(
                    state.file!,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: -6,
                  right: -6,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: darkBlue,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        BlocProvider.of<PassportDetailsBloc>(
                            blocBuilderCtx)
                            .add(SelectPassportDataEvent(
                            passportexpirydate: passportExpiryDateInputController.text,
                            fileInput: null));
                        // profileController
                        //     .temporaryImage.value = "";
                        // print("Close button pressed");
                      },
                    ),
                  ),
                )
              ],
            )
                : TextButton(
              style: ButtonStyle(
                  overlayColor:
                  MaterialStateProperty.all(Color(0xFFfff6f4)),
                  shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext modalCtx) {
                    return IntrinsicHeight(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                selectImage(modalCtx, blocBuilderCtx,
                                    ImageSource.gallery);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                child: Row(
                                  children: [
                                    Icon(Icons.image),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      'fromGallery'.tr,
                                      style: kText16w700,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                selectImage(modalCtx, blocBuilderCtx,
                                    ImageSource.camera);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                child: Row(
                                  children: [
                                    Icon(Icons.camera),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      'fromCamera'.tr,
                                      style: kText16w700,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/images/rectangle.png'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_a_photo_outlined,
                        color: Color(0xFFABB6BC),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'uploadOrTakePhoto'.tr,
                        style: kText18w700.copyWith(
                            color: const Color(0xFFABB6BC)),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            TextInputBox(
              outlineBorder: true,
              radius: BorderRadius.circular(10),
              borderColor: greyOp2,
              controller: passportNumberInputController,
              onValueChange: (value) {},
              placeHolder: 'passportNumber'.tr,
            ),
            const SizedBox(
              height: 14.0,
            ),
            CustomBox(
              height: 67,
              padding: EdgeInsets.symmetric(horizontal: 10),
              borderColor: greyOp2,
              link: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.date == null || state.date == ""
                        ? 'expiryDate'.tr
                        : state.date!,
                    style: kText14w400.copyWith(color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      _showDatePicker(context, blocBuilderCtx);
                    },
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: darkBlue,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            ButtonPrimary(
              onPressed: () {
                BlocProvider.of<PassportDetailsBloc>(blocBuilderCtx).add(
                    UpdatePassportSubmitEvent(
                        passportexpirydate: passportExpiryDateInputController.text,
                        fileInput: file,
                        passportno: passportNumberInputController.text));
              },
              title: 'Submit'.tr,
            ),
          ],
        ),
      ),
    );
  }

  File? file;

  void selectImage(BuildContext modalCtx, BuildContext blocBuilderCtx,
      ImageSource source) async {
    final image =
    await ImagePicker().pickImage(source: source, imageQuality: 20);
    if (image != null) {
      file = File(image.path);
      BlocProvider.of<PassportDetailsBloc>(blocBuilderCtx).add(
          SelectPassportDataEvent(
              passportexpirydate: passportExpiryDateInputController.text, fileInput: file));
    }
    Navigator.pop(modalCtx);
  }
}
