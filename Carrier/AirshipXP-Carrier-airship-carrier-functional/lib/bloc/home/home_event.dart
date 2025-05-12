import 'dart:io';

abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {
  HomeInitialEvent();
}

class UpcomingHistoryOrdersEvent extends HomeEvent {
  int selectedTab;
  UpcomingHistoryOrdersEvent({required this.selectedTab});
}

class CancelItineraryEvent extends HomeEvent {
  int carriertravelid;
  CancelItineraryEvent({required this.carriertravelid});
}

class GetItineraryBookingsEvent extends HomeEvent {
  int carrierId;
  GetItineraryBookingsEvent({required this.carrierId});
}
class GetProfileEvent extends HomeEvent {

}

class HomeIsOnlineEvent extends HomeEvent {
  bool? isOnline;
  HomeIsOnlineEvent(
      {
        this.isOnline
      });
}