import 'dart:io';

abstract class SocialSecurityEvent {}

class SocialSecuritySubmitEvent extends SocialSecurityEvent {
  String? securityno;

  SocialSecuritySubmitEvent(
      {
        this.securityno
      });
}