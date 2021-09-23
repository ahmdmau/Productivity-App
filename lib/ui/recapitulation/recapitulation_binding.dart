import 'package:get/get.dart';
import 'package:productivity_app/ui/recapitulation/recapitulation_controller.dart';

class RecapitulationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecapitulationController>(() => RecapitulationController());
  }
}
