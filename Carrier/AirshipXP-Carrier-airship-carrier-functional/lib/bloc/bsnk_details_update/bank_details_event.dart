import 'dart:io';

abstract class BankDetailsEvent {}

class BankDetailsSubmitEvent extends BankDetailsEvent {
  String? ifsccode;
  String? branchname;
  String? accountno;

  BankDetailsSubmitEvent(
      {
        this.ifsccode,
        this.branchname,
        this.accountno
      });
}