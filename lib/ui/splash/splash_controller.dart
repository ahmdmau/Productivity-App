import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:productivity_app/core.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(
      Duration(seconds: 3),
      () {
        navigateToScreen();
      },
    );
  }

  startTimer() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, navigateToScreen);
  }

  void navigateToScreen() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    var user = _firebaseAuth.currentUser;
    if (user != null) {
      Get.offNamed(Routes.HOME);
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }
}
