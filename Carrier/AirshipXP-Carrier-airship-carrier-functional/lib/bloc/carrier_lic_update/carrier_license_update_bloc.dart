import 'dart:convert';

import 'package:airship_carrier/backend/api_repo/api_repository.dart';
import 'package:airship_carrier/bloc/add_personal_info/create_personalInfo_event.dart';
import 'package:airship_carrier/bloc/add_personal_info/create_personal_state.dart';
import 'package:airship_carrier/bloc/carrier_lic_update/carrier_license_update_event.dart';
import 'package:airship_carrier/bloc/carrier_lic_update/carrier_license_update_state.dart';
import 'package:airship_carrier/models/personal_info_data_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

class UpdateCarrierLicenseBloc extends Bloc<UpdateCarrierLicenseEvent, UpdateCarrierLicenseState> {
  UpdateCarrierLicenseBloc() : super(SetDataState(null,null)) {
    final ApiRepository _apiRepository = ApiRepository();

    on<SelectDataEvent>((event,emit)async{
      emit(SetDataState(event.licExpDate,event.file));
    });
    //
    // on<SelectLicPhotoEvent>((event,emit)async{
    //   emit(SetImageState(event.file));
    // });

    on<UpdateCarrierLicenseSubmitEvent>((event, emit) async {
      try {
        emit(UpdateCarrierLicenseStateLoading());
        var formData = FormData.fromMap({
          "fileInput": await MultipartFile.fromFile(event.file!.path, filename: event.licNo),
          "licenseexpirydate":event.licExpDate,
          "licenseno":event.licNo
        });
        final response = await _apiRepository.updateCarrierLicense(formData);
        if (response.status != 200) {
          emit(UpdateCarrierLicenseStateError(response.error));
        }else {
          emit(UpdateCarrierLicenseStateCompleted(response));
        }

      } on NetworkError {
        emit(UpdateCarrierLicenseStateError("Failed to update."));
      }
    });

    on<UploadProfilePicEvent>((event, emit) async {
      try {
        emit(UpdateCarrierLicenseStateLoading());
        var formData = FormData.fromMap({
          "fileInput": await MultipartFile.fromFile(event.file!.path, filename: "${DateTime.now().microsecondsSinceEpoch}"),
        });
        final response = await _apiRepository.updateCarrierProfile(formData);
        if (response.status != 200) {
          emit(UpdateCarrierLicenseStateError(response.error));
        }else {
          emit(UpdateCarrierLicenseStateCompleted(response));
        }

      } on NetworkError {
        emit(UpdateCarrierLicenseStateError("Failed to update."));
      }
    });
  }
}