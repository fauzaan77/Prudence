import 'package:airship_carrier/bloc/add_personal_info/create_personalInfo_event.dart';
import 'package:airship_carrier/bloc/add_personal_info/create_personal_info_bloc.dart';
import 'package:airship_carrier/bloc/add_personal_info/create_personal_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/models/personal_info_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInformation extends StatelessWidget {
  final GlobalKey<FormState> _personalInfoKey = GlobalKey<FormState>();
  final AddPersonalInfoBloc _addPersonalInfoBloc = AddPersonalInfoBloc();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String? countryCode = "IN";
  String? phoneCode = "+91";
  PersonalInfoDataModel? personalInfoDataModel;
  PersonalInformation({super.key,this.personalInfoDataModel}){
    firstnameController.text = personalInfoDataModel?.firstname??"";
    surnameController.text = personalInfoDataModel?.lastname??"";
    emailController.text = personalInfoDataModel?.email??"";
    phoneNumberController.text = personalInfoDataModel?.phone??"";
    countryCode = personalInfoDataModel?.countrycode;
  }
  bool isPasswordShow = false;
  bool isConfirmPasswordShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        titleText: 'yourPersonalInfo'.tr,
        leading: true,
      ),
      body: BlocProvider(
        create: (_) => _addPersonalInfoBloc..add(SaveValuePersonalInfoEvent(countryCode: "IN")),
        child: BlocListener<AddPersonalInfoBloc, CreatePersonalInfoState>(
          listener: (BuildContext listNerCtx, CreatePersonalInfoState state) {
            if (state is CreatePersonalInfoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message ?? ""),
                ),
              );
            }
            if (state is CreatePersonalInfoRegistered) {
              Navigator.pop(context, state.personalInfoDataModel.carrierid);
            }
            if (state is SaveDataPersonalInfoState) {
              isPasswordShow = state.isPasswordShow ?? false;
              isConfirmPasswordShow = state.isPasswordShow ?? false;
            }
          },
          child: BlocBuilder<AddPersonalInfoBloc, CreatePersonalInfoState>(
              builder: (blocCtx, state) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if(state is SaveDataPersonalInfoState)
                        PersonalInfoFormUI(context, blocCtx,state)
                    ],
                  ),
                  if (state is CreatePersonalInfoLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget PersonalInfoFormUI(BuildContext context, BuildContext blocCtx, SaveDataPersonalInfoState state) {
    return Form(
      key: _personalInfoKey,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight),
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextInputBox(
                      outlineBorder: true,
                      validationType: 'firstName',
                      controller: firstnameController,
                      onValueChange: (value) {},
                      placeHolder: 'firstname'.tr,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextInputBox(
                      outlineBorder: true,
                      validationType: 'surname',
                      controller: surnameController,
                      onValueChange: (value) {},
                      placeHolder: 'surname'.tr,
                    ),
                  ),
                ],
              ),
              Seperator(),
              TextInputBox(
                outlineBorder: true,
                validationType: 'email',
                controller: emailController,
                onValueChange: (value) {},
                placeHolder: 'email'.tr,
                keyboardType: 'email',
              ),
              Seperator(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBox(
                    height: 64,
                    width: 60,
                    alignment: Alignment.center,
                    borderColor: greyOp2,
                    onTap: () {
                      showCountryPicker(
                          context: context,
                          onSelect: (value) {
                            phoneCode = value.phoneCode;
                            BlocProvider.of<AddPersonalInfoBloc>(blocCtx).add(
                                SaveValuePersonalInfoEvent(
                                    countryCode: value.countryCode));
                            countryCode = value.countryCode;
                          });
                    },
                    link: true,
                    child: CountryFlag.fromCountryCode(
                      state.countryCode ??"IN",
                      height: 35,
                      width: 35,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextInputBox(
                      outlineBorder: true,
                      radius: BorderRadius.circular(10),
                      controller: phoneNumberController,
                      onValueChange: (value) {},
                      placeHolder: 'phone'.tr,
                      validationType: 'phoneNumber',
                      keyboardType: 'number',
                    ),
                  ),
                ],
              ),
              Seperator(),
              TextInputBox(
                outlineBorder: true,
                validationType: 'address',
                controller: addressController,
                onValueChange: (value) {},
                placeHolder: 'address'.tr,
              ),
              Seperator(),
              TextInputBox(
                outlineBorder: true,
                validationType: 'password',
                controller: passwordController,
                onValueChange: (value) {},
                placeHolder: 'password'.tr,
                typePassword: true,
                obscureText: state.isPasswordShow,
                onEyePress: () {
                  BlocProvider.of<AddPersonalInfoBloc>(blocCtx).add(
                      SaveValuePersonalInfoEvent(
                          countryCode: countryCode,isPasswordShow: !state.isPasswordShow,isConfirmPasswordShow: state.isConfirmPasswordShow));
                },
              ),
              Seperator(),
              TextInputBox(
                outlineBorder: true,
                validationType: 'password',
                controller: confirmPasswordController,
                onValueChange: (value) {},
                placeHolder: 'confirmPassword'.tr,
                typePassword: true,
                obscureText: state.isConfirmPasswordShow,
                onEyePress: () {
                  BlocProvider.of<AddPersonalInfoBloc>(blocCtx).add(
                      SaveValuePersonalInfoEvent(
                          countryCode: countryCode,isConfirmPasswordShow: !state.isConfirmPasswordShow,isPasswordShow: state.isPasswordShow));
                },
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              ButtonPrimary(
                onPressed: () {
                  if (_personalInfoKey.currentState!.validate() == true) {
                    if(passwordController.text == confirmPasswordController.text) {
                      BlocProvider.of<AddPersonalInfoBloc>(blocCtx).add(
                          AddPersonalInfoEvent(
                              countryCode: phoneCode,
                              email: emailController.text,
                              address: addressController.text,
                              firstname: firstnameController.text,
                              lastname: surnameController.text,
                              password: passwordController.text,
                              phoneNumber: phoneNumberController.text));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Password and Confirm password not matched!"),
                        ),
                      );
                    }
                  }
                },
                title: 'done'.tr,
              ),
            ]),
      ),
    );
  }
}
