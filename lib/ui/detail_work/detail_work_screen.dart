import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productivity_app/commons/database.dart';
import 'package:productivity_app/constants/colors.dart';
import 'package:productivity_app/helpers/app_bar_custom.dart';
import 'package:productivity_app/helpers/custom_button.dart';
import 'package:productivity_app/helpers/loading.dart';
import 'package:productivity_app/ui/detail_work/detail_work_controller.dart';

class DetailWorkPage extends GetView<DetailWorkController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailWorkController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBarCustom(title: "Detail Pekerjaan ${controller.title}"),
          body: SafeArea(
            child: Stack(
              children: [
                controller.workModel == null
                    ? SizedBox()
                    : Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: kPrimaryColorShadow,
                              offset: Offset(0, 3),
                              blurRadius: 4,
                              spreadRadius: 1,
                            )
                          ],
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Nama Pekerjaan:"),
                                  Text(
                                    controller.workModel!.workName,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Lokasi"),
                                  Text(
                                    controller.workModel!.workLocation,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Jam Mulai"),
                                  Text(
                                    controller.workModel!.startTime,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Jam Selesai"),
                                  Text(
                                    controller.workModel!.endTime,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Durasi"),
                                  Text(
                                    "${(controller.workModel!.durationTime * 60).toStringAsFixed(0)} Menit",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Jumlah Pekerja"),
                                  Text(
                                    "${(controller.workModel!.totalWorker)} Orang",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Hasil"),
                                  Text(
                                    "${controller.workModel!.workResult}",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Cuaca"),
                                  Text(
                                    controller.workModel!.weather,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Produktivitas"),
                                  Text(
                                    "${(controller.workModel!.productivityResult).toStringAsFixed(2)}",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Effective"),
                                  Text(
                                    "${(controller.workModel!.effective)} orang",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Contributory"),
                                  Text(
                                    "${(controller.workModel!.contributory)} orang",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("InEffective"),
                                  Text(
                                    "${(controller.workModel!.ineffective)} orang",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              CustomButton.primaryButton(
                                onClick: () {
                                  // controller.validateForm(context);
                                  // controller.prepareDataLUR();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                              "Apakah anda yakin ingin menghapus pekerjaan ${controller.workModel!.workName}?"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            FlatButton(
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () async {
                                                controller.deleteData();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                text: "Hapus Pekerjaan",
                                textColor: Colors.red[700],
                                backgroundColor: Colors.white,
                                borderRadius: 10.0,
                                height: 48.0,
                                fontSize: 16.0,
                                borderSideColor: Colors.red[700],
                              ),
                            ],
                          ),
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
