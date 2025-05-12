class CarrierBookingDetailsModel {
  CarrierBookingDetailsModel({
      this.data,});

  CarrierBookingDetailsModel.fromJson(dynamic json) {
    data = json['data'] != null ? BookingDetailsData.fromJson(json['data']) : null;
  }
  BookingDetailsData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}
class BookingDetailsData {
  BookingDetailsData({
    this.bookingid,
    this.bookingstatusid,
    this.bookingotp,
    this.bookingstatus,
    this.bookingno,
    this.pickupimagepath,
    this.shipper,
    this.shipperphone,
    this.totalamount,
    this.bookingdatetime,
    this.pickupaddress,
    this.dropaddress,
    this.recipientname,
    this.recipientphone,
    this.instruction,
    this.weightslot,
    this.paymenttype,
  });

  BookingDetailsData.fromJson(dynamic json) {
    bookingid = json['bookingid'];
    bookingstatusid = json['bookingstatusid'];
    bookingotp = json['bookingotp'];
    bookingstatus = json['bookingstatus'];
    bookingno = json['bookingno'];
    pickupimagepath = json['pickupimagepath'];
    shipper = json['shipper'];
    shipperphone = json['shipperphone'];
    totalamount = json['totalamount'].toString();
    bookingdatetime = json['bookingdatetime'];
    pickupaddress = json['pickupaddress'];
    dropaddress = json['dropaddress'];
    recipientname = json['recipientname'];
    recipientphone = json['recipientphone'];
    instruction = json['instruction'];
    weightslot = json['weightslot'];
    paymenttype = json['paymenttype'];
  }
  int? bookingid;
  int? bookingstatusid;
  String? bookingotp;
  String? bookingstatus;
  String? bookingno;
  String? pickupimagepath;
  String? shipper;
  String? shipperphone;
  String? totalamount;
  String? bookingdatetime;
  String? pickupaddress;
  String? dropaddress;
  String? recipientname;
  String? recipientphone;
  String? instruction;
  String? weightslot;
  String? paymenttype;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bookingid'] = bookingid;
    map['bookingstatusid'] = bookingstatusid;
    map['bookingotp'] = bookingotp;
    map['bookingstatus'] = bookingstatus;
    map['bookingno'] = bookingno;
    map['pickupimagepath'] = pickupimagepath;
    map['shipper'] = shipper;
    map['shipperphone'] = shipperphone;
    map['totalamount'] = totalamount;
    map['bookingdatetime'] = bookingdatetime;
    map['pickupaddress'] = pickupaddress;
    map['dropaddress'] = dropaddress;
    map['recipientname'] = recipientname;
    map['recipientphone'] = recipientphone;
    map['instruction'] = instruction;
    map['weightslot'] = weightslot;
    map['paymenttype'] = paymenttype;
    return map;
  }

}