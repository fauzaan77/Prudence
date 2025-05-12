import 'package:airship_carrier/models/base_response_model.dart';

abstract class SecurityState {
  const SecurityState();

  @override
  List<Object?> get props => [];
}

class SecurityInitialState extends SecurityState {}

class SecurityLoadingState extends SecurityState {}

class SecurityUpdatedState extends SecurityState {
  final BaseResponseModel baseResponseModel;
  const SecurityUpdatedState(this.baseResponseModel);
}

class SecurityErrorState extends SecurityState {
  final String? message;

  const SecurityErrorState(this.message);
}