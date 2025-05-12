import 'dart:convert';
import 'package:airship_carrier/backend/api_repo/api_repository.dart';
import 'package:airship_carrier/bloc/auth/mobile_login_event.dart';
import 'package:airship_carrier/bloc/auth/mobile_login_state.dart';
import 'package:airship_carrier/bloc/auth/verifyotp/verify_otp_event.dart';
import 'package:airship_carrier/bloc/auth/verifyotp/verify_otp_state.dart';
import 'package:airship_carrier/models/otp_data_model.dart';
import 'package:airship_carrier/models/personal_info_data_model.dart';
import 'package:airship_carrier/util/shared_pref.dart';
import 'package:bloc/bloc.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(VerifyOtpInitialState()) {
    final ApiRepository _apiRepository = ApiRepository();
    SessionManager sessionManager = SessionManager();

    on<OtpConfirmEvent>((event, emit) async {
      try {
        emit(VerifyOtpStateLoading());
        var body = {
          "phone":event.mobileNumber,
          "countrycode":event.countryCode,
          "otp":event.otp
        };
        final response = await _apiRepository.verifyOtpMobile(jsonEncode(body));
        if(response.error!=null){
          emit(VerifyOtpStateError(response.error));
        }else {
          print("JSON ENCODE : ${jsonEncode(response.data)}");
          PersonalInfoDataModel personalInfoDataModel;
          if(response.status == 200){
            personalInfoDataModel = PersonalInfoDataModel.fromJson(response.data);
            sessionManager.setString(SessionManager.AUTH_TOKEN, personalInfoDataModel.token ?? "");
            // print("personalInfoDataModel 1 ${jsonEncode(personalInfoDataModel)}");
            sessionManager.setString(SessionManager.USER_DATA,jsonEncode(personalInfoDataModel));
            emit(VerifyOtpStateConfirm(personalInfoDataModel));
          }else{
            emit(VerifyOtpStateConfirm(null));
          }
        }
      }catch(e){
        print("ERROR $e");
        emit(const VerifyOtpStateError("Server error, please try after sometime!"));
        emit(VerifyOtpInitialState());
      }
    });

    on<ResendOtpEvent>((event, emit) async {
      try {
        emit(VerifyOtpStateLoading());
        var body = {
          "phone":event.mobileNumber,
          "countrycode":event.countryCode,
        };
        final response = await _apiRepository.sendOtpMobile(jsonEncode(body));
        if(response.error!=null){
          emit(VerifyOtpStateError(response.error));
        }else {
          print("JSON ENCODE : ${jsonEncode(response.data)}");
          OtpData otpData = OtpData.fromJson(response.data);
          emit(ResendOtpStateConfirm());
        }
      }catch(e){
        print("ERROR $e");
        emit(const VerifyOtpStateError("Server error, please try after sometime!"));
        emit(ResendOtpStateConfirm());
      }
    });
  }
}