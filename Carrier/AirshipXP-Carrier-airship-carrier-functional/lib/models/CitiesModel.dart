class CitiesModel {
  CitiesModel({
      this.status, 
      this.message, 
      this.data,});

  CitiesModel.fromJson(dynamic json) {
    print("STATUS ${json['status']}");
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CityData.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  CityData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Cities {
  Cities({
    this.id,
    this.countrycode,
    this.country,
    this.city,});

  Cities.fromJson(dynamic json) {
    id = json['id'];
    countrycode = json['countrycode'];
    country = json['country'];
    city = json['city'];
  }
  int? id;
  String? countrycode;
  String? country;
  String? city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['countrycode'] = countrycode;
    map['country'] = country;
    map['city'] = city;
    return map;
  }

}


class CityData {
  CityData({
    this.cities,});

  CityData.fromJson(dynamic json) {
    if (json['cities'] != null) {
      cities = [];
      json['cities'].forEach((v) {
        cities?.add(Cities.fromJson(v));
      });
    }
  }
  List<Cities>? cities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cities != null) {
      map['cities'] = cities?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}