import 'dart:convert';

RegistrationResponse registrationResponseFromJson(String str) =>
    RegistrationResponse.fromJson(json.decode(str));

String registrationResponseToJson(RegistrationResponse data) =>
    json.encode(data.toJson());

class RegistrationResponse {
  int? status;
  String? message;
  Data? data;

  RegistrationResponse({this.status, this.message, this.data});

  RegistrationResponse.fromJson(Map<String, dynamic> json) {
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
  int? shipperid;
  String? firstname;
  String? lastname;
  String? countrycode;
  String? phone;
  String? email;
  String? imagename;
  String? imagepath;
  Role? role;
  String? token;

  Data(
      {this.shipperid,
      this.firstname,
      this.lastname,
      this.countrycode,
      this.phone,
      this.email,
      this.imagename,
      this.imagepath,
      this.role,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    shipperid = json['shipperid'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    countrycode = json['countrycode'];
    phone = json['phone'];
    email = json['email'];
    imagename = json['imagename'];
    imagepath = json['imagepath'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shipperid'] = this.shipperid;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['countrycode'] = this.countrycode;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['imagename'] = this.imagename;
    data['imagepath'] = this.imagepath;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Role {
  int? roleid;
  String? rolename;

  Role({this.roleid, this.rolename});

  Role.fromJson(Map<String, dynamic> json) {
    roleid = json['roleid'];
    rolename = json['rolename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleid'] = this.roleid;
    data['rolename'] = this.rolename;
    return data;
  }
}
