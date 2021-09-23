import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:productivity_app/constants/colors.dart';
import 'package:productivity_app/ui/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: SafeArea(
            child: Center(
              child: Container(
                child: SvgPicture.asset('assets/icon/ic_logo.svg'),
              ),
            ),
          ),
        );
      },
    );
  }
}
