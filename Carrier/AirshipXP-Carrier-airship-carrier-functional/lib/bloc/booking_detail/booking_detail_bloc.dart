import 'package:airship_carrier/backend/api_repo/api_repository.dart';
import 'package:airship_carrier/bloc/booking_detail/booking_detail_event.dart';
import 'package:airship_carrier/bloc/booking_detail/booking_detail_state.dart';
import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_event.dart';
import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_state.dart';
import 'package:airship_carrier/bloc/social_security_code/social_security_event.dart';
import 'package:airship_carrier/bloc/social_security_code/social_security_state.dart';
import 'package:airship_carrier/models/CarrierBookingDetailsModel.dart';
import 'package:airship_carrier/models/CarrierBookingsModel.dart';
import 'package:bloc/bloc.dart';

class BookingDetailsBloc extends Bloc<BookingDetailEvent, BookingDetailsState> {
  BookingDetailsBloc() : super(const BookingDetailsFetchState(null)) {
    final ApiRepository _apiRepository = ApiRepository();


    on<GetBookingDetailsEvent>((event, emit) async {
      try {
        emit(BookingDetailsLoadingState());
        var body = {
          "bookingid":event.bookingId
        };
        final response = await _apiRepository.carrierBookingDetails(body);
        if (response.status != 200) {
          emit(BookingDetailsErrorState(response.error));
        }else {
          BookingDetailsData bookingDetailsData = BookingDetailsData.fromJson(response.data);
          emit(BookingDetailsFetchState(bookingDetailsData));
        }

      } on NetworkError {
        emit(BookingDetailsErrorState("Failed to update."));
      }
    });

    on<AcceptBookingDetailsEvent>((event, emit) async {
      try {
        emit(BookingDetailsLoadingState());
        var body = {
          "bookingid":event.bookingId,
          "carriertravelid":event.carriertravelid
        };
        final response = await _apiRepository.carrierAcceptBooking(body);
        if (response.status != 200) {
          emit(BookingDetailsErrorState(response.error));
        }else {

          emit(BookingDetailsAcceptState(response));
          this.add(GetBookingDetailsEvent(bookingId: event.bookingId));
        }

      } on NetworkError {
        emit(BookingDetailsErrorState("Failed to update."));
      }
    });

    on<ReachedCollectionCenterBookingEvent>((event, emit) async {
      try {
        emit(BookingDetailsLoadingState());
        var body = {
          "bookingid":event.bookingId
        };
        final response = await _apiRepository.carrierReachedCollectionCenter(body);
        if (response.status != 200) {
          emit(BookingDetailsErrorState(response.error));
        }else {

          emit(ReachedCollectionCenterBookingState(response));
          this.add(GetBookingDetailsEvent(bookingId: event.bookingId));
        }

      } on NetworkError {
        emit(BookingDetailsErrorState("Failed to update."));
      }
    });
    on<RejectCarrierEvent>((event, emit) async {
      try {
        emit(BookingDetailsLoadingState());
        var body = {
          "bookingid":event.bookingid
        };
        final response = await _apiRepository.carrierRejectBooking(body);
        if (response.status != 200) {
          emit(BookingDetailsErrorState(response.error));
        }else {
          emit(CarrierRejectedState(response));
        }

      } on NetworkError {
        emit(BookingDetailsErrorState("Network error, please try again."));
      }
    });
  }
}