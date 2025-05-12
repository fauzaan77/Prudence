class CarrierBookingsModel {
  CarrierBookingsModel({
      this.data,});

  CarrierBookingsModel.fromJson(dynamic json) {
    data = json['data'] != null ? CarrierBookingData.fromJson(json['data']) : null;
  }
  CarrierBookingData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class CarrierBookingData {
  CarrierBookingData({
    this.totalcount,
    this.bookings,});

  CarrierBookingData.fromJson(dynamic json) {
    totalcount = json['totalcount'];
    if (json['bookings'] != null) {
      bookings = [];
      json['bookings'].forEach((v) {
        bookings?.add(Bookings.fromJson(v));
      });
    }
  }
  int? totalcount;
  List<Bookings>? bookings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalcount'] = totalcount;
    if (bookings != null) {
      map['bookings'] = bookings?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Bookings {
  Bookings({
    this.bookingid,
    this.bookingstatusid,
    this.bookingstatus,
    this.bookingno,
    this.totalamount,
    this.bookingdatetime,
    this.pickupaddress,
    this.dropaddress,
    this.carriertravelid,
    this.bookingotp
  });

  Bookings.fromJson(dynamic json) {
    bookingid = json['bookingid'];
    bookingstatusid = json['bookingstatusid'];
    bookingstatus = json['bookingstatus'];
    bookingno = json['bookingno'];
    totalamount = json['totalamount'].toString();
    bookingdatetime = json['bookingdatetime'];
    pickupaddress = json['pickupaddress'];
    dropaddress = json['dropaddress'];
    carriertravelid = json['carriertravelid'];
    bookingotp = json['bookingotp'];
  }
  int? bookingid;
  int? bookingstatusid;
  String? bookingstatus;
  String? bookingno;
  String? totalamount;
  String? bookingdatetime;
  String? pickupaddress;
  String? dropaddress;
  String? bookingotp;
  int? carriertravelid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bookingid'] = bookingid;
    map['bookingstatusid'] = bookingstatusid;
    map['bookingstatus'] = bookingstatus;
    map['bookingno'] = bookingno;
    map['totalamount'] = totalamount;
    map['bookingdatetime'] = bookingdatetime;
    map['pickupaddress'] = pickupaddress;
    map['dropaddress'] = dropaddress;
    map['carriertravelid'] = carriertravelid;
    map['bookingotp'] = bookingotp;
    return map;
  }

}