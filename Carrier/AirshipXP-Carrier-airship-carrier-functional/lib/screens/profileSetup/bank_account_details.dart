import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_bloc.dart';
import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_event.dart';
import 'package:airship_carrier/bloc/bsnk_details_update/bank_details_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/controllers/personal_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class BankAccountDetails extends StatelessWidget {
  BankAccountDetails({super.key});

  // final PersonalDetailController personalDetailController = Get.find();

  BankDetailsBloc _bankDetailsBloc = BankDetailsBloc();
  TextEditingController accountController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController branchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'enterBank'.tr,
        leading: true,
        flex: true,
      ),
      body: BlocProvider(
        create: (BuildContext blckProviderCtx) =>_bankDetailsBloc,
        child: BlocListener<BankDetailsBloc,BankDetailsState>(
          listener: (BuildContext context, BankDetailsState state) {
            if (state is BankDetailsErrorState) {
              print("HERE 00");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message??""),
                ),
              );
            } if (state is BankDetailsUpdatedState) {
              Navigator.pop(context,true);
            }
          },
          child: BlocBuilder<BankDetailsBloc,BankDetailsState>(
            builder: (blocContext,state) {
              return Stack(
                children: [
                  bankDetailsUI(context,blocContext),
                  if(state is BankDetailsLoadingState)
                    const Center(child: CircularProgressIndicator())
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  Widget bankDetailsUI(BuildContext context, BuildContext blocContext) {
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
                    controller: ifscController,
                    onValueChange: (value) {},
                    placeHolder: 'ifsc'.tr,
                  ),
                  Seperator(),
                  TextInputBox(
                    outlineBorder: true,
                    borderColor: greyOp2,
                    controller: branchController,
                    onValueChange: (value) {},
                    placeHolder: 'branch'.tr,
                  ),
                  Seperator(),
                  TextInputBox(
                    outlineBorder: true,
                    borderColor: greyOp2,
                    controller: accountController,
                    onValueChange: (value) {},
                    placeHolder: 'accountNumber'.tr,
                  ),
                  Seperator()
                ],
              ),
            ),
            ButtonPrimary(
              onPressed: () {
                BlocProvider.of<BankDetailsBloc>(blocContext).add(
                    BankDetailsSubmitEvent(
                        accountno: accountController.text,
                    branchname: branchController.text,
                    ifsccode: ifscController.text));
                // personalDetailController.bankDetails.value = true;
                // Get.back();
              },
              title: 'done'.tr,
            ),
          ]),
        ),
      ),
    );
  }
}
