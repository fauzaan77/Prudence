import 'dart:convert';
import 'package:airship_carrier/backend/api_repo/api_repository.dart';
import 'package:airship_carrier/bloc/auth/mobile_login_event.dart';
import 'package:airship_carrier/bloc/auth/mobile_login_state.dart';
import 'package:airship_carrier/models/otp_data_model.dart';
import 'package:bloc/bloc.dart';

import '../../models/personal_info_data_model.dart';
import '../../util/shared_pref.dart';

class MobileLoginBloc extends Bloc<MobileLoginEventA, MobileLoginStateA> {
  MobileLoginBloc() : super(MobileLoginChangeState(false,"IN")) {
    final ApiRepository _apiRepository = ApiRepository();

    on<MobileLoginChangeEvent>((event, emit) async {
      emit(MobileLoginChangeState(event.isEmail,event.countryCode));
    });

    on<SendOtpEvent>((event, emit) async {
      try {
        emit(MobileLoginStateLoading());
        var body = {
          "phone":event.mobileNumber,
          "countrycode":event.countryCode,
        };
        final response = await _apiRepository.sendOtpMobile(jsonEncode(body));
        if(response.error!=null){
          print("STATUS CODE :${response.status}");
          emit(MobileLoginStateError(response.error,response.errorCode));
          emit(MobileLoginChangeState(false,event.countryCode??"IN"));
        }else {
          print("JSON ENCODE : ${jsonEncode(response.data)}");
          OtpData otpData = OtpData.fromJson(response.data);
          emit(MobileLoginStateResponse(otpData));
        }
      }catch(e){
        print("ERROR $e");
        emit(const MobileLoginStateError("Server error, please try after sometime!",500));
        emit(MobileLoginChangeState(false,event.countryCode??"IN"));
      }
    });

    SessionManager sessionManager = SessionManager();
    on<SendEmailOtpEvent>((event, emit) async {
      try {
        emit(MobileLoginStateLoading());
        var body = {
          "email":event.email,
          "password":event.password
        };
        final response = await _apiRepository.carrierAuthenticate(jsonEncode(body));
        if(response.status == 200){
          PersonalInfoDataModel personalInfoDataModel = PersonalInfoDataModel.fromJson(response.data);
          sessionManager.setString(SessionManager.AUTH_TOKEN, personalInfoDataModel.token ?? "");
          sessionManager.setString(SessionManager.USER_DATA,jsonEncode(personalInfoDataModel));
          emit(EmailLoginSuccess(personalInfoDataModel));
        }else{
          emit(EmailLoginSuccess(null));
        }
      }catch(e){
        print("ERROR $e");
        emit(const MobileLoginStateError("Server error, please try after sometime!",500));
        emit(MobileLoginChangeState(true,"IN"));
      }
    });
  }
}