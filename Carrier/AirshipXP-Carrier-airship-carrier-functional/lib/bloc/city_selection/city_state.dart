import 'package:airship_carrier/models/AirportDataModel.dart';
import 'package:airship_carrier/models/CitiesModel.dart';

abstract class CityAirportState {
  const CityAirportState();

  @override
  List<Object?> get props => [];
}

class CityStateInitial extends CityAirportState {
}

class CitySelectedStateInitial extends CityAirportState {
  String? countryCode;
  CitySelectedStateInitial({this.countryCode});
}

class AirportSelectedState extends CityAirportState {
  String? airport;
  AirportSelectedState({this.airport});
}

class CityStateLoading extends CityAirportState {}

class CityAirportStateCompleted extends CityAirportState {
  final CityData citiesModel;
  const CityAirportStateCompleted(this.citiesModel);
}

class AirportStateCompleted extends CityAirportState {
  final AirPortData airportDataModel;
  const AirportStateCompleted(this.airportDataModel);
}

class CarrierTravelSubmitStateCompleted extends CityAirportState {
  final String? msg;
  const CarrierTravelSubmitStateCompleted({this.msg});
}

class CityStateError extends CityAirportState {
  final String? message;

  const CityStateError(this.message);
}