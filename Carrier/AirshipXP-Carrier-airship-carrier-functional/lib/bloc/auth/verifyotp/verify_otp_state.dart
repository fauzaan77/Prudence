import 'package:airship_carrier/models/personal_info_data_model.dart';

abstract class VerifyOtpState {
  const VerifyOtpState();

  @override
  List<Object?> get props => [];
}

class VerifyOtpInitialState extends VerifyOtpState {}

class VerifyOtpStateLoading extends VerifyOtpState {}

class VerifyOtpStateConfirm extends VerifyOtpState {
  PersonalInfoDataModel? personalInfoDataModel;
  VerifyOtpStateConfirm(this.personalInfoDataModel);
}

class ResendOtpStateConfirm extends VerifyOtpState {}

class VerifyOtpStateError extends VerifyOtpState {
  final String? message;

  const VerifyOtpStateError(this.message);
}
