import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:productivity_app/commons/database.dart';
import 'package:productivity_app/data/models/work_model.dart';

class DetailWorkController extends GetxController {
  bool isLoading = false;
  WorkModel? workModel;
  String title = "";

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() {
    isLoading = true;
    update();
    Future.delayed(new Duration(milliseconds: 300), () {
      isLoading = false;
      workModel = Get.arguments['work'];
      title = Get.arguments['title'];
      update();
    });
  }

  deleteData() async {
    Get.back();
    isLoading = true;
    update();
    try {
      await Database().deleteCollection(workModel!.id).then((value) {
        isLoading = false;
        Get.back(result: true);
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
}
