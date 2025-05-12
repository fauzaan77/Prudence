
import 'package:airship_carrier/backend/api_repo/api_repository.dart';
import 'package:airship_carrier/bloc/home/home_event.dart';
import 'package:airship_carrier/bloc/home/home_state.dart';
import 'package:airship_carrier/models/CarrierBookingsModel.dart';
import 'package:airship_carrier/models/trave_itinerary_model.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    final ApiRepository _apiRepository = ApiRepository();


    on<HomeIsOnlineEvent>((event, emit) async {
      emit(HomeIsOnlineState(event.isOnline??false));
    });
    on<CancelItineraryEvent>((event, emit) async {
      try {
        emit(HomeLoadingState());
        var body = {
          "carriertravelid":event.carriertravelid
        };
        final response = await _apiRepository.cancelTravelItinerary(body);
        if (response.status != 200) {
          emit(HomeErrorState(response.error));
        }else {
          /*TravelItineraryModel travelItineraryModel = TravelItineraryModel.fromJson(response.data);
          emit(HomeInitialState(newBookings: travelItineraryModel.data,isOnline: false));*/
          add(HomeInitialEvent());
        }

        updateFcmToken(_apiRepository);

      } on NetworkError {
        emit(HomeErrorState("Network error please try again later."));
      }
    });

    on<HomeInitialEvent>((event, emit) async {
      try {
        emit(HomeLoadingState());
        final response = await _apiRepository.getTravelItinerary();
        if (response.status != 200) {
          emit(HomeErrorState(response.error));
        }else {
          TravelItineraryModel travelItineraryModel = TravelItineraryModel.fromJson(response.data);
          emit(HomeInitialState(newBookings: travelItineraryModel.data,isOnline: false));
        }

        updateFcmToken(_apiRepository);

      } on NetworkError {
        emit(HomeErrorState("Network error please try again later."));
      }
    });

    on<GetItineraryBookingsEvent>((event, emit) async {
      try {
        emit(HomeLoadingState());
        var body = {
            "skip":0,
            "limit":100,
            "carriertravelid":event.carrierId
        };
        print("Request BODY $body");
        final response = await _apiRepository.itineraryBookingList(body);
        if (response.status != 200) {
          emit(HomeErrorState(response.error));
        }else {
          CarrierBookingData carrierBookingData = CarrierBookingData.fromJson(response.data);
          emit(BookingDataState(newBookings: carrierBookingData.bookings,isOnline: false));
        }

      } on NetworkError {
        emit(HomeErrorState("Network error please try again later."));
      }
    });

    on<UpcomingHistoryOrdersEvent>((event, emit) async {
      try {
        emit(HomeLoadingState());
        String status = "Active";
        if(event.selectedTab==1){
          status = "Past";
        }
        var body = {
            "status":status,
            "skip":0,
            "limit":100
        };
        final response = await _apiRepository.carrierBookings(body);
        if (response.status != 200) {
          emit(HomeErrorState(response.error));
        }else {
          CarrierBookingData carrierBookingData = CarrierBookingData.fromJson(response.data);
          emit(BookingDataState(newBookings: carrierBookingData.bookings,isOnline: false));
        }

      } on NetworkError {
        emit(HomeErrorState("Network error please try again later."));
      }
    });
  }

  updateFcmToken(ApiRepository apiRepository) async {
    String? token = "";
    try {
      token = await FirebaseMessaging.instance.getToken();

      var body = {
        "fcmtoken":token
      };
      final response = await apiRepository.updateFcmToken(body);
      print("FCM TOKEN RESPONSE : $response");

    } catch (e) {
      print(e);
    }
    print("FCM TOKEN : $token");
  }
}