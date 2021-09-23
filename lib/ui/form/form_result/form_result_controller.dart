import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:productivity_app/commons/database.dart';
import 'package:productivity_app/core.dart';
import 'package:productivity_app/data/models/work_model.dart';

class FormResultController extends GetxController {
  final GlobalKey<FormState> workFormKey = GlobalKey<FormState>();
  TextEditingController workProductivityController = TextEditingController();
  TextEditingController directWorkController = TextEditingController();
  TextEditingController prepareMaterialController = TextEditingController();
  TextEditingController unemployedController = TextEditingController();
  WorkModel? workModel;
  double productivityResult = 0;
  bool isLoading = false;
  String unit = "Kg";
  int totalWorker = 0;

  @override
  void onInit() {
    super.onInit();
    workModel = Get.arguments['workModel'];
    unit = Get.arguments['unit'];
    totalWorker = workModel!.totalWorker;
    productivityResult = (workModel!.workResult / workModel!.totalWorker) /
        workModel!.durationTime;
    workProductivityController.text = productivityResult.toStringAsFixed(2);
  }

  @override
  void onClose() {
    super.onClose();
    workProductivityController.dispose();
    directWorkController.dispose();
    prepareMaterialController.dispose();
    unemployedController.dispose();
  }

  validateForm() {
    if (workFormKey.currentState!.validate()) {
      workModel!.effective = int.parse(directWorkController.text);
      workModel!.contributory = int.parse(prepareMaterialController.text);
      workModel!.ineffective = int.parse(unemployedController.text);
      workModel!.productivityResult = productivityResult;
      submitData();
    }
  }

  String? validateWorker(String? value) {
    if (value!.isEmpty) {
      return "Harap isi dengan benar";
    } else if (sumValue() != totalWorker) {
      return "Nilai ini tidak dapat melebihi total pekerja.";
    }

    return null;
  }

  int sumValue() {
    return int.parse(directWorkController.text) +
        int.parse(prepareMaterialController.text) +
        int.parse(unemployedController.text);
  }

  submitData() async {
    isLoading = true;
    update();
    try {
      await Database().addWork(workModel!).then(
        (value) {
          Get.offAllNamed(Routes.HOME);
        },
      );
    } on FirebaseException catch (error) {
      isLoading = false;
      update();
      Get.snackbar('Failed to Add Data', error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }
}
