import 'dart:convert';

ParcelTypesResponse parcelTypesResponseFromJson(String str) =>
    ParcelTypesResponse.fromJson(json.decode(str));

String parcelTypesResponseToJson(ParcelTypesResponse data) =>
    json.encode(data.toJson());

class ParcelTypesResponse {
  int? status;
  String? message;
  Data? data;

  ParcelTypesResponse({this.status, this.message, this.data});

  ParcelTypesResponse.fromJson(Map<String, dynamic> json) {
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
  List<Parceltypes>? parceltypes;
  dynamic tax;

  Data({this.parceltypes, this.tax});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['parceltypes'] != null) {
      parceltypes = <Parceltypes>[];
      json['parceltypes'].forEach((v) {
        parceltypes!.add(new Parceltypes.fromJson(v));
      });
    }
    tax = json['tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.parceltypes != null) {
      data['parceltypes'] = this.parceltypes!.map((v) => v.toJson()).toList();
    }
    data['tax'] = this.tax;
    return data;
  }
}

class Parceltypes {
  int? id;
  String? title;
  String? description;
  List<Sizeslots>? sizeslots;
  List<Weightslots>? weightslots;
  dynamic conveniencefee;

  Parceltypes(
      {this.id,
      this.title,
      this.description,
      this.sizeslots,
      this.weightslots,
      this.conveniencefee});

  Parceltypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    if (json['sizeslots'] != null) {
      sizeslots = <Sizeslots>[];
      json['sizeslots'].forEach((v) {
        sizeslots!.add(new Sizeslots.fromJson(v));
      });
    }
    if (json['weightslots'] != null) {
      weightslots = <Weightslots>[];
      json['weightslots'].forEach((v) {
        weightslots!.add(new Weightslots.fromJson(v));
      });
    }
    conveniencefee = json['conveniencefee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.sizeslots != null) {
      data['sizeslots'] = this.sizeslots!.map((v) => v.toJson()).toList();
    }
    if (this.weightslots != null) {
      data['weightslots'] = this.weightslots!.map((v) => v.toJson()).toList();
    }
    data['conveniencefee'] = this.conveniencefee;
    return data;
  }
}

class Sizeslots {
  String? title;
  String? description;

  Sizeslots({this.title, this.description});

  Sizeslots.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

class Weightslots {
  dynamic baserate;
  dynamic lowerlimit;
  dynamic upperlimit;

  Weightslots({this.baserate, this.lowerlimit, this.upperlimit});

  Weightslots.fromJson(Map<String, dynamic> json) {
    baserate = json['baserate'];
    lowerlimit = json['lowerlimit'];
    upperlimit = json['upperlimit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baserate'] = this.baserate;
    data['lowerlimit'] = this.lowerlimit;
    data['upperlimit'] = this.upperlimit;
    return data;
  }
}
