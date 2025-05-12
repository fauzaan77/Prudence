import 'package:airship_carrier/backend/api_repo/api_repository.dart';
import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_event.dart';
import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_state.dart';
import 'package:airship_carrier/bloc/home/home_event.dart';
import 'package:airship_carrier/bloc/home/home_state.dart';
import 'package:airship_carrier/bloc/notification/notification_event.dart';
import 'package:airship_carrier/bloc/notification/notification_state.dart';
import 'package:airship_carrier/bloc/social_security_code/social_security_event.dart';
import 'package:airship_carrier/bloc/social_security_code/social_security_state.dart';
import 'package:airship_carrier/bloc/tc_agree/tc_agree_event.dart';
import 'package:airship_carrier/bloc/tc_agree/tc_agree_state.dart';
import 'package:airship_carrier/models/CarrierBookingsModel.dart';
import 'package:airship_carrier/models/NotificationModel.dart';
import 'package:airship_carrier/models/ProfileDataModel.dart';
import 'package:bloc/bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationLoadingState()) {
    final ApiRepository _apiRepository = ApiRepository();


    on<NotificationLoadEvent>((event, emit) async {
      try {
        emit(NotificationLoadingState());
        var body = {
          "skip":0,
          "limit":100
        };
        final response = await _apiRepository.getCarrierNotifications(body);
        if (response.status != 200) {
          emit(NotificationErrorState(response.error));
        }else {
          NotificationData notificationData = NotificationData.fromJson(response.data);
          emit(NotificationLoadedState(notificationData: notificationData));
        }

      } on NetworkError {
        emit(NotificationErrorState("Network error please try again later."));
      }
    });
  }
}