import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:productivity_app/commons/database.dart';
import 'package:productivity_app/data/models/user_model.dart';
import 'package:productivity_app/helpers/gravatar.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController workController = TextEditingController();
  bool isLoading = false;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    workController.dispose();
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      createUser();
    }
  }

  // Create User
  createUser() async {
    isLoading = true;
    update();
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then(
        (value) async {
          emailController.clear();
          passwordController.clear();
          Gravatar gravatar = Gravatar(emailController.text);
          String gravatarUrl = gravatar.imageUrl(
            size: 200,
            defaultImage: GravatarImage.retro,
            rating: GravatarRating.pg,
            fileExtension: true,
          );
          //create the new user object
          UserModel _newUser = UserModel(
            uid: value.user!.uid,
            email: value.user!.email!,
            name: nameController.text,
            photoUrl: gravatarUrl,
            occupation: workController.text,
          );
          //create the user in firestore
          if (await Database().createNewUser(_newUser, value.user!)) {
            isLoading = false;
            update();
            Get.offNamed('/home');
          }
        },
      );
    } on FirebaseAuthException catch (error) {
      isLoading = false;
      update();
      Get.snackbar('Sign Up Failed.', error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }
}
