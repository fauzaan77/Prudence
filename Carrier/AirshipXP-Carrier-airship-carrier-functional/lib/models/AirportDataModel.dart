class AirportDataModel {
  AirportDataModel({
      this.data,});

  AirportDataModel.fromJson(dynamic json) {
    data = json['airports'] != null ? AirPortData.fromJson(json['airports']) : null;
  }
  AirPortData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['airports'] = data?.toJson();
    }
    return map;
  }

}

class Airports {
  Airports({
    this.id,
    this.name,
    this.city,});

  Airports.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
  }
  int? id;
  String? name;
  String? city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['city'] = city;
    return map;
  }

}

class AirPortData {
  AirPortData({
    this.airports,});

  AirPortData.fromJson(dynamic json) {
    if (json['airports'] != null) {
      airports = [];
      json['airports'].forEach((v) {
        airports?.add(Airports.fromJson(v));
      });
    }
  }
  List<Airports>? airports;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (airports != null) {
      map['airports'] = airports?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}