import 'package:airship_carrier/models/CarrierBookingsModel.dart';
import 'package:airship_carrier/models/NotificationModel.dart';
import 'package:airship_carrier/models/ProfileDataModel.dart';
import 'package:airship_carrier/models/base_response_model.dart';

abstract class NotificationState {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitialState extends NotificationState {

}

class NotificationLoadedState extends NotificationState {
  NotificationData? notificationData;
  NotificationLoadedState({this.notificationData});
}


class NotificationLoadingState extends NotificationState {
}

class NotificationErrorState extends NotificationState {
  String? message;

  NotificationErrorState(this.message);
}
