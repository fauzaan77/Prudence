import 'dart:io';

abstract class BookingDetailEvent {}

class BookingDetailInitialEvent extends BookingDetailEvent {

}

class GetBookingDetailsEvent extends BookingDetailEvent {
  int bookingId;
  GetBookingDetailsEvent(
      {
        required this.bookingId
      });
}
class AcceptBookingDetailsEvent extends BookingDetailEvent {
  int bookingId;
  int carriertravelid;
  AcceptBookingDetailsEvent(
      {
        required this.bookingId,
        required this.carriertravelid
      });
}
class ReachedCollectionCenterBookingEvent extends BookingDetailEvent {
  int bookingId;
  ReachedCollectionCenterBookingEvent(
      {
        required this.bookingId,
      });
}

class RejectCarrierEvent extends BookingDetailEvent {
  int? bookingid;

  RejectCarrierEvent(
      {
        this.bookingid
      });
}