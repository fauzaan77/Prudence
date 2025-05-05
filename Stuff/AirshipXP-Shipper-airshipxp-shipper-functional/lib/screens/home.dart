import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
// import 'package:airshipxp_shipper/screens/cityDomestic/package_pickup_address.dart';
import 'package:airshipxp_shipper/screens/international/pickup_city.dart';
import 'package:airshipxp_shipper/screens/raise_issue.dart';
import 'package:airshipxp_shipper/screens/report_issue.dart';
import 'package:airshipxp_shipper/screens/wallet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleText: 'home'.tr,
        style: kText24w600.copyWith(color: black),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
        child: Column(
          children: [
            Container(
              height: Get.height * 0.4,
              width: Get.width,
              child: Image.asset(
                'assets/images/homeBg.png',
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                // physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        splashColor: gradYellow1,
                        onTap: () {
                          Get.to(() => PickupCityScreen());
                        },
                        child: Ink(
                          height: 110,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // gradient: MaterialStateProperty.all(value)
                            gradient: const LinearGradient(
                              colors: [gradYellow2, gradYellow1],
                            ),
                          ),
                          child: Row(children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                'shipInternational'.tr,
                                style: kText18w600,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Image.asset(
                                'assets/images/homeShipParcel.png',
                                height: 100,
                                width: 140,
                                fit: BoxFit.contain,
                              ),
                            )
                          ]),
                        ),
                      ),
                      Seperator(),
                      CustomBox(
                          shadow: true,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          onTap: () {
                            Get.to(() => WalletScreen());
                          },
                          bgColor: creamBg,
                          link: true,
                          child: Row(children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                'quickRecharge'.tr,
                                style: kText18w600,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Image.asset(
                                'assets/images/quickRecharge.png',
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                            )
                          ])),
                      Seperator(),
                      CustomBox(
                          shadow: true,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          onTap: () {
                            Get.to(() => ReportIssue());
                          },
                          bgColor: creamBg,
                          link: true,
                          child: Row(children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                'needHelp'.tr,
                                style: kText18w600,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Image.asset(
                                'assets/images/question.png',
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                            )
                          ])),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Height20 extends StatelessWidget {
  const Height20({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 15,
    );
  }
}

class StackContainer extends StatelessWidget {
  StackContainer({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  String title;
  String image;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: noteBg,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
                  color: greyOp3, blurStyle: BlurStyle.outer, blurRadius: 3),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 5,
                right: 5,
                child: Image.asset(
                  image,
                  height: 75,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 5,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: kText12w300.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// child: ListView(
//           clipBehavior: Clip.none,
//           padding: EdgeInsets.symmetric(horizontal: 15),
//           children: const [
//             Seperator(),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//               height: 200,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 gradient: const LinearGradient(
//                   colors: [primaryBlue, gradBlue],
//                 ),
//               ),
//               child: Row(children: [
//                 Expanded(
//                   child: Text(
//                     'getCustomers'.tr,
//                     style: kText24w600.copyWith(color: white),
//                   ),
//                 ),
//                 Image.asset(
//                   'assets/images/home1.png',
//                   height: 160,
//                   fit: BoxFit.contain,
//                 )
//               ]),
//             ),
//             Height20(),
// GestureDetector(
//   onTap: () {
//     Get.to(() => PickupCityScreen());
//   },
//   child: Container(
//     padding:
//         const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//     height: 110,
//     width: double.infinity,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       gradient: const LinearGradient(
//         colors: [gradYellow2, gradYellow1],
//       ),
//     ),
//     child: Row(children: [
//       Expanded(
//         child: Text(
//           'shipParcel'.tr,
//           style: kText22w600,
//         ),
//       ),
//       Image.asset(
//         'assets/images/homeShipParcel.png',
//         height: 100,
//         fit: BoxFit.contain,
//       )
//     ]),
//   ),
// ),
//             Height20(),
//             Row(
//               children: [
//                 Expanded(
//                   child: StackContainer(
//                     image: 'assets/images/quickRecharge.png',
//                     title: 'quickRecharge'.tr,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: StackContainer(
//                     image: 'assets/images/calculator.png',
//                     title: 'rateCalculator'.tr,
//                   ),
//                 ),
//               ],
//             ),
//             Height20(),
//             Container(
//               height: 150,
//               decoration: BoxDecoration(
//                 color: creamBg,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 children: [
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'needHelp'.tr,
//                           style: kText18w600,
//                         ),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           'raiseTicket'.tr,
//                           style: kText14w400,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Image.asset('assets/images/question.png')
//                 ],
//               ),
//             ),
//             Height20()
//           ],
//         ),

// Positioned(
//   bottom: 20,
//   left: 15,
//   right: 15,
//   child: Container(
//       padding: EdgeInsets.all(20),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: StackContainer(
//                 onTap: () {
//                   Get.to(
//                     () => PackagePickupLoc(
//                       city: true,
//                     ),
//                   );
//                 },
//                 title: 'shipWithinCity'.tr,
//                 image: 'assets/images/shipwithcity.png'),
//           ),
//           SizedBox(
//             width: 15,
//           ),
//           Expanded(
//             child: StackContainer(
//                 onTap: () {
//                   Get.to(
//                     () => PackagePickupLoc(
//                       city: false,
//                     ),
//                   );
//                 },
//                 title: 'shipDomestic'.tr,
//                 image: 'assets/images/shipdomestic.png'),
//           )
//         ],
//       )),
// ),
