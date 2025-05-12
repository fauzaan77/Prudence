import 'package:airship_carrier/bloc/tc_agree/tc_agree_bloc.dart';
import 'package:airship_carrier/bloc/tc_agree/tc_agree_event.dart';
import 'package:airship_carrier/bloc/tc_agree/tc_agree_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/controllers/authenticate_controller.dart';
import 'package:airship_carrier/screens/success_account_creation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class TermsAndConditions extends StatelessWidget {
  TermsAndConditions({super.key});

  bool agreeTC = false;
  TCAgreeBloc _tcAgreeBloc = TCAgreeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'termsNConditions'.tr,
        leading: true,
      ),
      body: BlocProvider(
        create: (BuildContext blocPCtx) => _tcAgreeBloc,
        child: BlocListener<TCAgreeBloc, TCAgreeState>(
          listener: (BuildContext blocLisCtx, TCAgreeState state) {},
          child:
              BlocBuilder<TCAgreeBloc, TCAgreeState>(builder: (blocCtx, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: Text(
                      'loremTextBrief'.tr,
                      style: kText18w400.copyWith(color: grey, height: 1.7),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (state is TCAgreeUpdatedState)
                    ListTile(
                      leading: Checkbox(
                        onChanged: (value) {
                          BlocProvider.of<TCAgreeBloc>(blocCtx).add(
                              TCAgreeCheckEvent(
                                  isTCAgree: value ?? false));
                          agreeTC = value??false;
                        },
                        value: state.isAgree,
                      ),
                      title: Text(
                        'iHereby'.tr,
                        style: kText18w400,
                      ),
                      onTap: () {
                        agreeTC = !agreeTC;
                        BlocProvider.of<TCAgreeBloc>(blocCtx).add(
                            TCAgreeCheckEvent(
                                isTCAgree: agreeTC));
                      },
                    ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ButtonPrimary(
                        onPressed: () {
                          if (agreeTC) {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>SuccessAccountCreation()));
                          } else {
                            Get.snackbar('Pls Agree T&C',
                                'Check the box to move ahead...');
                          }
                        },
                        title: 'proceed'.tr),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
