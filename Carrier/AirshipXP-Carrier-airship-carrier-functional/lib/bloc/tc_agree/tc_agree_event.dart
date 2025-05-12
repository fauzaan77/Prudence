import 'dart:io';

abstract class TCAgreeEvent {}

class TCAgreeCheckEvent extends TCAgreeEvent {
  bool? isTCAgree;

  TCAgreeCheckEvent(
      {
        this.isTCAgree
      });
}