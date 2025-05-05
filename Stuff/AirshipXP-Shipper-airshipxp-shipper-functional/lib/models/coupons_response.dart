import 'dart:convert';

CouponsResponse couponsResponseFromJson(String str) =>
    CouponsResponse.fromJson(json.decode(str));

String couponsResponseToJson(CouponsResponse data) =>
    json.encode(data.toJson());

class CouponsResponse {
  int? status;
  String? message;
  Data? data;

  CouponsResponse({this.status, this.message, this.data});

  CouponsResponse.fromJson(Map<String, dynamic> json) {
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
  List<Coupons>? coupons;

  Data({this.coupons});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(new Coupons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coupons != null) {
      data['coupons'] = this.coupons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupons {
  int? id;
  String? title;
  String? validityrangestart;
  String? validityrangeend;
  String? discounttype;
  dynamic couponvalue;
  String? coupondesc;
  dynamic imagepath;

  Coupons(
      {this.id,
      this.title,
      this.validityrangestart,
      this.validityrangeend,
      this.discounttype,
      this.couponvalue,
      this.coupondesc,
      this.imagepath});

  Coupons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    validityrangestart = json['validityrangestart'];
    validityrangeend = json['validityrangeend'];
    discounttype = json['discounttype'];
    couponvalue = json['couponvalue'];
    coupondesc = json['coupondesc'];
    imagepath = json['imagepath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['validityrangestart'] = this.validityrangestart;
    data['validityrangeend'] = this.validityrangeend;
    data['discounttype'] = this.discounttype;
    data['couponvalue'] = this.couponvalue;
    data['coupondesc'] = this.coupondesc;
    data['imagepath'] = this.imagepath;
    return data;
  }
}
