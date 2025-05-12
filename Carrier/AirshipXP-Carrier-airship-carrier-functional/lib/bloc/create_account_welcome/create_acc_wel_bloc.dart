import 'package:airship_carrier/backend/api_repo/api_repository.dart';
import 'package:airship_carrier/bloc/add_personal_info/create_personalInfo_event.dart';
import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_event.dart';
import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_state.dart';
import 'package:airship_carrier/bloc/create_account_welcome/create_acc_wel_event.dart';
import 'package:airship_carrier/bloc/create_account_welcome/create_acc_wel_state.dart';
import 'package:airship_carrier/bloc/social_security_code/social_security_event.dart';
import 'package:airship_carrier/bloc/social_security_code/social_security_state.dart';
import 'package:bloc/bloc.dart';

class CreateAccWelcomeBloc extends Bloc<CreateAccWelcomeEvent, CreateAccWelcomeState> {
  CreateAccWelcomeBloc() : super(const CreateAccWelcomeSetDataState(
    isBankDetailsSaved: false,
    isDrivingLiceSaved: false,
    isPassportSaved: false,
    isPersonalInfoSaved: false,
    isProfilePhotoSaved: false,
    isSocialSecuritySaved: false
  )) {
    final ApiRepository _apiRepository = ApiRepository();


    on<CreateAccWelcomeDataEvent>((event, emit) async {
     emit(CreateAccWelcomeSetDataState(
         isBankDetailsSaved: event.isBankDetailsSaved,
         isDrivingLiceSaved: event.isDrivingLiceSaved,
         isPassportSaved: event.isPassportSaved,
         isPersonalInfoSaved: event.isPersonalInfoSaved,
         isProfilePhotoSaved: event.isProfilePhotoSaved,
         isSocialSecuritySaved: event.isSocialSecuritySaved
     ));
    });
  }
}