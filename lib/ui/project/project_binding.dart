import 'package:get/get.dart';
import 'package:productivity_app/ui/project/project_controller.dart';

class ProjectBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectController>(() => ProjectController());
  }
}
