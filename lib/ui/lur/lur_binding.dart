import 'package:get/get.dart';
import 'package:productivity_app/ui/lur/lur_controller.dart';

class LurBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LurController>(() => LurController());
  }
}
