import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:productivity_app/commons/database.dart';
import 'package:productivity_app/data/models/work_model.dart';
import 'package:productivity_app/data/models/work_type_model.dart';
import 'package:productivity_app/routes/app_page.dart';

class ProjectController extends GetxController {
  List<String> workTypes = [
    "Pembesian",
    "Pengecoran",
    "Pemasangan Bata",
    "Atap",
    "Plesteran"
  ];
  List<WorkTypeModel> workTypeModel = [];
  List<WorkModel> workModel = [];
  var selectedWorkType = 0;
  var selectedWorkTypeIndex = "";
  bool isLoading = false;
  bool dialVisible = true;
  String? projectId;
  String projectName = "";

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    projectId = Get.arguments['projectId'];
    projectName = Get.arguments['projectName'];
    createWorkTypeModel();
    getWork(projectId!, workTypeModel[0].id);
    selectedWorkTypeIndex = workTypeModel[0].id;
  }

  getWork(String projectID, String typeWorkId) async {
    isLoading = true;
    print(projectId);
    print(typeWorkId);
    update();
    try {
      await Database().getWorkByType(projectID, typeWorkId).then((value) {
        isLoading = false;
        workModel = value;
        update();
      });
    } on FirebaseException catch (e) {
      isLoading = false;
      update();
      Get.snackbar('Error', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  createWorkTypeModel() {
    for (var i = 0; i < workTypes.length; i++) {
      workTypeModel.add(WorkTypeModel(id: "id$i", type: workTypes[i]));
    }

    update();
  }

  void setSelectedWorkType(int index) {
    selectedWorkType = index;
    selectedWorkTypeIndex = workTypeModel[index].id;
    getWork(projectId!, workTypeModel[index].id);
    update();
  }

  navigateToDetail(int index) async {
    var result = await Get.toNamed(
      Routes.WORK_DETAIL,
      arguments: {
        "work": workModel[index],
        "title": workModel[index].workName,
      },
    );
    if (result is bool) {
      getWork(projectId!, selectedWorkTypeIndex);
    }
  }
}
