import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productivity_app/constants/colors.dart';

import 'package:productivity_app/helpers/app_bar_custom.dart';
import 'package:productivity_app/helpers/custom_button.dart';
import 'package:productivity_app/helpers/loading.dart';
import 'package:productivity_app/ui/recapitulation/recapitulation_controller.dart';

class RecapitulationPage extends GetView<RecapitulationController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecapitulationController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBarCustom(title: "Rekapitulasi Pekerjaan"),
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        CustomButton.primaryButton(
                          onClick: () {
                            // controller.validateForm(context);
                            controller.prepareDataLUR();
                          },
                          text: "Lihat LUR",
                          textColor: kPrimaryColor,
                          backgroundColor: Colors.white,
                          borderRadius: 10.0,
                          height: 52.0,
                          fontSize: 16.0,
                          borderSideColor: kPrimaryColor,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        CustomButton.primaryButton(
                          onClick: () {
                            controller.prepareGraphData();
                          },
                          text: "Lihat Grafik",
                          textColor: kPrimaryColor,
                          backgroundColor: Colors.white,
                          borderRadius: 10.0,
                          height: 52.0,
                          fontSize: 16.0,
                          borderSideColor: kPrimaryColor,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.workModel.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 5, right: 5),
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
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Nama Pekerjaan:"),
                                      Text(
                                        controller.workModel[index].workName,
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
                                        controller
                                            .workModel[index].workLocation,
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
                                        controller.workModel[index].startTime,
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
                                        controller.workModel[index].endTime,
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
                                        "${(controller.workModel[index].durationTime * 60).toStringAsFixed(0)} Menit",
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
                                        "${(controller.workModel[index].totalWorker)} Orang",
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
                                        "${controller.workModel[index].workResult}",
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
                                        controller.workModel[index].weather,
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
                                        "${(controller.workModel[index].productivityResult).toStringAsFixed(2)}",
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
                                        "${(controller.workModel[index].effective)} orang",
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
                                        "${(controller.workModel[index].contributory)} orang",
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
                                        "${(controller.workModel[index].ineffective)} orang",
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
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
