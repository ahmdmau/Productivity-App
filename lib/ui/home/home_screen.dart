import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productivity_app/constants/colors.dart';
import 'package:productivity_app/core.dart';
import 'package:productivity_app/data/models/project_model.dart';
import 'package:productivity_app/helpers/custom_button.dart';
import 'package:productivity_app/helpers/loading.dart';
import 'package:productivity_app/helpers/search_box.dart';
import 'package:productivity_app/ui/components/no_data_widget.dart';
import 'package:productivity_app/ui/components/project_item_widget.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.bottomSheet(
                Wrap(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tambah Proyek",
                              style: GoogleFonts.montserrat(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: controller.projectNameController,
                              style: GoogleFonts.montserrat(
                                fontSize: 14.0,
                                color: kPrimaryTextColor,
                              ),
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Nama Proyek",
                                hintText: "Nama Proyek",
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextField(
                              controller: controller.projectLocationController,
                              style: GoogleFonts.montserrat(
                                fontSize: 14.0,
                                color: kPrimaryTextColor,
                              ),
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Lokasi Proyek",
                                hintText: "Lokasi Proyek",
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            CustomButton.primaryButton(
                              onClick: () {
                                controller.addProject(
                                  controller.createProjectModel(
                                    controller.projectNameController.text,
                                    controller.projectLocationController.text,
                                  ),
                                );
                              },
                              text: "Tambah Proyek",
                              textColor: kAccentTextColor,
                              backgroundColor: kPrimaryColor,
                              borderRadius: 10.0,
                              height: 52.0,
                              fontSize: 16.0,
                              borderSideColor: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                ignoreSafeArea: false,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
              );
            },
            backgroundColor: kPrimaryColor,
            child: Icon(Icons.add),
          ),
          body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.userModel == null
                                      ? ""
                                      : controller.userModel!.name,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  controller.userModel == null
                                      ? ""
                                      : controller.userModel!.occupation,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.signOut();
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  color: Colors.white,
                                ),
                                child: controller.userModel == null
                                    ? Icon(
                                        Icons.person,
                                        color: kPrimaryColor,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            controller.userModel!.photoUrl),
                                        radius: 25),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: SearchBox(
                          onChanged: (text) {},
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: 30,
                            right: 20,
                            bottom: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Proyek Anda",
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  color: kPrimaryTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: controller.projectModel.length > 0
                                      ? ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              controller.projectModel.length,
                                          itemBuilder: (context, index) {
                                            return ProjectItemWidget(
                                              projectModel: controller
                                                  .projectModel[index],
                                              index: index,
                                              onTapItem: () {
                                                Get.toNamed(
                                                  Routes.PROJECT,
                                                  arguments: {
                                                    "projectId": controller
                                                        .projectModel[index].id,
                                                    "projectName": controller
                                                        .projectModel[index]
                                                        .projectName,
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        )
                                      : NoDataWidget(),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                controller.isLoading ? LoadingIndicator() : SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
