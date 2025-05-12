import 'dart:convert';

import 'package:airship_carrier/backend/api_repo/api_repository.dart';
import 'package:airship_carrier/bloc/city_selection/city_event.dart';
import 'package:airship_carrier/bloc/city_selection/city_state.dart';
import 'package:airship_carrier/models/AirportDataModel.dart';
import 'package:airship_carrier/models/CitiesModel.dart';
import 'package:airship_carrier/models/base_response_model.dart';
import 'package:bloc/bloc.dart';

class CityAirportBloc extends Bloc<CityAirportEvent, CityAirportState> {
  CityAirportBloc() : super(CityStateInitial()) {
    final ApiRepository _apiRepository = ApiRepository();
    late CityData citiesModel;
    late AirPortData airportDataModel;
    String? countryCode;
    on<CityInitialEvent>((event, emit) async {
      try {
        emit(CityStateLoading());
        final response = await _apiRepository.getCities();
        if (response.status != 200) {
          emit(CityStateError(response.error));
        }else {
          citiesModel = CityData.fromJson(response.data);
          emit(CityAirportStateCompleted(citiesModel));
        }

      } on NetworkError {
        emit(CityStateError("Network problem, please try again later"));
      }
      emit(CitySelectedStateInitial(countryCode: ""));
    });

    on<CitySelectedEvent>((event, emit) async {
      emit(CityAirportStateCompleted(citiesModel));
      countryCode = event.countryCode;
      emit(CitySelectedStateInitial(countryCode: event.countryCode));
    });

    on<FilterCityEvent>((event, emit) async {
      CityData filteredCitiesModel = new CityData();
      List<Cities>? cities = citiesModel.cities;
      if(event.cityLike!=null && event.cityLike!.isNotEmpty) {
        cities = cities!.where((element) =>
            element.city!.toLowerCase().contains(event.cityLike!.toLowerCase() ?? "")).toList();
        filteredCitiesModel.cities = cities;
      }else{
        filteredCitiesModel = citiesModel;
      }
      emit(CityAirportStateCompleted(filteredCitiesModel));
      emit(CitySelectedStateInitial(countryCode: countryCode));

    });

    on<AiportSelectedEvent>((event, emit) async {
      emit(AirportStateCompleted(airportDataModel));
      emit(AirportSelectedState(airport: event.airport));
    });

    on<AirportInitialEvent>((event, emit) async {
      try {
        emit(CityStateLoading());
        var body = {
          "cityid":event.cityId
        };
        final response = await _apiRepository.getAirports(body);
        if (response.status != 200) {
          emit(CityStateError(response.error));
        }else {
          airportDataModel = AirPortData.fromJson(response.data);
          print("LENGTH : ${response.data}");
          print("LENGTH : ${airportDataModel.airports?.length}");
          emit(AirportStateCompleted(airportDataModel));
          emit(AirportSelectedState(airport: ""));
        }

      } on NetworkError {
        emit(CityStateError("Network problem, please try again later"));
      }
    });

    on<SetCarrierDetailsEvent>((event, emit) async {
      try {
        emit(CityStateLoading());
        var body = {};
        final BaseResponseModel response;
        if(!event.isEditCall) {
          body = {
            "sourcecityid": event.sourceCityId,
            "sourceairportid": event.sourceAirportId,
            "destinationcityid": event.destinationCityId,
            "sourcedeparturedatetime": event.departureDateTime,
            "flightdetails": "test"
          };
          response = await _apiRepository.setCarrierTravelDetails(body);
        }else {
          body = {
            "sourcecityid": event.sourceCityId,
            "sourceairportid": event.sourceAirportId,
            "destinationcityid": event.destinationCityId,
            "departuredatetime": event.departureDateTime,
            "carriertravelid": event.carrierId
          };
          response = await _apiRepository.editTravelItinerary(body);
        }
        if (response.status != 200) {
          emit(CityStateError(response.error));
        }else {
          emit(CarrierTravelSubmitStateCompleted(msg:response.data["message"]));
        }

      } on NetworkError {
        emit(CityStateError("Network problem, please try again later"));
      }
    });
  }
}