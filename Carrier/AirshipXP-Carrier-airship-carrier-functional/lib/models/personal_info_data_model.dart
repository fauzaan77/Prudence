class PersonalInfoDataModel {
  PersonalInfoDataModel({
    this.carrierid,
    this.firstname,
    this.lastname,
    this.countrycode,
    this.phone,
    this.email,
    this.imagepath,
    this.role,
    this.onduty,
    this.isapproved,
    this.isdocumentsubmitted,
    this.isdocumentverified,
    this.token,});

  PersonalInfoDataModel.fromJson(dynamic json) {
    carrierid = json['carrierid'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    countrycode = json['countrycode'];
    phone = json['phone'];
    email = json['email'];
    imagepath = json['imagepath'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    onduty = json['onduty'];
    isapproved = json['isapproved'];
    isdocumentsubmitted = json['isdocumentsubmitted'];
    isdocumentverified = json['isdocumentverified'];
    token = json['token'];
  }
  int? carrierid;
  String? firstname;
  String? lastname;
  String? countrycode;
  String? phone;
  String? email;
  String? imagepath;
  Role? role;
  bool? onduty;
  bool? isapproved;
  bool? isdocumentsubmitted;
  bool? isdocumentverified;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['carrierid'] = carrierid;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['countrycode'] = countrycode;
    map['phone'] = phone;
    map['email'] = email;
    map['imagepath'] = imagepath;
    if (role != null) {
      map['role'] = role?.toJson();
    }
    map['onduty'] = onduty;
    map['isapproved'] = isapproved;
    map['isdocumentsubmitted'] = isdocumentsubmitted;
    map['isdocumentverified'] = isdocumentverified;
    map['token'] = token;
    return map;
  }

}

class Role {
  Role({
    this.roleid,
    this.rolename,});

  Role.fromJson(dynamic json) {
    roleid = json['roleid'];
    rolename = json['rolename'];
  }
  int? roleid;
  String? rolename;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roleid'] = roleid;
    map['rolename'] = rolename;
    return map;
  }

}