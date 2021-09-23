import 'package:get/get.dart';
import 'package:productivity_app/data/models/chart_model.dart';
import 'package:productivity_app/data/models/weather_model.dart';

class ChartController extends GetxController {
  List<ChartModel> chartModel = [];
  List<WeatherModel> weather = [];
  bool isLoading = false;
  double totalAverage = 0;

  @override
  void onInit() {
    super.onInit();
    chartModel = Get.arguments['chartModel'];
    weather = Get.arguments['weather'];
    totalAverage =
        chartModel.map((e) => e.productivity).reduce((a, b) => a + b) /
            chartModel.length;
  }
}
