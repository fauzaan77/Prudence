import 'package:airship_carrier/models/base_response_model.dart';

abstract class CreateAccWelcomeState {
  const CreateAccWelcomeState();

  @override
  List<Object?> get props => [];
}

class CreateAccWelcomeInitialState extends CreateAccWelcomeState {}

class CreateAccWelcomeLoadingState extends CreateAccWelcomeState {}

class CreateAccWelcomeUpdatedState extends CreateAccWelcomeState {
  final BaseResponseModel baseResponseModel;
  const CreateAccWelcomeUpdatedState(this.baseResponseModel);
}

class CreateAccWelcomeSetDataState extends CreateAccWelcomeState {
  final bool? isPersonalInfoSaved;
  final bool? isDrivingLiceSaved;
  final bool? isProfilePhotoSaved;
  final bool? isBankDetailsSaved;
  final bool? isSocialSecuritySaved;
  final bool? isPassportSaved;

  const CreateAccWelcomeSetDataState(
      {this.isBankDetailsSaved,
      this.isDrivingLiceSaved,
      this.isPassportSaved,
      this.isPersonalInfoSaved,
      this.isProfilePhotoSaved,
      this.isSocialSecuritySaved});
}
class CreateAccWelcomeErrorState extends CreateAccWelcomeState {
  final String? message;

  const CreateAccWelcomeErrorState(this.message);
}