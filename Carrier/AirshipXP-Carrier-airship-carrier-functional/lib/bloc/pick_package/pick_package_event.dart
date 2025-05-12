import 'dart:io';

abstract class PickPackageEvent {}

class PickPackageSubmitEvent extends PickPackageEvent {
  int? bookingid;
  List<File>? fileInput;
  String? bookingotp;
  PickPackageSubmitEvent(
      {
        this.bookingid,
        this.fileInput,
        this.bookingotp
      });
}
class ReachedDropSubmitEvent extends PickPackageEvent {
  int? bookingid;

  ReachedDropSubmitEvent(
      {
        this.bookingid
      });
}

class CarrierDeliveredEvent extends PickPackageEvent {
  int? bookingid;

  CarrierDeliveredEvent(
      {
        this.bookingid
      });
}
class CancelCarrierEvent extends PickPackageEvent {
  int? bookingid;

  CancelCarrierEvent(
      {
        this.bookingid
      });
}

class AddCarrierImageEvent extends PickPackageEvent {
  List<File>? fileInput;
  AddCarrierImageEvent(
      {
        this.fileInput
      });
}