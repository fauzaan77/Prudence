abstract class CreatePersonalInfoEvent {}

class AddPersonalInfoEvent extends CreatePersonalInfoEvent {
  String? firstname;
  String? lastname;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? address;
  String? password;

  AddPersonalInfoEvent(
      {
      this.firstname,
      this.lastname,
      this.email,
      this.countryCode,
      this.phoneNumber,
      this.address,
      this.password
      });
}

class SaveValuePersonalInfoEvent extends CreatePersonalInfoEvent {
  String? countryCode;
  bool isPasswordShow;
  bool isConfirmPasswordShow;
  SaveValuePersonalInfoEvent(
      {
      this.countryCode,
        this.isConfirmPasswordShow = true,
        this.isPasswordShow = true
      });
}
