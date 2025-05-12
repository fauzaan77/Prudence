import 'dart:io';

abstract class CreateAccWelcomeEvent {}

class CreateAccWelcomeDataEvent extends CreateAccWelcomeEvent {
  bool? isPersonalInfoSaved;
  bool? isDrivingLiceSaved;
  bool? isProfilePhotoSaved;
  bool? isBankDetailsSaved;
  bool? isSocialSecuritySaved;
  bool? isPassportSaved;

  CreateAccWelcomeDataEvent(
      {
        this.isBankDetailsSaved,
        this.isDrivingLiceSaved,
        this.isPassportSaved,
        this.isPersonalInfoSaved,
        this.isProfilePhotoSaved,
        this.isSocialSecuritySaved
      });
}