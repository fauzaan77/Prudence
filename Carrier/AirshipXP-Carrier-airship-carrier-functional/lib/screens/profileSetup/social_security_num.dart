import 'package:airship_carrier/bloc/social_security_code/social_security_bloc.dart';
import 'package:airship_carrier/bloc/social_security_code/social_security_event.dart';
import 'package:airship_carrier/bloc/social_security_code/social_security_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/controllers/personal_details_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SocialSecurityNum extends StatelessWidget {
  SocialSecurityNum({super.key});

  // final PersonalDetailController personalDetailController = Get.find();
  SecurityBloc _securityBloc = SecurityBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'socialSecurityNumber'.tr,
        leading: true,
      ),
      body: BlocProvider(
        create: (BuildContext blocProviderCtx) => _securityBloc,
        child:  BlocListener<SecurityBloc,SecurityState>(
          listener: (BuildContext context, SecurityState state) {
            if (state is SecurityErrorState) {
              print("HERE 00");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message??""),
                ),
              );
            } if (state is SecurityUpdatedState) {
              Navigator.pop(context,true);
            }
          },
          child: BlocBuilder<SecurityBloc,SecurityState>(
            builder: (blocContext,state) {
              return Stack(
                children: [
                  securityUI(context,blocContext),
                  if(state is SecurityLoadingState)
                    const Center(child: CircularProgressIndicator())
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  TextEditingController _socialNumController = TextEditingController();
  Widget securityUI(BuildContext context, BuildContext blocContext) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            SizedBox(
              height: Get.height * 0.6,
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  TextInputBox(
                    outlineBorder: true,
                    borderColor: greyOp2,
                    controller: _socialNumController,
                    onValueChange: (value) {},
                    placeHolder: 'socialSecurityNumber'.tr,
                  ),
                ],
              ),
            ),
            ButtonPrimary(
              onPressed: () {
                BlocProvider.of<SecurityBloc>(blocContext).add(
                    SocialSecuritySubmitEvent(
                        securityno: _socialNumController.text));
              },
              title: 'done'.tr,
            ),
          ]),
        ),
      ),
    );
  }
}
