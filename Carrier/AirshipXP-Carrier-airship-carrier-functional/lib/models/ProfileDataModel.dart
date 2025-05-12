class ProfileDataModel {
  ProfileDataModel({
      this.data,});

  ProfileDataModel.fromJson(dynamic json) {
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
  ProfileData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class ProfileData {
  ProfileData({
    this.carrierid,
    this.firstname,
    this.lastname,
    this.countrycode,
    this.phone,
    this.email,
    this.isapproved,
    this.carrierimagename,
    this.carrierimagepath,
    this.licenseno,
    this.licenseexpirydate,
    this.licenceimagename,
    this.licenceimagepath,});

  ProfileData.fromJson(dynamic json) {
    carrierid = json['carrierid'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    countrycode = json['countrycode'];
    phone = json['phone'];
    email = json['email'];
    isapproved = json['isapproved'];
    carrierimagename = json['carrierimagename'];
    carrierimagepath = json['carrierimagepath'];
    licenseno = json['licenseno'];
    licenseexpirydate = json['licenseexpirydate'];
    licenceimagename = json['licenceimagename'];
    licenceimagepath = json['licenceimagepath'];
  }
  int? carrierid;
  String? firstname;
  String? lastname;
  String? countrycode;
  String? phone;
  String? email;
  bool? isapproved;
  String? carrierimagename;
  String? carrierimagepath;
  String? licenseno;
  String? licenseexpirydate;
  String? licenceimagename;
  String? licenceimagepath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['carrierid'] = carrierid;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['countrycode'] = countrycode;
    map['phone'] = phone;
    map['email'] = email;
    map['isapproved'] = isapproved;
    map['carrierimagename'] = carrierimagename;
    map['carrierimagepath'] = carrierimagepath;
    map['licenseno'] = licenseno;
    map['licenseexpirydate'] = licenseexpirydate;
    map['licenceimagename'] = licenceimagename;
    map['licenceimagepath'] = licenceimagepath;
    return map;
  }

}