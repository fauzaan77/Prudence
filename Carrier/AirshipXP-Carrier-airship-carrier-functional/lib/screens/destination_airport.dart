import 'package:airship_carrier/bloc/city_selection/city_bloc.dart';
import 'package:airship_carrier/bloc/city_selection/city_event.dart';
import 'package:airship_carrier/bloc/city_selection/city_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/models/AirportDataModel.dart';
import 'package:airship_carrier/models/CitiesModel.dart';
import 'package:airship_carrier/screens/destination_city.dart';
import 'package:airship_carrier/screens/home_screen.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DestinationAirportScreen extends StatelessWidget {
  int? sourceCityId;
  int? destinationCityId;
  int? sourceAirportId;
  String? departureDateTime;
  DestinationAirportScreen({super.key,this.sourceCityId,this.sourceAirportId,this.departureDateTime,this.destinationCityId});

  final TextEditingController airportController = TextEditingController();
  int destinationAirportId = 0;

  CityAirportBloc cityBloc = CityAirportBloc();
  List<Airports>? airports;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(leading: true, titleText: 'travelDetails'.tr),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocProvider(
            create: (_) => cityBloc..add(AirportInitialEvent(cityId: sourceCityId??0)),
            child: BlocListener<CityAirportBloc, CityAirportState>(
              listener: (BuildContext lisCtx, CityAirportState state) {
                if (state is AirportStateCompleted) {
                  airports = state.airportDataModel.airports;
                }
                if(state is CarrierTravelSubmitStateCompleted){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.msg??"Carrier travel details updated successfully!"),
                    ),
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
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
                            'destinationAirport'.tr,
                            style: kText22w600,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          if(state is AirportSelectedState)
                            if(airports!=null)
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                children: airports!.map((e) =>
                                   Column(
                                     children: [
                                       ListTile(
                                         selected: e.name == state.airport,
                                         selectedTileColor: Colors.grey.shade200,
                                         selectedColor: Colors.black,
                                         onTap: (){
                                           airportController.text = e.name ??"";
                                           destinationAirportId = e.id??0;
                                           try {
                                             BlocProvider.of<CityAirportBloc>(blocCtx)
                                                 .add(AiportSelectedEvent(airportId: "${e.id}",airport:e.name));
                                           } catch (e) {
                                             print("City ID parsing error {} The Id is: ${e}");
                                           }
                                         },
                                         title: Text(e.name??"",style: kText18w400),
                                       ),
                                       Divider()
                                     ],
                                   ),

                                ).toList()
                                ),
                              ),
                            ),
                          if(airports!=null)
                            ButtonPrimary(
                              onPressed: () async {
                                if(airportController.text.isNotEmpty){
                                  var arrivalDate = await showDatePicker(
                                    context: context,
                                    initialDate:DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(3001),
                                    helpText: "Select arrival date and time",
                                  );
                                  if(arrivalDate!=null){
                                    final DateFormat formatter = DateFormat('yyyy-MM-dd');
                                    final String formatted = formatter.format(arrivalDate);
                                    print("arrivalDate $formatted");
                                    var arrivalTime = await showTimePicker(context: context,
                                        initialTime: TimeOfDay.now());

                                    String arrivalDateTime = "$formatted ${arrivalTime?.hour}:${arrivalTime?.minute}:00";
                                    BlocProvider.of<CityAirportBloc>(blocCtx).add(
                                        SetCarrierDetailsEvent(
                                            arrivalDateTime: arrivalDateTime,
                                            departureDateTime: departureDateTime,
                                            destinationAirportId:destinationAirportId,
                                            sourceAirportId: sourceAirportId,
                                            destinationCityId: destinationCityId,
                                            sourceCityId: sourceCityId,
                                        ));
                                  }
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Please Select Airport"),
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
