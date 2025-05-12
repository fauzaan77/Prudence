import 'dart:convert';

AllCitiesResponse allCitiesResponseFromJson(String str) =>
    AllCitiesResponse.fromJson(json.decode(str));

String allCitiesResponseToJson(AllCitiesResponse data) =>
    json.encode(data.toJson());

class AllCitiesResponse {
  int? status;
  String? message;
  Data? data;

  AllCitiesResponse({this.status, this.message, this.data});

  AllCitiesResponse.fromJson(Map<String, dynamic> json) {
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
  List<Cities>? cities;

  Data({this.cities});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  int? id;
  String? countrycode;
  String? country;
  String? city;

  Cities({this.id, this.countrycode, this.country, this.city});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countrycode = json['countrycode'];
    country = json['country'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['countrycode'] = this.countrycode;
    data['country'] = this.country;
    data['city'] = this.city;
    return data;
  }
}
