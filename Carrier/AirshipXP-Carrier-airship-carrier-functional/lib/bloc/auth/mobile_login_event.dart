abstract class MobileLoginEventA {}

class SendOtpEvent extends MobileLoginEventA {
  String? mobileNumber;
  String? countryCode;

  SendOtpEvent(
      {
        this.mobileNumber,
        this.countryCode
      });
}
class SendEmailOtpEvent extends MobileLoginEventA {
  String email;
  String password;

  SendEmailOtpEvent(
      {
        required this.email,
        required this.password
      });
}

class MobileLoginChangeEvent extends MobileLoginEventA {
  bool isEmail;
  String countryCode;
  MobileLoginChangeEvent({this.isEmail = false,this.countryCode="IN"});
}

// class CountryChangeEvent extends MobileLoginEventA {
//   String countryCode;
//   CountryChangeEvent({this.countryCode = ""});
// }
