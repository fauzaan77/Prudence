import 'package:airship_carrier/backend/api_repo/api_repository.dart';
import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_event.dart';
import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_state.dart';
import 'package:airship_carrier/bloc/social_security_code/social_security_event.dart';
import 'package:airship_carrier/bloc/social_security_code/social_security_state.dart';
import 'package:bloc/bloc.dart';

class SecurityBloc extends Bloc<SocialSecurityEvent, SecurityState> {
  SecurityBloc() : super(SecurityInitialState()) {
    final ApiRepository _apiRepository = ApiRepository();


    on<SocialSecuritySubmitEvent>((event, emit) async {
      try {
        emit(SecurityLoadingState());
        var body = {
          "securityno":event.securityno
        };
        final response = await _apiRepository.setSecurityNo(body);
        if (response.status != 200) {
          emit(SecurityErrorState(response.error));
        }else {
          emit(SecurityUpdatedState(response));
        }

      } on NetworkError {
        emit(SecurityErrorState("Failed to update."));
      }
    });
  }
}