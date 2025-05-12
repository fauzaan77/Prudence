import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/slider_controller.dart';
import 'package:airshipxp_shipper/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  final SliderController sliderController = Get.put(SliderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: Get.height * 0.7,
                child: PageView(
                  controller: sliderController.pageController,
                  onPageChanged: (value) {
                    sliderController.pageNumber.value = value;
                  },
                  children: [
                    const SliderOne(),
                    const SliderTwo(),
                    const SliderThree(),
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
                        Get.offAll(() => const LoginScreen());
                      },
                      label: 'skip'.tr,
                      color: black,
                    ),
                    TextButtonPrimary(
                        onPressed: () {
                          if (sliderController.pageController.page == 2) {
                            Get.offAll(() => const LoginScreen());
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

class SliderOne extends StatelessWidget {
  const SliderOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(
        'assets/images/slider1.png',
        height: 250,
        fit: BoxFit.contain,
      ),
      Text(
        'slider1Heading'.tr,
        textAlign: TextAlign.center,
        style: kText30w500.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          'sliderDescription'.tr,
          textAlign: TextAlign.center,
          style: kText22w600.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    ]);
  }
}

class SliderTwo extends StatelessWidget {
  const SliderTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/slider2.png',
          height: 250,
          fit: BoxFit.contain,
        ),
        Text(
          'slider2Heading'.tr,
          style: kText30w500.copyWith(fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'sliderDescription'.tr,
            textAlign: TextAlign.center,
            style: kText22w600.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}

class SliderThree extends StatelessWidget {
  const SliderThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/slider3.png',
          height: 250,
          fit: BoxFit.contain,
        ),
        Text(
          'slider3Heading'.tr,
          style: kText30w500.copyWith(fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'sliderDescription'.tr,
            textAlign: TextAlign.center,
            style: kText22w600.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
