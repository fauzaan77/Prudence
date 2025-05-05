import 'dart:convert';

AllAirportsResponse allAirportsResponseFromJson(String str) =>
    AllAirportsResponse.fromJson(json.decode(str));

String allAirportsResponseToJson(AllAirportsResponse data) =>
    json.encode(data.toJson());

class AllAirportsResponse {
  int? status;
  String? message;
  Data? data;

  AllAirportsResponse({this.status, this.message, this.data});

  AllAirportsResponse.fromJson(Map<String, dynamic> json) {
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
  List<Airports>? airports;

  Data({this.airports});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['airports'] != null) {
      airports = <Airports>[];
      json['airports'].forEach((v) {
        airports!.add(new Airports.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.airports != null) {
      data['airports'] = this.airports!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Airports {
  int? id;
  String? name;
  String? city;

  Airports({this.id, this.name, this.city});

  Airports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city'] = this.city;
    return data;
  }
}
