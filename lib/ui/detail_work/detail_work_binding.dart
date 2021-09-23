import 'package:get/get.dart';
import 'package:productivity_app/ui/detail_work/detail_work_controller.dart';

class DetailWorkBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailWorkController>(() => DetailWorkController());
  }
}
