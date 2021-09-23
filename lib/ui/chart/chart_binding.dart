import 'package:get/get.dart';
import 'package:productivity_app/ui/chart/chart_controller.dart';

class ChartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChartController>(() => ChartController());
  }
}
