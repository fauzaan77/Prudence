import 'dart:io';
import 'package:airship_carrier/bloc/carrier_lic_update/carrier_license_update_bloc.dart';
import 'package:airship_carrier/bloc/carrier_lic_update/carrier_license_update_event.dart';
import 'package:airship_carrier/bloc/carrier_lic_update/carrier_license_update_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadProfilePhoto extends StatelessWidget {
  UploadProfilePhoto({super.key});

  final UpdateCarrierLicenseBloc _updateCarrierLicenseBloc = UpdateCarrierLicenseBloc();
  String temporaryImage = "";
  String profilePic = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        flex: true,
        titleText: "Upload profile photo",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        toolbarHeight: 80,
        leading: true,
      ),
      body: BlocProvider(
        create: (_) => _updateCarrierLicenseBloc,
        child:
        BlocListener<UpdateCarrierLicenseBloc, UpdateCarrierLicenseState>(
          listener: (BuildContext context, UpdateCarrierLicenseState state) {
            if (state is UpdateCarrierLicenseStateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
            if (state is UpdateCarrierLicenseStateCompleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.baseResponseModel.message??""),
                ),
              );
              Navigator.pop(context,true);
            }
          },
          child:
          BlocBuilder<UpdateCarrierLicenseBloc, UpdateCarrierLicenseState>(
              builder: (blocBuilderCtx, state) {
                return Stack(
                  children: [
                    if (state is SetDataState)
                      profilePicView(context, state, blocBuilderCtx),
                    if (state is UpdateCarrierLicenseStateLoading)
                      const Center(child: CircularProgressIndicator())
                  ],
                );
                // return DrivingLicenseView(context);
              }),
        ),
      ),
    );
  }

  Widget profilePicView(
      BuildContext context, SetDataState state, BuildContext blocBuilderCtx) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        state.file != null
            ? Padding(
              padding: const EdgeInsets.all(18.0),
              child: Stack(
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
                      BlocProvider.of<UpdateCarrierLicenseBloc>(
                          blocBuilderCtx)
                          .add(SelectDataEvent(file: null));
                    },
                  ),
                ),
              )
                        ],
                      ),
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
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: ButtonPrimary(
            onPressed: () {
              BlocProvider.of<UpdateCarrierLicenseBloc>(blocBuilderCtx).add(
                  UploadProfilePicEvent(file: file));
            },
            title: 'Submit'.tr,
          ),
        ),
      ],
    );
  }

  File? file;

  void selectImage(BuildContext modalCtx, BuildContext blocBuilderCtx,
      ImageSource source) async {
    final image =
    await ImagePicker().pickImage(source: source, imageQuality: 20);
    if (image != null) {
      file = File(image.path);
      BlocProvider.of<UpdateCarrierLicenseBloc>(blocBuilderCtx).add(
          SelectDataEvent(file: file));
    }
    Navigator.pop(modalCtx);
  }
}
