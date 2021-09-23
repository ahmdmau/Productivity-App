import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:productivity_app/core.dart';
import 'package:productivity_app/data/models/work_model.dart';
import 'package:productivity_app/data/models/work_type_model.dart';
import 'package:uuid/uuid.dart';

class FormDataWorkController extends GetxController {
  final GlobalKey<FormState> workFormKey = GlobalKey<FormState>();
  TextEditingController workNameController = TextEditingController();
  TextEditingController workLocationController = TextEditingController();
  TextEditingController workDurationController = TextEditingController();
  TextEditingController workResultController = TextEditingController();
  TextEditingController workerController = TextEditingController();
  TextEditingController workStartTimeController = TextEditingController();
  TextEditingController workEndTimeController = TextEditingController();
  List<WorkTypeModel> workTypeModel = [];
  List<String> weathers = ["Hujan", "Normal"];
  String? selectedWorkType;
  String? selectedWorkTypeId;
  String? selectedWeather;
  DateTime selectedDate = DateTime.now();
  TimeOfDay? startTime;
  double? startTimeDouble;
  TimeOfDay? endTime;
  double? endTimeDouble;
  String? projectId;
  String unit = "m3";
  static FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    workTypeModel = Get.arguments['workType'];
    projectId = Get.arguments['projectId'];
    update();
  }

  @override
  void onClose() {
    super.onClose();
    workNameController.dispose();
    workLocationController.dispose();
    workDurationController.dispose();
    workResultController.dispose();
    workerController.dispose();
    workStartTimeController.dispose();
    workEndTimeController.dispose();
  }

  void getUnitType() {
    switch (selectedWorkTypeId) {
      case "id1":
        unit = "Kg";
        break;
      case "id2":
        unit = "m3";
        break;
      case "id3":
        unit = "m2";
        break;
      case "id4":
        unit = "m2";
        break;
      case "id5":
        unit = "m2";
        break;
      default:
        unit = "Kg";
        break;
    }

    update();
  }

  validateForm(BuildContext context) {
    if (workFormKey.currentState!.validate()) {
      Get.toNamed(
        Routes.DATA_WORK_RESULT,
        arguments: {
          "workModel": buildWorkModel(context),
          "unit": unit,
        },
      );
    }
  }

  setSelectedStartTime(TimeOfDay selectedTime, BuildContext context) {
    workStartTimeController.text = selectedTime.format(context);
    startTime = selectedTime;
    startTimeDouble = selectedTime.hour + selectedTime.minute / 60.0;
    update();
  }

  setSelectedEndTime(TimeOfDay selectedTime, BuildContext context) {
    workEndTimeController.text = selectedTime.format(context);
    endTime = selectedTime;
    endTimeDouble = selectedTime.hour + selectedTime.minute / 60.0;
    workDurationController.text = "${(endTimeDouble! - startTimeDouble!)}";
    update();
  }

  setSelectedDate(DateTime date) {
    selectedDate = date;
    update();
  }

  setSelectedWorkTypeId(String id) {
    selectedWorkTypeId = id;
  }

  setSelectedWeather(String weather) {
    selectedWeather = weather;
    update();
  }

  setSelectedWorkType(String type) {
    selectedWorkType = type;
    update();
  }

  WorkModel buildWorkModel(BuildContext context) {
    var uuid = Uuid().v4();
    final User user = auth.currentUser!;
    final uid = user.uid;
    final localizations = MaterialLocalizations.of(context);
    final finalStartTime = localizations.formatTimeOfDay(startTime!);
    final finalEndTime = localizations.formatTimeOfDay(endTime!);
    return WorkModel(
      id: uuid,
      workName: workNameController.text,
      workLocation: workLocationController.text,
      workDate: Timestamp.fromMicrosecondsSinceEpoch(
          selectedDate.microsecondsSinceEpoch),
      startTime: finalStartTime,
      endTime: finalEndTime,
      durationTime: (endTimeDouble! - startTimeDouble!),
      totalWorker: int.parse(workerController.text),
      workResult: double.parse(workResultController.text),
      workProductivity: 0,
      note: "",
      idProject: projectId!,
      idTypeWork: selectedWorkTypeId!,
      effective: 0,
      contributory: 0,
      ineffective: 0,
      productivityResult: 0,
      weather: selectedWeather!,
      createdAt: Timestamp.now(),
      userId: uid,
      typeWork: selectedWorkType!,
    );
  }
}
