class OtpData {
  OtpData({
    this.otp,
  });

  OtpData.fromJson(dynamic json) {
    print("JSON ${json["otp"]} --- $otp");
    otp = json["otp"];
  }

  String? otp;
  String? mobileNumber;
  String? countryCode;
  OtpData.setMobileNumber(this.mobileNumber,this.countryCode);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['otp'] = otp;
    return map;
  }
}
