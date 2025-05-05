import 'dart:convert';

PackageCollectionCenterResponse packageCollectionCenterResponseFromJson(
        String str) =>
    PackageCollectionCenterResponse.fromJson(json.decode(str));

String packageCollectionCenterResponseToJson(
        PackageCollectionCenterResponse data) =>
    json.encode(data.toJson());

class PackageCollectionCenterResponse {
  int? status;
  String? message;
  Data? data;

  PackageCollectionCenterResponse({this.status, this.message, this.data});

  PackageCollectionCenterResponse.fromJson(Map<String, dynamic> json) {
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
  List<CollectionCenters>? collectionCenters;

  Data({this.collectionCenters});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['collectionCenters'] != null) {
      collectionCenters = <CollectionCenters>[];
      json['collectionCenters'].forEach((v) {
        collectionCenters!.add(new CollectionCenters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collectionCenters != null) {
      data['collectionCenters'] =
          this.collectionCenters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollectionCenters {
  int? id;
  String? name;

  CollectionCenters({this.id, this.name});

  CollectionCenters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
