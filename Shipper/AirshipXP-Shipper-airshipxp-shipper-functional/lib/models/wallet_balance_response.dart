import 'dart:convert';

WalletBalanceResponse walletBalanceResponseFromJson(String str) =>
    WalletBalanceResponse.fromJson(json.decode(str));

String walletBalanceResponseToJson(WalletBalanceResponse data) =>
    json.encode(data.toJson());

class WalletBalanceResponse {
  int? status;
  String? message;
  Data? data;

  WalletBalanceResponse({this.status, this.message, this.data});

  WalletBalanceResponse.fromJson(Map<String, dynamic> json) {
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
  dynamic balance;

  Data({this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    return data;
  }
}
