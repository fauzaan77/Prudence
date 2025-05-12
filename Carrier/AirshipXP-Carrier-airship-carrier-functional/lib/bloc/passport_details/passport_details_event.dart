import 'dart:io';

abstract class UpdatePassportEvent {}

class UpdatePassportSubmitEvent extends UpdatePassportEvent {
  String? passportno;
  String? passportexpirydate;
  File? fileInput;

  UpdatePassportSubmitEvent(
      {
        this.passportno,
        this.passportexpirydate,
        this.fileInput
      });
}
class SelectPassportDataEvent extends UpdatePassportEvent {
  String? passportexpirydate;
  File? fileInput;
  SelectPassportDataEvent(
      {
        this.passportexpirydate,
        this.fileInput
      });
}