import 'package:airship_carrier/models/base_response_model.dart';

abstract class TCAgreeState {
  const TCAgreeState();

  @override
  List<Object?> get props => [];
}

class TCAgreeUpdatedState extends TCAgreeState {
  final bool isAgree;
  const TCAgreeUpdatedState(this.isAgree);
}
