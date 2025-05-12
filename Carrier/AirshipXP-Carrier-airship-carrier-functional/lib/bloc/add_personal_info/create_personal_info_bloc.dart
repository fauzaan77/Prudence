import 'dart:convert';

import 'package:airship_carrier/backend/api_repo/api_repository.dart';
import 'package:airship_carrier/bloc/add_personal_info/create_personalInfo_event.dart';
import 'package:airship_carrier/bloc/add_personal_info/create_personal_state.dart';
import 'package:airship_carrier/models/personal_info_data_model.dart';
import 'package:airship_carrier/util/shared_pref.dart';
import 'package:bloc/bloc.dart';

class AddPersonalInfoBloc extends Bloc<CreatePersonalInfoEvent, CreatePersonalInfoState> {
  AddPersonalInfoBloc() : super(CreatePersonalInfoInitial()) {
    final ApiRepository _apiRepository = ApiRepository();
    SessionManager sessionManager = SessionManager();

    on<SaveValuePersonalInfoEvent>((event,state)async{
      emit(SaveDataPersonalInfoState(event.countryCode,event.isPasswordShow,event.isConfirmPasswordShow));
    });

    on<AddPersonalInfoEvent>((event, emit) async {
      try {
        emit(CreatePersonalInfoLoading());
        var body = {
          "firstname":event.firstname,
          "lastname":event.lastname,
          "email":event.email,
          "countrycode":event.countryCode,
          "phone":event.phoneNumber,
          "address":event.address,
          "password":event.password
        };
        final response = await _apiRepository.addPersonalInfo(jsonEncode(body));
        if(response.status!=200){
          emit(CreatePersonalInfoError(response.error));
        }else {
          PersonalInfoDataModel personalInfoDataModel = PersonalInfoDataModel.fromJson(response.data);
          sessionManager.setString(SessionManager.AUTH_TOKEN, personalInfoDataModel.token ?? "");
          sessionManager.setString(SessionManager.USER_DATA,jsonEncode(personalInfoDataModel));
          // sessionManager.setString(SessionManager.USER_DATA,"slkcslkmdlmldk");
          emit(CreatePersonalInfoRegistered(personalInfoDataModel));
        }
      } on NetworkError {
        emit(CreatePersonalInfoError("Failed to register."));
      }
    });
  }
}