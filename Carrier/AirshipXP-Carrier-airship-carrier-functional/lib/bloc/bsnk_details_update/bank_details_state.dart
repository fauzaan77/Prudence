import 'package:airship_carrier/models/base_response_model.dart';

abstract class BankDetailsState {
  const BankDetailsState();

  @override
  List<Object?> get props => [];
}

class BankDetailsInitialState extends BankDetailsState {}

class BankDetailsLoadingState extends BankDetailsState {}

class BankDetailsUpdatedState extends BankDetailsState {
  final BaseResponseModel baseResponseModel;
  const BankDetailsUpdatedState(this.baseResponseModel);
}

class BankDetailsErrorState extends BankDetailsState {
  final String? message;

  const BankDetailsErrorState(this.message);
}