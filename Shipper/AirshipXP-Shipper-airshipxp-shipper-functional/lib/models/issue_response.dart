import 'dart:convert';

IssueResponse issueResponseFromJson(String str) =>
    IssueResponse.fromJson(json.decode(str));

String issueResponseToJson(IssueResponse data) => json.encode(data.toJson());

class IssueResponse {
  int? status;
  String? message;
  Data? data;

  IssueResponse({this.status, this.message, this.data});

  IssueResponse.fromJson(Map<String, dynamic> json) {
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
  String? ticket;
  String? issuetitle;
  String? issuedesc;
  dynamic response;
  String? issuestatus;
  String? issuedate;
  dynamic responsedate;

  Details(
      {this.id,
      this.ticket,
      this.issuetitle,
      this.issuedesc,
      this.response,
      this.issuestatus,
      this.issuedate,
      this.responsedate});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticket = json['ticket'];
    issuetitle = json['issuetitle'];
    issuedesc = json['issuedesc'];
    response = json['response'];
    issuestatus = json['issuestatus'];
    issuedate = json['issuedate'];
    responsedate = json['responsedate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket'] = this.ticket;
    data['issuetitle'] = this.issuetitle;
    data['issuedesc'] = this.issuedesc;
    data['response'] = this.response;
    data['issuestatus'] = this.issuestatus;
    data['issuedate'] = this.issuedate;
    data['responsedate'] = this.responsedate;
    return data;
  }
}
