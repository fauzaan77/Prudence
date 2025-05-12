import 'package:airship_carrier/models/CarrierBookingsModel.dart';
import 'package:airship_carrier/models/ProfileDataModel.dart';
import 'package:airship_carrier/models/base_response_model.dart';
import 'package:airship_carrier/models/trave_itinerary_model.dart';

abstract class HomeState {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class BookingDataState extends HomeState {
  bool? isOnline;
  List<Bookings>? newBookings;
  BookingDataState({this.newBookings, this.isOnline});
}


class HomeInitialState extends HomeState {
  bool? isOnline;
  List<ItineraryData>? newBookings;
  HomeInitialState({this.newBookings, this.isOnline});
}

class ItineraryState extends HomeState {
  bool? isOnline;
  List<ItineraryData>? newBookings;
  ItineraryState({this.newBookings, this.isOnline});
}


class ProfileDataState extends HomeState {
  ProfileData? profileData;
  ProfileDataState({this.profileData});
}

class HomeIsOnlineState extends HomeState {
  final isOnline;
  const HomeIsOnlineState(this.isOnline);
}

class HomeLoadingState extends HomeState {
}

class HomeErrorState extends HomeState {
  String? message;

  HomeErrorState(this.message);
}
