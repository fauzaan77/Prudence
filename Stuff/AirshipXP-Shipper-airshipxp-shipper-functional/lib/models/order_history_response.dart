import 'dart:convert';

OrderHistoryResponse orderHistoryResponseFromJson(String str) =>
    OrderHistoryResponse.fromJson(json.decode(str));

String orderHistoryResponseToJson(OrderHistoryResponse data) =>
    json.encode(data.toJson());

class OrderHistoryResponse {
  int? status;
  String? message;
  Data? data;

  OrderHistoryResponse({this.status, this.message, this.data});

  OrderHistoryResponse.fromJson(Map<String, dynamic> json) {
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
  int? totalcount;
  List<Bookings>? bookings;

  Data({this.totalcount, this.bookings});

  Data.fromJson(Map<String, dynamic> json) {
    totalcount = json['totalcount'];
    if (json['bookings'] != null) {
      bookings = <Bookings>[];
      json['bookings'].forEach((v) {
        bookings!.add(new Bookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalcount'] = this.totalcount;
    if (this.bookings != null) {
      data['bookings'] = this.bookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bookings {
  int? bookingid;
  String? bookingno;
  String? bookingdatetime;
  String? pickupaddress;
  String? dropaddress;
  String? bookingotp;
  String? bookingstatus;

  Bookings(
      {this.bookingid,
      this.bookingno,
      this.bookingdatetime,
      this.pickupaddress,
      this.dropaddress,
      this.bookingotp,
      this.bookingstatus});

  Bookings.fromJson(Map<String, dynamic> json) {
    bookingid = json['bookingid'];
    bookingno = json['bookingno'];
    bookingdatetime = json['bookingdatetime'];
    pickupaddress = json['pickupaddress'];
    dropaddress = json['dropaddress'];
    bookingotp = json['bookingotp'];
    bookingstatus = json['bookingstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingid'] = this.bookingid;
    data['bookingno'] = this.bookingno;
    data['bookingdatetime'] = this.bookingdatetime;
    data['pickupaddress'] = this.pickupaddress;
    data['dropaddress'] = this.dropaddress;
    data['bookingotp'] = this.bookingotp;
    data['bookingstatus'] = this.bookingstatus;
    return data;
  }
}
