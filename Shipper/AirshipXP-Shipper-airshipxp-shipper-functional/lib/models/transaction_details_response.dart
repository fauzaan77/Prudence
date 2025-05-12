import 'dart:convert';

TransactionDetailsResponse transactionDetailsResponseFromJson(String str) =>
    TransactionDetailsResponse.fromJson(json.decode(str));

String transactionDetailsResponseToJson(TransactionDetailsResponse data) =>
    json.encode(data.toJson());

class TransactionDetailsResponse {
  int? status;
  String? message;
  Data? data;

  TransactionDetailsResponse({this.status, this.message, this.data});

  TransactionDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  List<Details>? details;

  Data({this.totalcount, this.details});

  Data.fromJson(Map<String, dynamic> json) {
    totalcount = json['totalcount'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalcount'] = this.totalcount;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? id;
  dynamic transactionremark;
  String? transactiontype;
  int? transactionamount;
  String? transactiondate;
  int? balance;
  dynamic transactionid;

  Details(
      {this.id,
      this.transactionremark,
      this.transactiontype,
      this.transactionamount,
      this.transactiondate,
      this.balance,
      this.transactionid});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionremark = json['transactionremark'];
    transactiontype = json['transactiontype'];
    transactionamount = json['transactionamount'];
    transactiondate = json['transactiondate'];
    balance = json['balance'];
    transactionid = json['transactionid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transactionremark'] = this.transactionremark;
    data['transactiontype'] = this.transactiontype;
    data['transactionamount'] = this.transactionamount;
    data['transactiondate'] = this.transactiondate;
    data['balance'] = this.balance;
    data['transactionid'] = this.transactionid;
    return data;
  }
}
