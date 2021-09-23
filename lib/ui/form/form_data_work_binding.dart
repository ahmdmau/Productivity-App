import 'package:get/get.dart';
import 'package:productivity_app/ui/form/form_data_work_controller.dart';

class FormDataWorkBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormDataWorkController>(() => FormDataWorkController());
  }
}
