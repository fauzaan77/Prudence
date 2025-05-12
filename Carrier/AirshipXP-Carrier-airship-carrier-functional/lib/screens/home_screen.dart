import 'package:airship_carrier/bloc/home/home_bloc.dart';
import 'package:airship_carrier/bloc/home/home_event.dart';
import 'package:airship_carrier/bloc/home/home_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/components/drawer.dart';
import 'package:airship_carrier/models/CarrierBookingsModel.dart';
import 'package:airship_carrier/models/trave_itinerary_model.dart';
import 'package:airship_carrier/screens/itinerary_bookings.dart';
import 'package:airship_carrier/screens/package_details.dart';
import 'package:airship_carrier/screens/source_city.dart';
import 'package:airship_carrier/util/shared_pref.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  GlobalKey<ScaffoldState> _key = GlobalKey();

  HomeBloc _homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: black,
      floatingActionButton: FloatingActionButton.extended(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>PickupCityScreen()));
      },
      isExtended: true,tooltip: "Create new Itinerary",
        label: Text("New Itinerary"),
        icon: Icon(Icons.add),
      ),
      appBar: CustomAppBar(
        isDrawer: true,
        titleText: 'Active Itinerary'.tr,
        titleColor: white,
        leading: true,
        customLeading: IconButton(
          icon: Icon(
            Icons.menu,
            color: white,
          ),
          onPressed: () {
            _key.currentState?.openDrawer();
          },
        ),
        action: [],
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: BlocProvider(
            create: (_) => _homeBloc..add(HomeInitialEvent()),
            child: BlocListener<HomeBloc, HomeState>(
                listener: (BuildContext listenerCtx, HomeState state) {
              if (state is HomeErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            }, child: BlocBuilder<HomeBloc, HomeState>(builder: (blocCtx, state) {
              return Stack(
                children: [
                  if (state is HomeInitialState)
                    if (state.newBookings != null)
                      if (state.newBookings!.isEmpty)
                        _buildOfflineHome(context,blocCtx)
                      else if (state.newBookings == null)
                        _buildOfflineHome(context,blocCtx)
                      else
                        _showALlOrdersList(state.newBookings,blocCtx),
                  if (state is HomeLoadingState)
                    const Center(child: CircularProgressIndicator())
                ],
              );
            }))),
      ),
    );
  }

  Widget _buildOfflineHome(BuildContext context, BuildContext blocCtx) {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async{
          BlocProvider.of<HomeBloc>(blocCtx).add(HomeInitialEvent());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/home.png',
              height: 200,
            ),
            Text(
              'greatChance'.tr,
              style: kText16w500.copyWith(color: white),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: (){
                BlocProvider.of<HomeBloc>(blocCtx).add(HomeInitialEvent());
              },
              child: Text(
                'Click here to refresh the page',
                style: kText16w500.copyWith(color: Colors.white24),
              ),
            ),/*
            CustomBox(
              padding: EdgeInsets.all(8),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => PickupCityScreen()));
              },
              alignment: Alignment.center,
              link: true,
              child: Text(
                'enterOrEdit'.tr,
                textAlign: TextAlign.center,
                style: kText18w600,
              ),
            ),*/
            /*SizedBox(height: 20),
            CustomBox(
              width: 200,
              link: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (){
                      BlocProvider.of<HomeBloc>(blocCtx).add(HomeInitialEvent());
                    }, icon: Icon(Icons.refresh,size: 30,),
                  ),
                  Text("Refresh",style: kText18w600),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _showALlOrdersList(List<ItineraryData>? newBookings, BuildContext blocCtx) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async{
              BlocProvider.of<HomeBloc>(blocCtx).add(HomeInitialEvent());

            },
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                itemBuilder: (context, index) {
                  return
                    CustomBox(
                        padding: EdgeInsets.all(15),
                        link: true,
                        onTap: (){},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Carrier departure time : ${DateFormat("dd-MMM-yyyy").format(DateTime.parse(newBookings?[index].carrierdeparturedatetime??""))}',
                              style: kText12w300.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Column(
                                  children: [
                                    Icon(Icons.flight_takeoff),
                                    DottedLine(
                                      lineLength: 30,
                                      direction: Axis.vertical,
                                    ),
                                    Icon(Icons.flight_land),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newBookings?[index].sourcecity??"",
                                        style: kText12w300,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        newBookings?[index].desctinationcity??"",
                                        style: kText12w300,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 10.0,
                            ),
                            Wrap(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: ButtonPrimary(
                                          height: 50,
                                          onPressed: () {
                                            // set up the button
                                            Widget okButton = TextButton(
                                              child: Text("Yes",style: kText14w400),
                                              onPressed: () {
                                                BlocProvider.of<HomeBloc>(blocCtx).add(CancelItineraryEvent(carriertravelid: newBookings?[index].carriertravelid??0));
                                                Navigator.pop(context);
                                              },
                                            );
                                            Widget cancelButton = TextButton(
                                              child: Text("No",style: kText14w400),
                                              onPressed:  () {
                                                Navigator.pop(context);
                                              },
                                            );
                                            // set up the AlertDialog
                                            AlertDialog alert = AlertDialog(
                                              title: Text("Are you sure to delete?",style: kText16w700),
                                              actions: [
                                                okButton,
                                                cancelButton
                                              ],
                                            );

                                            // show the dialog
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alert;
                                              },
                                            );
                                          },
                                          title: "Cancel",
                                          style: kText14w600,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: ButtonPrimary(
                                          height: 50,
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) => PickupCityScreen(newBooking: newBookings?[index])));
                                          },
                                          title: "Edit",
                                          style: kText14w600,
                                        ),
                                      ),
                                    ]
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: ButtonPrimary(
                                    height: 50,
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_)=>ItineraryBookings(carrierTravelId: newBookings?[index].carriertravelid??0)));
                                    },
                                    title: "Show All Bookings",
                                    style: kText14w600,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ));
                },
                separatorBuilder: (context, index) => const Seperator(),
                itemCount: newBookings?.length ?? 0),
          ),
        ),
        /*const Seperator(),
        Text("Active Itinerary",
          style: kText18w700.copyWith(color: white),
        ),*/
      ],
    );
  }
}
