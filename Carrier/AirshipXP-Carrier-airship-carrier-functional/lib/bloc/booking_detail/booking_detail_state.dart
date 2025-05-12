import 'package:airship_carrier/models/CarrierBookingDetailsModel.dart';
import 'package:airship_carrier/models/CarrierBookingsModel.dart';
import 'package:airship_carrier/models/base_response_model.dart';

abstract class BookingDetailsState {
  const BookingDetailsState();

  @override
  List<Object?> get props => [];
}

class BookingDetailsInitialState extends BookingDetailsState {}

class BookingDetailsLoadingState extends BookingDetailsState {}

class BookingDetailsAcceptState extends BookingDetailsState {
  BaseResponseModel baseResponseModel;

  BookingDetailsAcceptState(this.baseResponseModel);
}

class ReachedCollectionCenterBookingState extends BookingDetailsState {
  BaseResponseModel baseResponseModel;

  ReachedCollectionCenterBookingState(this.baseResponseModel);
}

class BookingDetailsFetchState extends BookingDetailsState {
  final BookingDetailsData? bookingDetailsData;
  const BookingDetailsFetchState(this.bookingDetailsData);
}


class CarrierRejectedState extends BookingDetailsState {
  BaseResponseModel baseResponseModel;
  CarrierRejectedState(this.baseResponseModel);
}

class BookingDetailsErrorState extends BookingDetailsState {
  final String? message;

  const BookingDetailsErrorState(this.message);
}