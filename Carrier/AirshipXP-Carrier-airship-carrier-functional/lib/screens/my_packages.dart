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

class MyPackages extends StatefulWidget {
  const MyPackages({super.key});

  @override
  State<MyPackages> createState() => _MyPackagesState();
}

class _MyPackagesState extends State<MyPackages> with TickerProviderStateMixin {
  final OrderController orderController = Get.put(OrderController());
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

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
              _homeBloc..add(UpcomingHistoryOrdersEvent(selectedTab: 0)),
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
                  Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        indicatorColor: black,
                        indicatorWeight: 5,
                        labelColor: black,
                        unselectedLabelColor: grey,
                        onTap: (value) {
                          print("Value TAB : $value");
                          BlocProvider.of<HomeBloc>(blocCtx)
                              .add(UpcomingHistoryOrdersEvent(selectedTab: value));
                        },
                        tabs: [
                          Tab(
                            child: Text(
                              'upcoming'.tr,
                              style: kText18w600,
                            ),
                          ),
                          Tab(
                            child: Text(
                              'history'.tr,
                              style: kText18w600,
                            ),
                          )
                        ],
                      ),
                      // _showALlOrdersList([]),
                      // _showALlOrdersList([]),
                      SizedBox(),
                      SizedBox(),
                      if (state is BookingDataState)
                        _showALlOrdersList(state.newBookings??[],blocCtx),
                      /* if (state is HomeInitialState)
                        Expanded(
                          child: TabBarView(controller: _tabController, children: [
                            _showALlOrdersList(state.newBookings),
                          ]),
                        )
                      else
                        _showALlOrdersList([]),
                          */

                    ],
                  ),
                  if (state is HomeLoadingState)
                    const Center(child: CircularProgressIndicator())
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _showALlOrdersList(List<Bookings> newBookings, BuildContext blocCtx) {
    return newBookings.isEmpty?const Center(child: Text("No data found",style: kText18w400,),): Expanded(
      child: ListView.separated(
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
                        .add(UpcomingHistoryOrdersEvent(selectedTab: 0));

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
          itemCount: newBookings.length ?? 0),
    );
  }

  Widget _buildHistory(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        return PackageCard(
          isShadowed: true,
          isMypkg: true,
          onTap: () {
            Get.to(() => PackageSummary(
                  status: orderController.historyPackage[index]['status'],
                ));
          },
          id: orderController.historyPackage[index]['id'],
          amount: orderController.historyPackage[index]['status'],
          fromDate: orderController.historyPackage[index]['fromDate'],
          toDate: orderController.historyPackage[index]['toDate'],
          pickLoc: orderController.historyPackage[index]['pickLoc'],
          destLoc: orderController.historyPackage[index]['destLoc'],
        );
      },
      separatorBuilder: (context, index) => Seperator(),
      itemCount: orderController.historyPackage.length,
    );
  }

  Widget _buildUpcoming(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        return PackageCard(
          isShadowed: true,
          onTap: () {
            Get.to(() => PackageSummary(
                  status: orderController.upcomingPackage[index]['status'],
                ));
          },
          isMypkg: true,
          id: orderController.upcomingPackage[index]['id'],
          amount: orderController.upcomingPackage[index]['status'],
          fromDate: orderController.upcomingPackage[index]['fromDate'],
          toDate: orderController.upcomingPackage[index]['toDate'],
          pickLoc: orderController.upcomingPackage[index]['pickLoc'],
          destLoc: orderController.upcomingPackage[index]['destLoc'],
        );
      },
      separatorBuilder: (context, index) {
        return Seperator();
      },
      itemCount: orderController.upcomingPackage.length,
    );
  }
}
