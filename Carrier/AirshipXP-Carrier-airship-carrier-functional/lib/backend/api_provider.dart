import 'dart:collection';

import 'package:airship_carrier/models/base_response_model.dart';
import 'package:airship_carrier/util/shared_pref.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio dio = Dio();
  static String image_base_url = "http://18.209.22.126/as/";
  String base_url = "http://18.209.22.126/as/api/";
  SessionManager sessionManager = SessionManager();
  ApiProvider(){
    configureDio();
  }
  void configureDio() {
    // Set default configs
    dio.options.baseUrl = base_url;
    dio.interceptors.add(LogInterceptor());

  }

  Future<BaseResponseModel> postCall(var body,String endpoint,
      {HashMap<String, dynamic>? header}) async {
    try {
      String? token = await sessionManager.getString(SessionManager.AUTH_TOKEN);
      // HashMap<String,dynamic> header = HashMap();
      header ??= HashMap();
      if(token!=null && token != ""){
        header.putIfAbsent("authorization", () => "Bearer $token");
      }
      Response response = await dio.post(endpoint,data: body,
          options: Options(headers: header));
      print("Response Data  $response");
      BaseResponseModel baseResponseModel = BaseResponseModel.fromJson(response.data);
      if(baseResponseModel.status == 400){
        print("Response Data Status  ${baseResponseModel.status}");
        print("Response Data Status  ${baseResponseModel.message}");
        return BaseResponseModel.withError(baseResponseModel.message??"",baseResponseModel.status??500);
      }else {
        return baseResponseModel;
      }
    } catch (error) {
      print("response  ERROR ${error}");
      return BaseResponseModel.withError("$error",500);
    }
  }

  Future<BaseResponseModel> requestCall(var body,String endpoint) async {
    try {
      String? token = await sessionManager.getString(SessionManager.AUTH_TOKEN);
      print("Request Body  $body");
      HashMap<String,dynamic> header = HashMap();
      if(token!=null && token != ""){
        header.putIfAbsent("authorization", () => "Bearer $token");
        header.putIfAbsent("content-type", () => "multipart/form-data");
      }
      Response response = await dio.post(endpoint,data: body,
          options: Options(headers: header));
      print("Response Data  $response");
      BaseResponseModel baseResponseModel = BaseResponseModel.fromJson(response.data);
      if(baseResponseModel.status == 400){
        print("Response Data Status  ${baseResponseModel.status}");
        print("Response Data Status  ${baseResponseModel.message}");
        return BaseResponseModel.withError(baseResponseModel.message??"",baseResponseModel.status??500);
      }else {
        return baseResponseModel;
      }
    } catch (error) {
      print("response  ERROR ${error}");
      return BaseResponseModel.withError("$error",500);
    }
  }

  Future<BaseResponseModel> getCall(String endpoint) async {
    try {
      String? token = await sessionManager.getString(SessionManager.AUTH_TOKEN);
      HashMap<String,dynamic> header = HashMap();
      if(token!=null && token != ""){
        header.putIfAbsent("authorization", () => "Bearer $token");
      }
      Response response = await dio.get(endpoint, options: Options(headers: header));
      print("Response Data  $response");
      BaseResponseModel baseResponseModel = BaseResponseModel.fromJson(response.data);
      if(baseResponseModel.status == 400){
        print("Response Data Status  ${baseResponseModel.status}");
        print("Response Data Status  ${baseResponseModel.message}");
        return BaseResponseModel.withError(baseResponseModel.message??"",baseResponseModel.status??500);
      }else {
        return baseResponseModel;
      }
    } catch (error) {
      print("response  ERROR ${error}");
      return BaseResponseModel.withError("$error",500);
    }
  }

  /*Future<CreateCarrierModel> addPersonalInfo(var body) async {
    try {
      Response response = await dio.post("createCarrier",data: body);
      print("response  $response");
      CreateCarrierModel createCarrierModel = CreateCarrierModel.fromJson(response.data);
      if(createCarrierModel.status == 400){
        return CreateCarrierModel.withError(createCarrierModel.message??"");
      }else {
        return createCarrierModel;
      }
    } catch (error) {
      print("response  ERROR ${error}");
      return CreateCarrierModel.withError("Data not found / Connection issue");
    }
  }*/
}