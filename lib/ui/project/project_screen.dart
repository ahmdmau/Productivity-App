import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productivity_app/constants/colors.dart';
import 'package:productivity_app/core.dart';
import 'package:productivity_app/helpers/app_bar_custom.dart';
import 'package:productivity_app/helpers/loading.dart';
import 'package:productivity_app/ui/components/no_data_widget.dart';
import 'package:productivity_app/ui/components/work_item_widget.dart';
import 'package:productivity_app/ui/project/project_controller.dart';

class ProjectPage extends GetView<ProjectController> {
  // final ProjectController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectController>(builder: (controller) {
      return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(size: 22.0, color: Colors.white),
            onOpen: () {},
            onClose: () {},
            visible: controller.dialVisible,
            curve: Curves.bounceIn,
            backgroundColor: kPrimaryColor,
            children: [
              SpeedDialChild(
                child: Icon(Icons.visibility, color: Colors.white),
                backgroundColor: kPrimaryColor,
                onTap: () {
                  Get.toNamed(
                    Routes.WORK_RECAP,
                    arguments: {
                      "projectId": controller.projectId,
                      "typeWorkId": controller.selectedWorkTypeIndex,
                    },
                  );
                },
                label: 'Rekapitulasi Pekerjaan',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                labelBackgroundColor: kPrimaryColor,
              ),
              SpeedDialChild(
                child: Icon(Icons.add, color: Colors.white),
                backgroundColor: kPrimaryColor,
                onTap: () {
                  Get.toNamed(Routes.DATA_WORK, arguments: {
                    "workType": controller.workTypeModel,
                    "projectId": controller.projectId!,
                  });
                },
                label: 'Tambah Pekerjaan',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                labelBackgroundColor: kPrimaryColor,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        backgroundColor: kPrimaryColor,
        appBar: AppBarCustom(
          title: "Pekerjaan ${controller.projectName}",
        ),
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 20),
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.workTypeModel.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.setSelectedWorkType(index);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              left: 20,
                              right:
                                  index == controller.workTypeModel.length - 1
                                      ? 20
                                      : 0,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: index == controller.selectedWorkType
                                  ? Colors.white
                                  : kPrimaryColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: controller.selectedWorkType == index
                                    ? kPrimaryColor
                                    : Colors.white,
                              ),
                            ),
                            child: Text(
                              controller.workTypeModel[index].type,
                              style: GoogleFonts.montserrat(
                                color: index == controller.selectedWorkType
                                    ? kPrimaryColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: controller.workModel.length > 0
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.workModel.length,
                                itemBuilder: (context, index) {
                                  return WorkItemWidget(
                                    workModel: controller.workModel[index],
                                    index: index,
                                    onTapItem: () async {
                                      controller.navigateToDetail(index);
                                    },
                                  );
                                },
                              )
                            : NoDataWidget(),
                      ),
                    ),
                  ),
                ],
              ),
              controller.isLoading ? LoadingIndicator() : SizedBox(),
            ],
          ),
        ),
      );
    });
  }
}
