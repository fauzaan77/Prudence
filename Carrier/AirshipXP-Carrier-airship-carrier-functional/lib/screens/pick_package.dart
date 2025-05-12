import 'dart:io';

import 'package:airship_carrier/bloc/pick_package/pick_package_bloc.dart';
import 'package:airship_carrier/bloc/pick_package/pick_package_event.dart';
import 'package:airship_carrier/bloc/pick_package/pick_package_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/controllers/authenticate_controller.dart';
import 'package:airship_carrier/controllers/personal_details_controller.dart';
import 'package:airship_carrier/models/CarrierBookingDetailsModel.dart';
import 'package:airship_carrier/screens/drop_package.dart';
import 'package:airship_carrier/screens/home_screen.dart';
import 'package:airship_carrier/screens/my_packages.dart';
import 'package:airship_carrier/screens/reach_drop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PickupPackage extends StatelessWidget {
  BookingDetailsData? bookingDetailsData;

  PickupPackage({super.key, this.bookingDetailsData});

  PickCarrierBloc pickCarrierBloc = PickCarrierBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'pickPackage'.tr,
        leading: true,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (BuildContext providerCtx) => pickCarrierBloc,
          child: BlocListener<PickCarrierBloc, PickCarrierUpdateState>(
            listener: (BuildContext lisCtx, PickCarrierUpdateState state) {
              if (state is PickCarrierUpdateErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
              if (state is CarrierDeliveryCompletedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.baseResponseModel.message??""),
                  ),
                );
                Navigator.pop(context,true);
                // Navigator.push(context, MaterialPageRoute(builder: (_)=>MyPackages()));
              }
              if (state is CarrierCanceledState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.baseResponseModel.message??""),
                  ),
                );
                Navigator.pop(context,true);
                // Navigator.push(context, MaterialPageRoute(builder: (_)=>MyPackages()));
              }
              if(state is ReachDropLocationCompletedState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.baseResponseModel.message??""),
                  ),
                );
                Navigator.pop(context,true);
                // Navigator.push(context, MaterialPageRoute(builder: (_)=>MyPackages()));
              }
              if(state is PickCarrierUpdateCompletedState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.baseResponseModel.message??""),
                  ),
                );
                Navigator.pop(context,true);
                // Navigator.push(context, MaterialPageRoute(builder: (_)=>MyPackages()));
              }
            },
            child: BlocBuilder<PickCarrierBloc, PickCarrierUpdateState>(
                builder: (blocCtx, state) {
              return Stack(
                children: [
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Booking No. ${bookingDetailsData?.bookingno}',
                          style: kText14w600,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      if(bookingDetailsData?.bookingstatusid == 7)
                        CustomBox(
                        link: false,
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        shadow: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'itemImage'.tr,
                              style: kText18w600,
                            ),
                            Seperator(),
                            Wrap(
                              children: [
                                if (!files.isEmpty)
                                  for (int i = 0; i < files.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.file(
                                        files[i],
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                IconButton(
                                  iconSize: 40,
                                  icon: const Icon(Icons.add_circle),
                                  color: Colors.black,
                                  onPressed: () {
                                    selectImage(blocCtx, ImageSource.camera);
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Seperator(),
                      CustomBox(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        shadow: true,
                        link: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Package Details',
                              style: kText18w600,
                            ),
                            Seperator(),
                            Row(
                              children: [
                                Icon(
                                  Icons.insert_drive_file_outlined,
                                  size: 30,
                                  color: greyOp5,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Weight: ${bookingDetailsData?.weightslot}",
                                        style: kText14w400,
                                      ),
                                      Text(
                                        "Instruction: ${bookingDetailsData?.instruction}",
                                        style: kText14w400,
                                      ),
                                      Text(
                                        "Payment Type: ${bookingDetailsData?.paymenttype}",
                                        style: kText14w400,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Seperator(),
                      CustomBox(
                        shadow: true,
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        link: false,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Booking No. ${bookingDetailsData?.bookingno}',
                                  style: kText14w600,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'pickupCustomer'.tr,
                                  style: kText12w300.copyWith(
                                    color: greyOp3,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  bookingDetailsData?.shipper ?? "",
                                  style: kText16w600,
                                ),
                                Text(
                                  bookingDetailsData?.pickupaddress ?? "",
                                  style: kText12w300.copyWith(
                                      fontWeight: FontWeight.w400),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone_outlined,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      bookingDetailsData?.shipperphone ?? "",
                                      style: kText14w500,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'receipientCustomer'.tr,
                                  style: kText12w300.copyWith(
                                    color: greyOp3,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  bookingDetailsData?.recipientname ?? "",
                                  style: kText16w600,
                                ),
                                Text(
                                  bookingDetailsData?.dropaddress ?? "",
                                  style: kText12w300.copyWith(
                                      fontWeight: FontWeight.w400),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone_outlined,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      bookingDetailsData?.recipientphone ?? "",
                                      style: kText14w500,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("OTP",style: kText16w700),
                                    for(int i =0;i<bookingDetailsData!.bookingotp!.split("").length;i++)
                                      Container(
                                          color: Colors.blueAccent,
                                          width: 35,
                                          height: 35,
                                          margin: EdgeInsets.all(4.0),
                                          child: Center(child: Text(bookingDetailsData!.bookingotp!.split("")[i],
                                              style: kText16w700.copyWith(color: Colors.white)))),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Seperator(),
                      if(bookingDetailsData?.bookingstatusid == 7)
                        ButtonPrimary(
                        onPressed: () {
                          BlocProvider.of<PickCarrierBloc>(blocCtx)
                              .add(CancelCarrierEvent(
                              bookingid: bookingDetailsData?.bookingid));
                          },
                        title: 'cancelOrder'.tr,
                        isTextButton: true,
                      ),
                      Seperator(),
                      CustomBox(
                        link: false,
                        shadow: true,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: bookingDetailsData?.bookingstatusid ==9?
                        ButtonPrimary(
                          height: 50,
                          onPressed: () {
                            BlocProvider.of<PickCarrierBloc>(blocCtx)
                                .add(CarrierDeliveredEvent(
                                bookingid: bookingDetailsData?.bookingid));
                          },
                          title: 'orderDelivered'.tr,
                          style: kText14w600,
                        ):bookingDetailsData?.bookingstatusid ==8?
                        ButtonPrimary(
                          height: 50,
                          onPressed: () {
                            BlocProvider.of<PickCarrierBloc>(blocCtx)
                                .add(ReachedDropSubmitEvent(
                                bookingid: bookingDetailsData?.bookingid));
                            // Get.to(() => DropPackage());
                          },
                          title: 'reachedDropLoc'.tr,
                          style: kText14w600,
                        ): ButtonPrimary(
                          height: 50,
                          onPressed: () {
                            BlocProvider.of<PickCarrierBloc>(blocCtx)
                                .add(PickPackageSubmitEvent(
                                bookingid: bookingDetailsData?.bookingid,
                                fileInput: files,bookingotp: bookingDetailsData?.bookingotp));
                          },
                          title: 'pickedOrder'.tr,
                          style: kText14w600,
                        ),
                      ),
                    ],
                  ),
                  if (state is PickCarrierUpdateLoadingState)
                    const Center(child: CircularProgressIndicator())
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  List<File> files = [];

  void selectImage(BuildContext blocBuilderCtx, ImageSource source) async {
    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 20);
    if (image != null) {
      files.add(File(image.path));
      BlocProvider.of<PickCarrierBloc>(blocBuilderCtx)
          .add(AddCarrierImageEvent(fileInput: files));
    }
  }
}
