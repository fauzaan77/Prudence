import 'dart:io';

import 'package:airship_carrier/bloc/carrier_lic_update/carrier_license_update_event.dart';
import 'package:airship_carrier/models/base_response_model.dart';
import 'package:airship_carrier/models/personal_info_data_model.dart';

abstract class UpdateCarrierLicenseState {
  const UpdateCarrierLicenseState();

  @override
  List<Object?> get props => [];
}

class UpdateCarrierLicenseStateInitial extends UpdateCarrierLicenseState {}

class UpdateCarrierLicenseStateLoading extends UpdateCarrierLicenseState {}

class UpdateCarrierLicenseStateCompleted extends UpdateCarrierLicenseState {
  final BaseResponseModel baseResponseModel;
  const UpdateCarrierLicenseStateCompleted(this.baseResponseModel);
}

class UpdateCarrierLicenseStateError extends UpdateCarrierLicenseState {
  final String? message;

  const UpdateCarrierLicenseStateError(this.message);
}

class SetDataState extends UpdateCarrierLicenseState {
  final String? date;
  final File? file;

  const SetDataState(this.date,this.file);
}

/*class SetImageState extends UpdateCarrierLicenseState {
  final File? file;

  const SetImageState(this.file);
}*/
