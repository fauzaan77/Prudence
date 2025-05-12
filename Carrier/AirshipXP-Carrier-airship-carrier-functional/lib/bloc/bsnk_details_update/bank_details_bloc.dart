import 'package:airship_carrier/backend/api_repo/api_repository.dart';
import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_event.dart';
import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_state.dart';
import 'package:bloc/bloc.dart';

class BankDetailsBloc extends Bloc<BankDetailsEvent, BankDetailsState> {
  BankDetailsBloc() : super(BankDetailsInitialState()) {
    final ApiRepository _apiRepository = ApiRepository();


    on<BankDetailsSubmitEvent>((event, emit) async {
      try {
        emit(BankDetailsLoadingState());
        var body = {
          "ifsccode":event.ifsccode,
          "branchname":event.branchname,
          "accountno":event.accountno
        };
        final response = await _apiRepository.updateBankDetails(body);
        if (response.status != 200) {
          emit(BankDetailsErrorState(response.error));
        }else {
          emit(BankDetailsUpdatedState(response));
        }

      } on NetworkError {
        emit(BankDetailsErrorState("Failed to update."));
      }
    });
  }
}