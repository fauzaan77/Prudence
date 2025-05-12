import 'dart:collection';

import 'package:airship_carrier/backend/api_provider.dart';
import 'package:airship_carrier/models/base_response_model.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<BaseResponseModel> carrierAuthenticate(var body) {
    return _provider.postCall(body,"carrierAuthenticate");
  }
  Future<BaseResponseModel> emailSendOtp(var body) {
    return _provider.postCall(body,"emailSendOtp");
  }
  Future<BaseResponseModel> sendOtpMobile(var body) {
    return _provider.postCall(body,"sendCarrierOtp");
  }
  Future<BaseResponseModel> verifyOtpMobile(var body) {
    return _provider.postCall(body,"verifyCarrierOtp");
  }
  Future<BaseResponseModel> addPersonalInfo(var body) {
    return _provider.postCall(body,"createCarrier");
  }
  Future<BaseResponseModel> updateCarrierProfile(var body) {
    HashMap<String,dynamic> header = HashMap();
    header.putIfAbsent("content-type", () => "multipart/form-data");
    return _provider.postCall(body,"updateCarrierProfile",header: header);
  }
  Future<BaseResponseModel> updateCarrierLicense(var body) {
    HashMap<String,dynamic> header = HashMap();
    header.putIfAbsent("content-type", () => "multipart/form-data");
    return _provider.postCall(body,"setCarrierLicense",header: header);
  }
  Future<BaseResponseModel> updateBankDetails(var body) {
    return _provider.postCall(body,"setBankDetails");
  }
  Future<BaseResponseModel> setSecurityNo(var body) {
    return _provider.postCall(body,"setSecurityNo");
  }
  Future<BaseResponseModel> setPassportDetails(var body) {
    return _provider.postCall(body,"setPassportDetails");
  }
  Future<BaseResponseModel> getCities() {
    return _provider.getCall("getCities");
  }
  Future<BaseResponseModel> getAirports(var body) {
    return _provider.postCall(body,"getAirports");
  }
  Future<BaseResponseModel> setCarrierTravelDetails(var body) {
    return _provider.postCall(body,"setCarrierTravelDetails");
  }
  Future<BaseResponseModel> editTravelItinerary(var body) {
    return _provider.postCall(body,"editTravelItinerary");
  }
  Future<BaseResponseModel> carrierBookings(var body) {
    return _provider.postCall(body,"carrierBookings");
  }
  Future<BaseResponseModel> itineraryBookingList(var body) {
    return _provider.postCall(body,"itineraryBookingList");
  }
  Future<BaseResponseModel> cancelTravelItinerary(var body) {
    return _provider.postCall(body,"cancelTravelItinerary");
  }
  Future<BaseResponseModel> getTravelItinerary() {
    return _provider.getCall("getTravelItinerary");
  }
  Future<BaseResponseModel> updateFcmToken(var body) {
    return _provider.postCall(body,"updateCarrierFcmToken");
  }
  Future<BaseResponseModel> carrierBookingDetails(var body) {
    return _provider.postCall(body,"carrierBookingDetails");
  }
  Future<BaseResponseModel> carrierAcceptBooking(var body) {
    return _provider.postCall(body,"carrierAcceptBooking");
  }
  Future<BaseResponseModel> carrierReachedCollectionCenter(var body) {
    return _provider.postCall(body,"carrierReachedCollectionCenter");
  }
  Future<BaseResponseModel> carrierPickupBooking(var body) {
    return _provider.requestCall(body,"carrierPickupBooking");
  }
  Future<BaseResponseModel> carrierReachedDropLocation(var body) {
    return _provider.postCall(body,"carrierReachedDropLocation");
  }
  Future<BaseResponseModel> carrierDeliveredBooking(var body) {
    return _provider.postCall(body,"carrierDeliveredBooking");
  }
  Future<BaseResponseModel> carrierCancelledBooking(var body) {
    return _provider.postCall(body,"carrierCancelledBooking");
  }
  Future<BaseResponseModel> carrierRejectBooking(var body) {
    return _provider.postCall(body,"carrierRejectBooking");
  }
  Future<BaseResponseModel> getCarrierProfile() {
    return _provider.getCall("getCarrierProfile");
  }
  Future<BaseResponseModel> getCarrierNotifications(var body) {
    return _provider.postCall(body,"getCarrierNotifications");
  }
}

class NetworkError extends Error {}