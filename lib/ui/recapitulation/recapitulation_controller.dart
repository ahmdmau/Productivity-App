import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:productivity_app/commons/database.dart';
import 'package:productivity_app/data/models/chart_model.dart';
import 'package:productivity_app/data/models/weather_model.dart';
import 'package:productivity_app/data/models/work_model.dart';
import 'package:productivity_app/routes/app_page.dart';

class RecapitulationController extends GetxController {
  var projectId = "";
  var typeWorkId = "";
  bool isLoading = false;
  List<WorkModel> workModel = [];
  var effective;
  var contributory;
  var ineffective;

  @override
  void onInit() {
    super.onInit();
    projectId = Get.arguments["projectId"];
    typeWorkId = Get.arguments["typeWorkId"];
    getWork(projectId, typeWorkId);
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

  prepareDataLUR() {
    effective = workModel.map((e) => e.effective).reduce((a, b) => a + b);
    contributory = workModel.map((e) => e.contributory).reduce((a, b) => a + b);
    ineffective = workModel.map((e) => e.ineffective).reduce((a, b) => a + b);
    Get.toNamed(
      Routes.WORK_LUR,
      arguments: {
        "effective": effective,
        "contributory": contributory,
        "ineffective": ineffective,
      },
    );
  }

  prepareGraphData() {
    List<ChartModel> chartModel = [];
    List<WeatherModel> weatherGraphicModel = [];
    double resultHujan = 0;
    double resultNormal = 0;

    for (var i = 0; i < workModel.length; i++) {
      var chart = ChartModel(
          productivity: workModel[i].productivityResult,
          count: (i + 1).toDouble());
      chartModel.add(chart);
    }

    var productivityResultNormal =
        workModel.where((element) => element.weather.contains("Normal"));
    if (productivityResultNormal.length > 0) {
      resultNormal = productivityResultNormal
              .map((e) => e.productivityResult)
              .reduce((value, element) => value + element) /
          productivityResultNormal
              .where((element) => element.weather == "Normal")
              .length;
    }
    var productivityResultHujan =
        workModel.where((element) => element.weather.contains("Hujan"));

    if (productivityResultHujan.length > 0) {
      resultHujan = productivityResultHujan
              .map((e) => e.productivityResult)
              .reduce((value, element) => value + element) /
          productivityResultHujan
              .where((element) => element.weather == "Hujan")
              .length;
    }

    weatherGraphicModel
        .add(WeatherModel(weather: "Cuaca Cerah", average: resultNormal));
    weatherGraphicModel
        .add(WeatherModel(weather: "Cuaca Hujan", average: resultHujan));

    Get.toNamed(
      Routes.WORK_CHART,
      arguments: {
        "chartModel": chartModel,
        "weather": weatherGraphicModel,
      },
    );
  }
}
