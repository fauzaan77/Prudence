import 'dart:io';

abstract class UpdateCarrierLicenseEvent {}

class UpdateCarrierLicenseSubmitEvent extends UpdateCarrierLicenseEvent {
  String? licNo;
  String? licExpDate;
  File? file;

  UpdateCarrierLicenseSubmitEvent(
      {
        this.licNo,
        this.licExpDate,
        this.file
      });
}
class UploadProfilePicEvent extends UpdateCarrierLicenseEvent {
  File? file;

  UploadProfilePicEvent(
      {
        this.file
      });
}

class SelectDataEvent extends UpdateCarrierLicenseEvent {
  String? licExpDate;
  File? file;
  SelectDataEvent(
      {
        this.licExpDate,
        this.file
      });
}
/*class SelectLicPhotoEvent extends UpdateCarrierLicenseEvent {
  File? file;

  SelectLicPhotoEvent(
      {
        this.file
      });
}*/
