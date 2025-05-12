import 'package:airship_carrier/backend/api_repo/api_repository.dart';
import 'package:airship_carrier/bloc/pick_package/pick_package_event.dart';
import 'package:airship_carrier/bloc/pick_package/pick_package_state.dart';
import 'package:airship_carrier/models/base_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

class PickCarrierBloc extends Bloc<PickPackageEvent, PickCarrierUpdateState> {
  PickCarrierBloc() : super(const SetCarrierImageDataState(null)) {
    final ApiRepository _apiRepository = ApiRepository();

    on<AddCarrierImageEvent>((event,emit)async{
      emit(SetCarrierImageDataState(event.fileInput));
    });

    on<PickPackageSubmitEvent>((event, emit) async {
      try {
        emit(PickCarrierUpdateLoadingState());
        final multipartImageList = event.fileInput?.map((image) =>
            MultipartFile.fromFileSync(image.path,filename: image.path.split('/').last)).toList();
        List uploadList = [];
        int counter = 0;
        for (var imageFiles in event.fileInput!) {
          counter++;
          uploadList.add(await MultipartFile.fromFile(imageFiles.path,
              filename: "Proof-$counter-${event.bookingid}"));
        }
        var formData = FormData.fromMap({
          "fileInput": uploadList,
          "bookingid":event.bookingid,
          "otp":event.bookingotp
        });
        final response = await _apiRepository.carrierPickupBooking(formData);
        if (response.status != 200) {
          emit(PickCarrierUpdateErrorState(response.error));
        }else {
          emit(PickCarrierUpdateCompletedState(response));

        }

      } on NetworkError {
        emit(PickCarrierUpdateErrorState("Failed to update."));
      }
    });

    on<ReachedDropSubmitEvent>((event, emit) async {
      try {
        emit(PickCarrierUpdateLoadingState());
        var body = {
          "bookingid": event.bookingid,
        };
        final response = await _apiRepository.carrierReachedDropLocation(body);
        if (response.status != 200) {
          emit(PickCarrierUpdateErrorState(response.error));
        }else {
          emit(ReachDropLocationCompletedState(response));
        }

      } on NetworkError {
        emit(PickCarrierUpdateErrorState("Failed to update."));
      }
    });
    on<CarrierDeliveredEvent>((event, emit) async {
      try {
        emit(PickCarrierUpdateLoadingState());
        var body = {
          "bookingid": event.bookingid
        };
        final response = await _apiRepository.carrierDeliveredBooking(body);
        if (response.status != 200) {
          emit(PickCarrierUpdateErrorState(response.error));
        }else {
          emit(CarrierDeliveryCompletedState(response));
        }

      } on NetworkError {
        emit(PickCarrierUpdateErrorState("Failed to update."));
      }
    });
    on<CancelCarrierEvent>((event, emit) async {
      try {
        emit(PickCarrierUpdateLoadingState());
        var body = {
          "bookingid": event.bookingid
        };
        final response = await _apiRepository.carrierCancelledBooking(body);
        if (response.status != 200) {
          emit(PickCarrierUpdateErrorState(response.error));
        }else {
          emit(CarrierCanceledState(response));
        }

      } on NetworkError {
        emit(PickCarrierUpdateErrorState("Network error,pplease try again later."));
      }
    });
  }
}