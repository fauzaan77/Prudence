import 'package:airship_carrier/models/personal_info_data_model.dart';

abstract class CreatePersonalInfoState {
  const CreatePersonalInfoState();

  @override
  List<Object?> get props => [];
}

class CreatePersonalInfoInitial extends CreatePersonalInfoState {}

class CreatePersonalInfoLoading extends CreatePersonalInfoState {}

class CreatePersonalInfoRegistered extends CreatePersonalInfoState {
  final PersonalInfoDataModel personalInfoDataModel;

  const CreatePersonalInfoRegistered(this.personalInfoDataModel);
}

class SaveDataPersonalInfoState extends CreatePersonalInfoState {
  final String? countryCode;
  bool isPasswordShow;
  bool isConfirmPasswordShow;

  SaveDataPersonalInfoState(this.countryCode,this.isPasswordShow,this.isConfirmPasswordShow);
}

class CreatePersonalInfoError extends CreatePersonalInfoState {
  final String? message;

  const CreatePersonalInfoError(this.message);
}
