import 'package:airship_carrier/bloc/home/home_bloc.dart';
import 'package:airship_carrier/bloc/home/home_event.dart';
import 'package:airship_carrier/bloc/home/home_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/controllers/order_controller.dart';
import 'package:airship_carrier/models/CarrierBookingsModel.dart';
import 'package:airship_carrier/screens/package_details.dart';
import 'package:airship_carrier/screens/package_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ItineraryBookings extends StatelessWidget {
  int carrierTravelId;

  ItineraryBookings({super.key,required this.carrierTravelId});

  HomeBloc _homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: true,
        titleText: 'myPackages'.tr,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) =>
              _homeBloc..add(GetItineraryBookingsEvent(carrierId:carrierTravelId)),
          child: BlocListener<HomeBloc, HomeState>(
            listener: (BuildContext listenerCtx, HomeState state) {
              if (state is HomeErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: BlocBuilder<HomeBloc, HomeState>(builder: (blocCtx, state) {
              return Stack(
                children: [
                  if(state is BookingDataState)
                    _showALlOrdersList(state.newBookings??[], blocCtx),
                  if(state is HomeLoadingState)
                    Center(
                        child: const CircularProgressIndicator())
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _showALlOrdersList(List<Bookings> newBookings, BuildContext blocCtx) {
    return newBookings.isEmpty?const Center(child: Text("No data found",style: kText18w400,),): ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        itemBuilder: (context, index) {
          return PackageCard(
            isShadowed: true,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PackageDetails(
                            id: "${newBookings[index].bookingid}",
                            carriertravelid:
                                newBookings[index].carriertravelid,
                          ))).then((value) {
                  BlocProvider.of<HomeBloc>(blocCtx)
                      .add(GetItineraryBookingsEvent(carrierId: carrierTravelId));
              });
            },
            id: "${newBookings[index].bookingid}",
            statusId: newBookings[index].bookingstatusid ?? 0,
            status: newBookings[index].bookingstatus ?? "",
            bookingNo: "${newBookings[index].bookingno}",
            amount: "${newBookings[index].totalamount}",
            fromDate: newBookings[index].bookingdatetime ?? "",
            toDate: "",
            pickLoc: newBookings[index].pickupaddress ?? "",
            destLoc: newBookings[index].dropaddress ?? "",
          );
        },
        separatorBuilder: (context, index) => const Seperator(),
        itemCount: newBookings.length ?? 0);
  }
}
