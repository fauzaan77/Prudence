import 'package:airship_carrier/bloc/city_selection/city_bloc.dart';
import 'package:airship_carrier/bloc/city_selection/city_event.dart';
import 'package:airship_carrier/bloc/city_selection/city_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/models/CitiesModel.dart';
import 'package:airship_carrier/models/trave_itinerary_model.dart';
import 'package:airship_carrier/screens/destination_city.dart';
import 'package:airship_carrier/screens/source_airport.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PickupCityScreen extends StatelessWidget {
  ItineraryData? newBooking;
  PickupCityScreen({super.key,this.newBooking});

  final TextEditingController cityController = TextEditingController();
  int cityId = 0;
  String? countryCode;

  CityAirportBloc cityBloc = CityAirportBloc();
  List<Cities>? cities;

  @override
  Widget build(BuildContext context) {
    if(newBooking!=null){
      if(newBooking!.sourcecity!=null){
        cityController.text = newBooking!.sourcecity!;
      }
    }
    return Scaffold(
      appBar: CustomAppBar(leading: true, titleText: 'travelDetails'.tr),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocProvider(
            create: (_) => cityBloc..add(CityInitialEvent()),
            child: BlocListener<CityAirportBloc, CityAirportState>(
              listener: (BuildContext lisCtx, CityAirportState state) {
                if (state is CityAirportStateCompleted) {
                  cities = state.citiesModel.cities;
                  for(int i =0;i<(cities?.length??0);i++){
                    if(cities?[i].city == cityController.text){
                      cityId  = cities?[i].id??0;
                      countryCode = cities?[i].countrycode;
                    }
                  }
                }
              },
              child: BlocBuilder<CityAirportBloc, CityAirportState>(
                  builder: (blocCtx, state) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'sourceCity'.tr,
                            style: kText22w600,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          if(state is CitySelectedStateInitial)
                            Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: greyOp2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(217, 217, 217, 0.5),
                                  ),
                                  height: 50,
                                  width: 75,
                                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                                  child: CountryFlag.fromCountryCode(countryCode??state.countryCode??""),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: cityController,
                                    onChanged: (value){
                                      BlocProvider.of<CityAirportBloc>(blocCtx)
                                          .add(FilterCityEvent(cityLike: value,cities: cities));
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'enterCity'.tr,
                                      hintStyle: kText14w400.copyWith(color: greyOp5),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.0),
                          if(cities!=null)
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                children: cities!.map((e) =>
                                   Column(
                                     children: [
                                       ListTile(
                                         onTap: (){
                                           print("CITY SELECTION ID : ${e.id}");
                                           try {
                                             cityId = int.parse("${e.id}");
                                             cityController.text = e.city??"";
                                             BlocProvider.of<CityAirportBloc>(blocCtx)
                                                 .add(CitySelectedEvent(countryCode: e.countrycode));
                                           } catch (e) {
                                             print("City ID parsing error {} The Id is: ${e}");
                                           }
                                         },
                                         title: Text(e.city??"",style: kText18w400)),
                                       Divider()
                                     ],
                                   ),

                                ).toList()
                                ),
                              ),
                            ),
                          if(cities!=null)
                            ButtonPrimary(
                              onPressed: () async {
                                if(cityController.text.isNotEmpty){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => PickupAirportScreen(
                                              sourceCityId: cityId,newBooking: newBooking)));

                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Please select source city"),
                                    ),
                                  );
                                }
                              },
                              title: 'next'.tr)
                        ],
                      ),
                    ),
                    if (state is CityStateLoading)
                      Center(child: CircularProgressIndicator())
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
