import 'package:get/get.dart';
import 'package:productivity_app/ui/form/form_result/form_result_controller.dart';

class FormResultBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormResultController>(() => FormResultController());
  }
}
