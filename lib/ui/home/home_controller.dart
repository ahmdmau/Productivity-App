import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:productivity_app/commons/database.dart';
import 'package:productivity_app/core.dart';
import 'package:productivity_app/data/models/project_model.dart';
import 'package:productivity_app/data/models/user_model.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();
  UserModel? userModel;
  bool isLoading = false;
  List<ProjectModel> projectModel = [];
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectLocationController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDataUser();
    getProjectData();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  void signOut() async {
    isLoading = true;
    update();
    try {
      await _auth.signOut().then((value) {
        isLoading = false;
        update();
        Get.offAllNamed(Routes.LOGIN);
      });
    } on FirebaseAuthException catch (error) {
      isLoading = false;
      update();
      Get.snackbar(
        "Error signing out",
        error.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  getDataUser() async {
    isLoading = true;
    update();
    await Database().getUserData(_auth.currentUser!.uid).then((value) {
      isLoading = false;
      userModel = value;
      update();
    });
  }

  getProjectData() async {
    await Database().getProject(_auth.currentUser!.uid).then((value) {
      projectModel = value;
      update();
    });
  }

  addProject(ProjectModel projectModel) async {
    isLoading = true;
    update();
    await Database().createProject(projectModel).then((value) {
      isLoading = false;
      Get.back();
      getProjectData();
    }).catchError((error) {
      isLoading = false;
      update();
      Get.snackbar('Sign Up Failed.', error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    });
  }

  ProjectModel createProjectModel(String projectName, String projectLocation) {
    var uuid = Uuid().v4();
    return ProjectModel(
        id: uuid,
        projectLocation: projectLocation,
        projectName: projectName,
        userId: "");
  }

  Stream<User?> get user => _auth.authStateChanges();

  handleAuthChanged(_firebaseUser) async {
    if (_firebaseUser == null) {
      Get.offNamed('/login');
    } else {
      firestoreUser.bindStream(streamFirestoreUser());
    }
  }

  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return _db
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }
}
