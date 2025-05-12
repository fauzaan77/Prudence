import 'dart:convert';

BookingDetailsResponse bookingDetailsResponseFromJson(String str) =>
    BookingDetailsResponse.fromJson(json.decode(str));

String bookingDetailsResponseToJson(BookingDetailsResponse data) =>
    json.encode(data.toJson());

class BookingDetailsResponse {
  int? status;
  String? message;
  Data? data;

  BookingDetailsResponse({this.status, this.message, this.data});

  BookingDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  String? bookingdatetime;
  String? pickupaddress;
  String? dropaddress;
  String? recipientphone;
  String? weightslot;
  String? sizeslot;
  String? carrier;
  String? carrierphone;
  dynamic carrierrating;
  dynamic subtotal;
  dynamic discount;
  dynamic tax;
  dynamic totalamount;
  String? paymenttype;
  String? carrierimagepath;
  int? bookingstatusid;
  String? bookingstatus;
  dynamic pickupimagepath;

  Data(
      {this.bookingid,
      this.bookingno,
      this.bookingdatetime,
      this.pickupaddress,
      this.dropaddress,
      this.recipientphone,
      this.weightslot,
      this.sizeslot,
      this.carrier,
      this.carrierphone,
      this.carrierrating,
      this.subtotal,
      this.discount,
      this.tax,
      this.totalamount,
      this.paymenttype,
      this.carrierimagepath,
      this.bookingstatusid,
      this.bookingstatus,
      this.pickupimagepath});

  Data.fromJson(Map<String, dynamic> json) {
    bookingid = json['bookingid'];
    bookingno = json['bookingno'];
    bookingdatetime = json['bookingdatetime'];
    pickupaddress = json['pickupaddress'];
    dropaddress = json['dropaddress'];
    recipientphone = json['recipientphone'];
    weightslot = json['weightslot'];
    sizeslot = json['sizeslot'];
    carrier = json['carrier'];
    carrierphone = json['carrierphone'];
    carrierrating = json['carrierrating'];
    subtotal = json['subtotal'];
    discount = json['discount'];
    tax = json['tax'];
    totalamount = json['totalamount'];
    paymenttype = json['paymenttype'];
    carrierimagepath = json['carrierimagepath'];
    bookingstatusid = json['bookingstatusid'];
    bookingstatus = json['bookingstatus'];
    pickupimagepath = json['pickupimagepath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingid'] = this.bookingid;
    data['bookingno'] = this.bookingno;
    data['bookingdatetime'] = this.bookingdatetime;
    data['pickupaddress'] = this.pickupaddress;
    data['dropaddress'] = this.dropaddress;
    data['recipientphone'] = this.recipientphone;
    data['weightslot'] = this.weightslot;
    data['sizeslot'] = this.sizeslot;
    data['carrier'] = this.carrier;
    data['carrierphone'] = this.carrierphone;
    data['carrierrating'] = this.carrierrating;
    data['subtotal'] = this.subtotal;
    data['discount'] = this.discount;
    data['tax'] = this.tax;
    data['totalamount'] = this.totalamount;
    data['paymenttype'] = this.paymenttype;
    data['carrierimagepath'] = this.carrierimagepath;
    data['bookingstatusid'] = this.bookingstatusid;
    data['bookingstatus'] = this.bookingstatus;
    data['pickupimagepath'] = this.pickupimagepath;
    return data;
  }
}
