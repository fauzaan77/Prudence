import 'package:airship_carrier/models/CitiesModel.dart';

abstract class CityAirportEvent {}

class CityInitialEvent extends CityAirportEvent {

}

class CitySelectedEvent extends CityAirportEvent {
  String? countryCode;

  CitySelectedEvent({this.countryCode});
}

class FilterCityEvent extends CityAirportEvent {
  String? cityLike;
  List<Cities>? cities;

  FilterCityEvent({this.cityLike,this.cities});
}

class AiportSelectedEvent extends CityAirportEvent {
  String? airportId;
  String? airport;

  AiportSelectedEvent({this.airportId,this.airport});
}
class AirportInitialEvent extends CityAirportEvent {
  int cityId;

  AirportInitialEvent({required this.cityId});
}

class SetCarrierDetailsEvent extends CityAirportEvent {
  int? sourceCityId;
  int? sourceAirportId;
  String? departureDateTime;
  int? destinationCityId;
  int? destinationAirportId;
  String? arrivalDateTime;
  bool isEditCall;
  int? carrierId;

  SetCarrierDetailsEvent(
      {this.sourceCityId,
      this.sourceAirportId,
      this.departureDateTime,
      this.destinationCityId,
      this.destinationAirportId,
      this.arrivalDateTime,this.isEditCall = false,
      this.carrierId});
}
