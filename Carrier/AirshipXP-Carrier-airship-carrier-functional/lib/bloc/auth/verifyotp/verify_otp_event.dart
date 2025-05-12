abstract class VerifyOtpEvent {}

class OtpConfirmEvent extends VerifyOtpEvent {
  String? mobileNumber;
  String? countryCode;
  String? otp;

  OtpConfirmEvent(
      {
        this.mobileNumber,
        this.countryCode,
        this.otp
      });
}
class ResendOtpEvent extends VerifyOtpEvent {
  String? mobileNumber;
  String? countryCode;

  ResendOtpEvent(
      {
        this.mobileNumber,
        this.countryCode
      });
}
class GetProfileData extends VerifyOtpEvent {

}
