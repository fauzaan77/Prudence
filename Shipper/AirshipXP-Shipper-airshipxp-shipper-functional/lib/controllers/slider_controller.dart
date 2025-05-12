import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SliderController extends GetxController{
  final PageController pageController = PageController();
  RxInt pageNumber = 0.obs;
}