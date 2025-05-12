import 'package:airship_carrier/bloc/booking_detail/booking_detail_bloc.dart';
import 'package:airship_carrier/bloc/booking_detail/booking_detail_state.dart';
import 'package:airship_carrier/bloc/booking_detail/booking_detail_event.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/screens/my_packages.dart';
import 'package:airship_carrier/screens/pick_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class PackageDetails extends StatelessWidget {
  PackageDetails({super.key, required this.id,this.carriertravelid});
  String id;
  int? carriertravelid;
  BookingDetailsBloc bookingDetailsBloc = BookingDetailsBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBg,
      appBar: CustomAppBar(
        titleText: 'packageDetails'.tr,
        leading: true,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (BuildContext blocProvCtx) =>bookingDetailsBloc..add(GetBookingDetailsEvent(bookingId: int.parse(id))),
          child: BlocListener<BookingDetailsBloc, BookingDetailsState>(
            listener: (BuildContext lisCtx, BookingDetailsState state) {
              if(state is BookingDetailsErrorState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message??""),
                  ),
                );
              }
              if(state is BookingDetailsAcceptState){
                // Navigator.push(context, MaterialPageRoute(builder: (_)=>ReachPickup()));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.baseResponseModel.message??""),
                  ),
                );
              }
              if(state is ReachedCollectionCenterBookingState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.baseResponseModel.message??""),
                  ),
                );
                // Navigator.push(context, MaterialPageRoute(builder: (_)=>PickupPackage()));
              }
              if(state is BookingDetailsFetchState) {
                if (state.bookingDetailsData?.bookingstatusid == 7 ||
                    state.bookingDetailsData?.bookingstatusid == 8 ||
                    state.bookingDetailsData?.bookingstatusid == 9) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) =>
                          PickupPackage(
                              bookingDetailsData: state.bookingDetailsData))).then((value) {
                                if(value==true){
                                  // Navigator.pop(context,value);
                                  BlocProvider.of<BookingDetailsBloc>(lisCtx).add(
                                      GetBookingDetailsEvent(
                                          bookingId: int.parse(id)
                                      ));
                                }
                  });
                }
              }
              if(state is CarrierRejectedState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.baseResponseModel.message??""),
                  ),
                );
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const MyPackages()));
              }
            },
            child: BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
              builder: (blocCtx,state) {
                return Stack(
                  children: [
                    if(state is BookingDetailsFetchState)
                      SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomBox(
                            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                            padding: EdgeInsets.all(15),
                            shadow: true,
                            bgColor: Colors.white,
                            link: false,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Booking No. ${state.bookingDetailsData?.bookingno}',
                                        style: kText14w600,
                                      ),
                                    ),
                                    if(state.bookingDetailsData?.bookingstatusid != 1)
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          border: Border.all(color:
                                          state.bookingDetailsData?.bookingstatusid == 1? gradYellow1:
                                          state.bookingDetailsData?.bookingstatusid == 3? statusGreen:
                                          state.bookingDetailsData?.bookingstatusid == 7? darkBlue:
                                          cherryRed
                                          )
                                        ),
                                        child: Text(
                                          state.bookingDetailsData?.bookingstatus??"",
                                          style: kText12w300.copyWith(
                                              color: state.bookingDetailsData?.bookingstatusid == 1? gradYellow1:
                                          state.bookingDetailsData?.bookingstatusid == 3? statusGreen:
                                          state.bookingDetailsData?.bookingstatusid == 7? darkBlue:
                                          cherryRed,fontSize: 8),
                                        ),
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
                                      state.bookingDetailsData?.shipper??"",
                                      style: kText16w600,
                                    ),
                                    Text(
                                      state.bookingDetailsData?.pickupaddress??"",
                                      style:
                                          kText12w300.copyWith(fontWeight: FontWeight.w400),
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
                                          state.bookingDetailsData?.shipperphone??"",
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
                                      state.bookingDetailsData?.recipientname??"",
                                      style: kText16w600,
                                    ),
                                    Text(
                                      state.bookingDetailsData?.dropaddress??"",
                                      style:
                                      kText12w300.copyWith(fontWeight: FontWeight.w400),
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
                                          state.bookingDetailsData?.recipientphone??"",
                                          style: kText14w500,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomBox(
                            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                            padding: EdgeInsets.all(15),
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
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   'Package Details',
                                        //   style: kText16w600.copyWith(
                                        //     color: greyOp5,
                                        //   ),
                                        // ),
                                        // Seperator(),
                                        Text(
                                          "Weight: ${state.bookingDetailsData?.weightslot}",
                                          style: kText14w400,
                                        ),
                                        Text(
                                          "Instruction: ${state.bookingDetailsData?.instruction}",
                                          style: kText14w400,
                                        ),
                                        Text(
                                          "Payment Type: ${state.bookingDetailsData?.paymenttype}",
                                          style: kText14w400,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 40),
                                if(state.bookingDetailsData?.bookingstatusid == 1)
                                  AcceptRejectButtons(state,blocCtx),
                                if(state.bookingDetailsData?.bookingstatusid == 3)
                                  ButtonPrimary(
                                    height: 50,
                                    onPressed: () {
                                      BlocProvider.of<BookingDetailsBloc>(blocCtx).add(
                                          ReachedCollectionCenterBookingEvent(
                                              bookingId: state.bookingDetailsData?.bookingid??0
                                          ));
                                      // Get.to(() => PickupPackage());
                                    },
                                    title: 'reachedCollectionCenter'.tr,
                                    style: kText14w600,
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if(state is BookingDetailsLoadingState)
                      const Center(child: CircularProgressIndicator(),)
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  Widget AcceptRejectButtons(BookingDetailsFetchState state, BuildContext blocCtx) {
    return Row(
      children: [
        Expanded(
          child: ButtonPrimary(
            height: 40,
            foregroundColor: black,
            bgColor: greyButton,
            onPressed: () {
              BlocProvider.of<BookingDetailsBloc>(blocCtx)
                  .add(RejectCarrierEvent(
                  bookingid: state.bookingDetailsData?.bookingid??0));
            },
            title: 'reject'.tr,
            style: kText14w600,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: ButtonPrimary(
            height: 40,
            onPressed: () {
              BlocProvider.of<BookingDetailsBloc>(blocCtx).add(
                  AcceptBookingDetailsEvent(
                      bookingId: state.bookingDetailsData?.bookingid??0,
                      carriertravelid:carriertravelid??0
                  ));
            },
            title: 'accept'.tr,
            style: kText14w600,
          ),
        ),
      ],
    );
  }
}
