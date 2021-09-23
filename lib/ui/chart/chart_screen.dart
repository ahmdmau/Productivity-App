import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productivity_app/constants/colors.dart';
import 'package:productivity_app/data/models/chart_model.dart';
import 'package:productivity_app/data/models/weather_model.dart';
import 'package:productivity_app/helpers/app_bar_custom.dart';
import 'package:productivity_app/helpers/loading.dart';
import 'package:productivity_app/ui/chart/chart_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends GetView<ChartController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBarCustom(
            title: "Grafik",
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        padding: EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [],
                              ),
                              SfCartesianChart(
                                primaryYAxis: NumericAxis(plotBands: <PlotBand>[
                                  PlotBand(
                                      verticalTextPadding: '5%',
                                      horizontalTextPadding: '5%',
                                      verticalTextAlignment: TextAnchor.middle,
                                      horizontalTextAlignment: TextAnchor.start,
                                      text:
                                          "${controller.totalAverage.toStringAsFixed(2)}",
                                      textAngle: 0,
                                      start: controller.totalAverage,
                                      end: controller.totalAverage,
                                      textStyle: TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 16),
                                      borderColor: Colors.red,
                                      borderWidth: 2)
                                ]),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                legend: Legend(
                                    isVisible: true,
                                    position: LegendPosition.bottom),
                                series: <ChartSeries>[
                                  FastLineSeries<ChartModel, double>(
                                      name: 'Produktivitas',
                                      markerSettings:
                                          MarkerSettings(isVisible: false),
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true),
                                      dataSource: controller.chartModel,
                                      xValueMapper: (ChartModel sales, _) =>
                                          sales.count,
                                      yValueMapper: (ChartModel sales, _) =>
                                          sales.productivity)
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.all(5),
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
                                        Text(
                                          "Rata rata",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "${(controller.totalAverage).toStringAsFixed(2)}%",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                // Chart title
                                title: ChartTitle(
                                    text:
                                        'Perbandingan Produktivitas Pekerjaan Pada Saat Hujan Dan Cerah',
                                    textStyle: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                                // Enable legend
                                legend: Legend(
                                    isVisible: true,
                                    position: LegendPosition.bottom),
                                // Enable tooltip
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <ColumnSeries<WeatherModel, String>>[
                                  ColumnSeries<WeatherModel, String>(
                                      name: 'Rata-Rata Produktivitas',
                                      dataSource: controller.weather,
                                      xValueMapper: (WeatherModel sales, _) =>
                                          sales.weather,
                                      yValueMapper: (WeatherModel sales, _) =>
                                          sales.average,
                                      // Enable data label
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
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
