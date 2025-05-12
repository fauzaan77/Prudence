import 'package:airship_carrier/backend/api_repo/api_repository.dart';
import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_event.dart';
import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_state.dart';
import 'package:airship_carrier/bloc/social_security_code/social_security_event.dart';
import 'package:airship_carrier/bloc/social_security_code/social_security_state.dart';
import 'package:airship_carrier/bloc/tc_agree/tc_agree_event.dart';
import 'package:airship_carrier/bloc/tc_agree/tc_agree_state.dart';
import 'package:bloc/bloc.dart';

class TCAgreeBloc extends Bloc<TCAgreeEvent, TCAgreeState> {
  TCAgreeBloc() : super(TCAgreeUpdatedState(false)) {
    final ApiRepository _apiRepository = ApiRepository();


    on<TCAgreeCheckEvent>((event, emit) async {
        emit(TCAgreeUpdatedState(event.isTCAgree??false));
    });
  }
}