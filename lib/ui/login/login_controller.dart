import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:productivity_app/core.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  validateForm() {
    if (loginFormKey.currentState!.validate()) {
      login(emailController.text, passwordController.text);
    }
  }

  void login(String email, String password) async {
    isLoading = true;
    update();
    try {
      await _auth
          .signInWithEmailAndPassword(email: email.trim(), password: password)
          .then((value) {
        if (value.user != null) {
          isLoading = false;
          Get.offNamed(Routes.HOME);
        }
      });
    } on FirebaseException catch (error) {
      isLoading = false;
      update();
      Get.snackbar(
        "Error signing in",
        error.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
