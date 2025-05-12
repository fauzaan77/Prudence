import 'package:airship_carrier/components/common_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ButtonPrimary extends StatelessWidget {
  ButtonPrimary(
      {super.key,
      required this.onPressed,
      required this.title,
      this.bgColor,
      this.style,
      this.height,
      this.foregroundColor,
      this.isTextButton,
      this.borderRadius});

  VoidCallback onPressed;
  String title;
  TextStyle? style;
  BorderRadius? borderRadius;
  double? height;
  Color? bgColor;
  Color? foregroundColor;
  bool? isTextButton;

  @override
  Widget build(BuildContext context) {
    return isTextButton == true
        ? TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(foregroundColor: black),
            child: Text(
              title,
              style: style ?? kText20w500,
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor ?? black,
              foregroundColor: foregroundColor ?? white,
              minimumSize: Size.fromHeight(height ?? 60),
              maximumSize: Size.fromHeight(height ?? 60),
              shape: RoundedRectangleBorder(
                borderRadius:
                    borderRadius ?? BorderRadius.circular(10), // <-- Radius
              ),
            ),
            onPressed: onPressed,
            child: Text(
              title,
              style: style ?? kText20w500,
            ),
          );
  }
}

class AgreedTextWidget extends StatelessWidget {
  AgreedTextWidget({super.key, this.mainTxtcolor, this.linkTxtcolor});

  Color? mainTxtcolor;
  Color? linkTxtcolor;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: kText14w400.copyWith(color: mainTxtcolor, height: 1.5),
        children: [
          TextSpan(
            text: 'termsText1'.tr,
          ),
          TextSpan(
            style: kText14w400.copyWith(
                fontWeight: FontWeight.w500, color: linkTxtcolor),
            text: 'termsText2'.tr,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print('Terms of Services');
              },
          ),
          TextSpan(
            text: 'termsText3'.tr,
          ),
          TextSpan(
              style: kText14w400.copyWith(
                  fontWeight: FontWeight.w500, color: linkTxtcolor),
              text: 'termsText4'.tr,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Privacy Policy');
                }),
          TextSpan(
            text: 'termsText5'.tr,
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {super.key,
      this.titleText,
      this.leading,
      this.action,
      this.style,
      this.leadingIconColor,
      this.bottom,
      this.flex,
      this.titleColor,
      this.isDrawer,
      this.customFlex,
      this.customLeading,
      this.appBarColor,
      this.toolbarHeight});
  bool? leading;
  bool? isDrawer;
  String? titleText;
  List<Widget>? action;
  TextStyle? style;
  Color? leadingIconColor;
  PreferredSizeWidget? bottom;
  double? toolbarHeight;
  Color? appBarColor;
  bool? flex;
  Color? titleColor;
  Widget? customLeading;
  Widget? customFlex;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        toolbarHeight: toolbarHeight,
        backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: appBarColor != null ? false : true,

        leading: flex == true
            ? null
            : leading == true
                ? customLeading ??
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 28,
                        color: leadingIconColor ?? black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    )
                : const SizedBox(),
        actions: action,
        centerTitle: true,
        title: flex == true
            ? null
            : Text(
                textAlign: TextAlign.center,
                '$titleText',
                style: style ??
                    kText18w600.copyWith(color: titleColor ?? black),
              ),
        flexibleSpace: flex == true
            ? customFlex ??
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 28,
                        color: leadingIconColor ?? black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        '$titleText',
                        style: style ??
                            kText18w400.copyWith(color: titleColor ?? black),
                      ),
                    ),
                  ],
                )
            : null,
        bottom: bottom,
      ),
    );
  }
}

class TextInputBox extends StatelessWidget {
  TextInputBox(
      {super.key,
      required this.onValueChange,
      required this.placeHolder,
      this.keyboardType,
      this.typePassword,
      this.onEyePress,
      this.minLine,
      this.maxLine,
      this.obscureText,
      this.hintTextStyle,
      this.valueStyle,
      this.eyeColor,
      this.controller,
      this.isEnabled,
      this.defalutValue,
      this.contentPadding,
      this.isFilled,
      this.fillColor,
      this.prefixIcon,
      this.outlineBorder,
      this.radius,
      this.borderColor,
      this.inputDecoration,
      this.suffix,
      this.suffixIcon,
      this.validationType});

  final Function onValueChange;
  final String placeHolder;
  String? keyboardType;
  bool? typePassword;
  bool? obscureText;
  VoidCallback? onEyePress;
  dynamic hintTextStyle;
  dynamic valueStyle;
  Color? eyeColor;
  TextEditingController? controller;
  String? validationType;
  bool? isEnabled;
  String? defalutValue;
  EdgeInsets? contentPadding;
  bool? isFilled;
  Color? fillColor;
  Icon? prefixIcon;
  Icon? suffixIcon;
  BorderRadius? radius;
  int? minLine;
  int? maxLine;
  Widget? suffix;
  bool? outlineBorder;
  InputDecoration? inputDecoration;
  Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      initialValue: defalutValue,
      onChanged: (value) {
        onValueChange(value);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: obscureText ?? false,
      inputFormatters: [
        if (keyboardType == 'number')
          LengthLimitingTextInputFormatter(10)
        else if (validationType == 'postalCode')
          LengthLimitingTextInputFormatter(6)
      ],
      style: valueStyle ?? kText18w400.copyWith(fontWeight: FontWeight.w300),
      maxLines: maxLine ?? 1,
      minLines: minLine ?? 1,
      keyboardType: keyboardType == 'number'
          ? TextInputType.number
          : keyboardType == 'email'
              ? TextInputType.emailAddress
              : TextInputType.text,
      textAlignVertical: TextAlignVertical.top,
      decoration: inputDecoration ??
          kTextInputDecoration.copyWith(
            isCollapsed: true,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: radius ?? BorderRadius.circular(10)),
            // contentPadding:
            //     contentPadding?? const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            filled: isFilled ?? false,
            fillColor: fillColor ?? white,
            focusedBorder: outlineBorder == true
                ? OutlineInputBorder(
                    borderRadius: radius ?? BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: borderColor ?? inActiveGreyText,
                      width: 1.0,
                    ),
                  )
                : null,
            enabledBorder: outlineBorder == true
                ? OutlineInputBorder(
                    borderRadius: radius ?? BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: borderColor ?? inActiveGrey,
                      width: 1.0,
                    ),
                  )
                : null,
            errorStyle: const TextStyle(color: Colors.red),
            errorBorder: outlineBorder == true
                ? OutlineInputBorder(
                    borderRadius: radius ?? BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  )
                : null,
            focusedErrorBorder: outlineBorder == true
                ? OutlineInputBorder(
                    borderRadius: radius ?? BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  )
                : null,
            errorMaxLines: 2,
            hintText: placeHolder,
            prefixIcon: prefixIcon,
            prefixIconColor: greyOp2,
            hintStyle: hintTextStyle ??
                kText18w400.copyWith(
                    color: inActiveGreyText, fontWeight: FontWeight.w300),
            suffixIcon: typePassword == true
                ? IconButton(
                    splashRadius: 20,
                    onPressed: onEyePress,
                    icon: Icon(
                      obscureText == true
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: eyeColor ?? Colors.grey,
                    ),
                  )
                : suffixIcon,
            suffix: suffix,
          ),
      validator: (value) {
        print("kkkh ${value}");

        if (validationType == 'firstName') {
          if (!RegExp(r"^[A-Za-z]+$").hasMatch(value ?? "")) {
            print("l70");
            return 'Enter a valid first name';
          } else {
            print("hhh ${value}");
            return null;
          }
        } else if (validationType == 'surname') {
          if (!RegExp(r"^[A-Za-z]+$").hasMatch(value ?? "")) {
            return 'Enter a valid surname';
          } else {
            return null;
          }
        } else if (validationType == 'city') {
          if (!RegExp(r"^[A-Za-z]+$").hasMatch(value ?? "")) {
            return 'Enter a valid city';
          } else {
            return null;
          }
        } else if (validationType == 'postalCode') {
          if ((value ?? "").length != 6) {
            return 'Enter a valid postal code';
          } else {
            return null;
          }
        } else if (validationType == 'email') {
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value ?? "")) {
            return 'Enter a valid email';
          } else {
            return null;
          }
        } else if (validationType == 'phoneNumber') {
          if ((value ?? "").length != 10) {
            return 'Enter a valid mobile number';
          } else {
            return null;
          }
        } else if (validationType == 'password') {
          if ((value ?? "").length < 8) {
            return 'Enter a valid password. Password must be of minimum 8 characters.';
          } else {
            return null;
          }
        } else
        // ADDRESS VALIDATIONS
        if (validationType == 'address') {
          if (!RegExp(r"^[A-Za-z0-9'\.\-\s\,]").hasMatch(value ?? "")) {
            print("l70");
            return 'Address is required';
          } else {
            print("hhh ${value}");
            return null;
          }
        }
        // else if (validationType == 'houseNumber') {
        //   if (value == "") {
        //     return 'Enter a valid house number';
        //   } else {
        //     return null;
        //   }
        // } else if (validationType == 'direction') {
        //   if (!RegExp(r"^[A-Za-z]").hasMatch(value ?? "")) {
        //     print("l70");
        //     return 'Please enter directions';
        //   }
        //   else {
        //     print("hhh ${value}");
        //     return null;
        //   }
        // }
        return null;
      },
    );
  }
}

// ignore: must_be_immutable
class ShadowContainer extends StatelessWidget {
  ShadowContainer(
      {super.key,
      required this.child,
      this.padding,
      this.height,
      this.width,
      this.radius,
      this.shadow,
      this.color,
      this.alignment});

  Widget child;
  EdgeInsets? padding;
  double? height;
  double? width;
  Color? color;
  BorderRadius? radius;
  BoxShadow? shadow;
  Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding ?? const EdgeInsets.all(0),
      height: height ?? 100,
      width: width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: radius ??
              const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
          boxShadow: [
            shadow ??
                const BoxShadow(
                  color: greyOp2,
                  blurStyle: BlurStyle.outer,
                  blurRadius: 5,
                ),
          ]),
      child: child,
    );
  }
}

class Seperator extends StatelessWidget {
  const Seperator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
    );
  }
}

class TextButtonPrimary extends StatelessWidget {
  TextButtonPrimary(
      {super.key, required this.onPressed, required this.label, this.color});
  VoidCallback onPressed;
  String label;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: color),
      child: Text(
        label,
        style: kText16w600.copyWith(
            color: color ?? black, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}

class CustomBox extends StatelessWidget {
  CustomBox({
    this.margin,
    this.padding,
    this.borderColor,
    this.height,
    this.width,
    this.bgColor,
    required this.link,
    this.onTap,
    this.alignment,
    this.shadow,
    this.borderRadius,
    this.decoration,
    required this.child,
    this.border,
  });

  Widget child;
  EdgeInsets? margin;
  EdgeInsets? padding;
  Color? borderColor;
  double? height;
  double? width;
  BoxDecoration? decoration;
  BorderRadius? borderRadius;
  Color? bgColor;
  bool link;
  bool? shadow;
  VoidCallback? onTap;
  Alignment? alignment;
  BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        color: bgColor,
        child: InkWell(
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          onTap: link ? onTap : null,
          child: Container(
            alignment: alignment ?? Alignment.centerLeft,
            padding: padding,
            height: height,
            width: width,
            decoration: decoration ??
                BoxDecoration(
                  color: bgColor??Colors.white,
                  boxShadow: shadow == true
                      ? [
                          const BoxShadow(
                              color: greyOp2,
                              blurRadius: 7,
                              blurStyle: BlurStyle.outer)
                        ]
                      : [],
                  border: border ??
                      Border.all(color: borderColor ?? Colors.transparent),
                  borderRadius: borderRadius ?? BorderRadius.circular(10),
                ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  PackageCard({
    super.key,
    required this.id,
    this.bookingNo,
    required this.amount,
    required this.fromDate,
    required this.toDate,
    required this.pickLoc,
    required this.destLoc,
    required this.onTap,
    this.isMypkg,
    this.isShadowed, this.statusId,  this.status,
  });
  String id;
  int? statusId;
  String? bookingNo;
  String? status;
  String amount;
  String fromDate;
  String toDate;
  String pickLoc;
  String destLoc;
  VoidCallback onTap;
  bool? isMypkg;
  bool? isShadowed;

  @override
  Widget build(BuildContext context) {
    return CustomBox(
        padding: EdgeInsets.all(15),
        link: true,
        onTap: onTap,
        shadow: isShadowed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(status!=null)
              Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      border: Border.all(color:
                     statusId == 1? gradYellow1:
                     statusId  == 3? statusGreen:
                     statusId == 7? darkBlue:
                      cherryRed
                      )
                  ),
                  child: Text(
                    status!,
                    style: kText12w300.copyWith(color:
                        statusId == 1? gradYellow1:
                        statusId == 3? statusGreen:
                        statusId == 7? darkBlue: cherryRed,fontSize: 8),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Booking No. $bookingNo',
                  style: kText14w600,
                ),
                Text('\$$amount',
                  style: kText14w600,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text('Booking Date Time : ${DateFormat("yyyy-MM-dd hh:mm a").format(DateTime.parse(fromDate))}',
              style: kText12w300.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Column(
                  children: [
                    Icon(Icons.flight_takeoff),
                    DottedLine(
                      lineLength: 60,
                      direction: Axis.vertical,
                    ),
                    Icon(Icons.flight_land),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pickLoc,
                        style: kText12w300,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        destLoc,
                        style: kText12w300,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

// class MenuCard extends StatelessWidget {
//   MenuCard(
//       {super.key,
//       required this.label,
//       required this.amount,
//       required this.image,
//       this.note});

//   String label;
//   String amount;
//   String image;
//   String? note;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         height: 120,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Row(
//                   children: [
//                     Image.asset(
//                       'assets/images/veg.png',
//                       height: 15,
//                       width: 15,
//                     ),
//                     Container(
//                       child: Text(
//                         'bestSeller'.tr,
//                         style: kText10w400,
//                       ),
//                     )
//                   ],
//                 ),
//                 Text(
//                   label,
//                   style: kText16w600,
//                 ),
//                 Text(
//                   '${'dollar'.tr} $amount',
//                   style: kText14w600.copyWith(
//                       fontWeight: FontWeight.w700, color: primaryRed),
//                 ),
//                 Text(
//                   '$note',
//                   style: kText12w300.copyWith(fontWeight: FontWeight.w400),
//                 )
//               ],
//             ),
//             SizedBox(
//               width: 100,
//               height: 180,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Positioned(
//                     top: 0,
//                     child: Image.asset(
//                       image,
//                       height: 100,
//                       width: 100,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: ButtonPrimary(
//                       onPressed: () {},
//                       title: 'add'.tr,
//                       style: kText16w700,
//                       height: 25,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CodeContainer extends StatelessWidget {
//   CodeContainer({super.key, required this.code, this.color, this.textStyle});
//   String code;
//   Color? color;
//   TextStyle? textStyle;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(
//           5,
//         ),
//         color: white,
//       ),
//       height: 45,
//       width: 150,
//       child: DottedBorder(
//         dashPattern: [4, 3],
//         color: color?? primaryRed,
//         borderType: BorderType.RRect,
//         radius: const Radius.circular(5),
//         child: Center(
//           child: Text(
//             code,
//             style: textStyle?? kText14w500.copyWith(color: primaryRed),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class OffersContainer extends StatelessWidget {
//   OffersContainer(
//       {super.key,
//       required this.code,
//       required this.title,
//       required this.subtitle,
//       required this.image});

//   String code;
//   String title;
//   String subtitle;
//   String image;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 175,
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//           color: offerBg,
//           borderRadius: BorderRadius.circular(25),
//           boxShadow: [
//             const BoxShadow(
//               blurRadius: 10,
//               color: greyOp2,
//               blurStyle: BlurStyle.outer,
//             )
//           ]),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Positioned(
//               top: 10,
//               left: 30,
//               right: 60,
//               bottom: 10,
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CodeContainer(code: code),
//                     Text(
//                       code,
//                       style: kText20w500.copyWith(
//                           color: primaryRed, fontWeight: FontWeight.w600),
//                     ),
//                     Text(
//                       subtitle,
//                       style: kText16w500.copyWith(
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ])),
//           Positioned(
//               top: 10,
//               right: 15,
//               child: Image.asset(
//                 image,
//                 height: 90,
//                 width: 90,
//                 fit: BoxFit.contain,
//               ))
//         ],
//       ),
//     );
//   }
// }

// class ProfileLinkContainer extends StatelessWidget {
//   ProfileLinkContainer(
//       {super.key,
//       required this.icon,
//       required this.title,
//       required this.onTap});

//   String title;
//   IconData icon;
//   VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(10),
//       onTap: onTap,
//       child: SizedBox(
//         height: 60,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 15,
//           ),
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Row(
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.all(8),
//                   decoration: const BoxDecoration(
//                     color: primaryBlueLow,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     icon,
//                     color: primaryRed,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 15,
//                 ),
//                 Text(
//                   title,
//                   style: kText16w500,
//                 ),
//               ],
//             ),
//             const Icon(
//               Icons.arrow_forward_ios_rounded,
//               size: 15,
//             )
//           ]),
//         ),
//       ),
//     );
//   }
// }
