import 'dart:io';
import 'package:airship_carrier/models/base_response_model.dart';

abstract class PassportUpdateState {
  const PassportUpdateState();

  @override
  List<Object?> get props => [];
}

class PassportUpdateStateInitial extends PassportUpdateState {}

class PassportUpdateStateLoading extends PassportUpdateState {}

class PassportUpdateStateCompleted extends PassportUpdateState {
  final BaseResponseModel baseResponseModel;
  const PassportUpdateStateCompleted(this.baseResponseModel);
}

class PassportUpdateStateError extends PassportUpdateState {
  final String? message;

  const PassportUpdateStateError(this.message);
}

class SetPassportDataState extends PassportUpdateState {
  final String? date;
  final File? file;

  const SetPassportDataState(this.date,this.file);
}