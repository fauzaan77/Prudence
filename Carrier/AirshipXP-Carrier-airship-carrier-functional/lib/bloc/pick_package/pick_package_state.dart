import 'dart:io';
import 'package:airship_carrier/models/base_response_model.dart';

abstract class PickCarrierUpdateState {
  const PickCarrierUpdateState();

  @override
  List<Object?> get props => [];
}

class PickCarrierUpdateStateInitial extends PickCarrierUpdateState {}

class PickCarrierUpdateLoadingState extends PickCarrierUpdateState {}

class PickCarrierUpdateCompletedState extends PickCarrierUpdateState {
  final BaseResponseModel baseResponseModel;
  const PickCarrierUpdateCompletedState(this.baseResponseModel);
}

class ReachDropLocationCompletedState extends PickCarrierUpdateState {
  BaseResponseModel baseResponseModel;
  ReachDropLocationCompletedState(this.baseResponseModel);
}
class CarrierDeliveryCompletedState extends PickCarrierUpdateState {
  BaseResponseModel baseResponseModel;
  CarrierDeliveryCompletedState(this.baseResponseModel);
}

class CarrierCanceledState extends PickCarrierUpdateState {
  BaseResponseModel baseResponseModel;
  CarrierCanceledState(this.baseResponseModel);
}

class PickCarrierUpdateErrorState extends PickCarrierUpdateState {
  final String? message;

  const PickCarrierUpdateErrorState(this.message);
}

class SetCarrierImageDataState extends PickCarrierUpdateState {
  final List<File>? file;

  const SetCarrierImageDataState(this.file);
}