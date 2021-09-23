import 'package:get/get.dart';

class LurController extends GetxController {
  int effective = 0;
  int inEffective = 0;
  int contributory = 0;
  int total = 0;
  double effectiveProposal = 0;
  double effectiveTotal = 0;
  double contributoryProposal = 0;
  double contributoryTotal = 0;
  double ineffectiveProposal = 0;
  double ineffectiveTotal = 0;
  double lur = 0;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    effective = Get.arguments['effective'];
    inEffective = Get.arguments['ineffective'];
    contributory = Get.arguments['contributory'];
    countLur();
  }

  countLur() {
    total = effective + contributory + inEffective;
    effectiveProposal = effective / total * 100;
    effectiveTotal = effectiveProposal;

    contributoryProposal = contributory / total * 100;
    contributoryTotal = effectiveProposal + contributoryProposal;

    ineffectiveProposal = inEffective / total * 100;
    ineffectiveTotal =
        effectiveProposal + contributoryProposal + ineffectiveProposal;

    lur = ((effectiveProposal + (0.25 * contributoryProposal)) / 100) * 100;
    update();
  }
}
