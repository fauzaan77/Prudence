import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/controllers/slider_controller.dart';
import 'package:airship_carrier/screens/home_screen.dart';
import 'package:airship_carrier/screens/login_screen.dart';
import 'package:airship_carrier/util/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderScreen extends StatelessWidget {
  SliderScreen({super.key});

  final SliderController sliderController = Get.put(SliderController());
  final SessionManager sessionManager = SessionManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                child: PageView(
                  controller: sliderController.pageController,
                  onPageChanged: (value) {
                    sliderController.pageNumber.value = value;
                  },
                  children: [
                    SliderContent(
                      image: 'assets/images/slider1.png',
                      title: 'slider1Heading'.tr,
                      subtitle: 'sliderDescription'.tr,
                    ),
                    SliderContent(
                      image: 'assets/images/slider2.png',
                      title: 'slider2Heading'.tr,
                      subtitle: 'sliderDescription'.tr,
                    ),
                    SliderContent(
                      image: 'assets/images/slider3.png',
                      title: 'slider3Heading'.tr,
                      subtitle: 'sliderDescription'.tr,
                    )
                  ],
                ),
              ),
              SmoothPageIndicator(
                controller: sliderController.pageController,
                count: 3,
                effect: const WormEffect(
                  dotColor: borderGrey,
                  activeDotColor: black,
                  dotWidth: 10,
                  dotHeight: 10,
                ),
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButtonPrimary(
                      onPressed: () {
                        sessionManager.getBool(SessionManager.IS_LOGGED_IN).then((value) {
                          if (value==true){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                          }else{
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                          }
                        }
                        );
                      },
                      label: 'skip'.tr,
                      color: black,
                    ),
                    TextButtonPrimary(
                        onPressed: () {
                          if (sliderController.pageController.page == 2) {
                            sessionManager.getBool(SessionManager.IS_LOGGED_IN).then((value) {
                              if (value==true){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                              }else{
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                              }
                            }
                            );
                          } else {
                            sliderController.pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease);
                          }
                        },
                        color: black,
                        label: sliderController.pageNumber.value == 2
                            ? 'finish'.tr
                            : 'next'.tr),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class SliderContent extends StatelessWidget {
  SliderContent(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image});
  String image;
  String title;
  String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(
        image,
        height: 150,
        fit: BoxFit.contain,
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        title,
        textAlign: TextAlign.center,
        style: kText17w300.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          subtitle,
          textAlign: TextAlign.center,
          style: kText14w400.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    ]);
  }
}