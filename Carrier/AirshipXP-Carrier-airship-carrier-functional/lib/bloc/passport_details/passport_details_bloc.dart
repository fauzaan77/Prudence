import 'package:airship_carrier/backend/api_repo/api_repository.dart';
import 'package:airship_carrier/bloc/passport_details/passport_details_event.dart';
import 'package:airship_carrier/bloc/passport_details/passport_details_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

class PassportDetailsBloc extends Bloc<UpdatePassportEvent, PassportUpdateState> {
  PassportDetailsBloc() : super(const SetPassportDataState(null,null)) {
    final ApiRepository _apiRepository = ApiRepository();

    on<SelectPassportDataEvent>((event,emit)async{
      emit(SetPassportDataState(event.passportexpirydate,event.fileInput));
    });

    on<UpdatePassportSubmitEvent>((event, emit) async {
      try {
        emit(PassportUpdateStateLoading());
        var formData = FormData.fromMap({
          "fileInput": await MultipartFile.fromFile(event.fileInput!.path, filename: event.passportno),
          "passportexpirydate":event.passportexpirydate,
          "passportno":event.passportno
        });
        final response = await _apiRepository.setPassportDetails(formData);
        if (response.status != 200) {
          emit(PassportUpdateStateError(response.error));
        }else {
          emit(PassportUpdateStateCompleted(response));
        }

      } on NetworkError {
        emit(PassportUpdateStateError("Failed to update."));
      }
    });
  }
}