import 'package:airship_carrier/models/otp_data_model.dart';
import 'package:airship_carrier/models/personal_info_data_model.dart';

abstract class MobileLoginStateA {
  const MobileLoginStateA();

  @override
  List<Object?> get props => [];
}

class MobileLoginStateInitial extends MobileLoginStateA {
  // String countryCode;
  // MobileLoginStateInitial(this.countryCode);
}

class MobileLoginStateLoading extends MobileLoginStateA {}

class MobileLoginStateResponse extends MobileLoginStateA {
  final OtpData otpData;

  const MobileLoginStateResponse(this.otpData);
}
class MobileLoginChangeState extends MobileLoginStateA {
  bool isEmail;
  String countryCode;
  MobileLoginChangeState(this.isEmail,this.countryCode);
}


class EmailLoginSuccess extends MobileLoginStateA {
  PersonalInfoDataModel? personalInfoDataModel;
  EmailLoginSuccess(this.personalInfoDataModel);
}


class CountryChangeChangeState extends MobileLoginStateA {
  String countryCode;
  CountryChangeChangeState(this.countryCode);
}

class MobileLoginStateError extends MobileLoginStateA {
  final String? message;
  final int? code;

  const MobileLoginStateError(this.message,this.code);
}
