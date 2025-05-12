import 'dart:convert';

CreateBookingResponse createBookingResponseFromJson(String str) =>
    CreateBookingResponse.fromJson(json.decode(str));

String createBookingResponseToJson(CreateBookingResponse data) =>
    json.encode(data.toJson());

class CreateBookingResponse {
  int? status;
  String? message;
  Data? data;

  CreateBookingResponse({this.status, this.message, this.data});

  CreateBookingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? bookingid;
  String? bookingno;

  Data({this.bookingid, this.bookingno});

  Data.fromJson(Map<String, dynamic> json) {
    bookingid = json['bookingid'];
    bookingno = json['bookingno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingid'] = this.bookingid;
    data['bookingno'] = this.bookingno;
    return data;
  }
}
