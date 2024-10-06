import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../global/app_text_style.dart';
import '../../controllers/dashboard_controller.dart';

class LinerChart extends StatelessWidget {
  const LinerChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.put(DashboardController());

    return Obx(() {
      final test = dashboardController.test.value;
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 6,
            minY: 0,
            maxY: dashboardController
                .getMaxY(), // Assuming this calculates the maximum Y value dynamically
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                // tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    final index = spot.spotIndex;
                    final day = DateFormat('EEEE')
                        .format(dashboardController.dailyOrder[index].date);
                    return LineTooltipItem(
                      '$day\n',
                      GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: dashboardController.dailyOrder[index].count
                              .toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    );
                  }).toList();
                },
              ),
              touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                if (!event.isInterestedForInteractions ||
                    response == null ||
                    response.lineBarSpots == null) {
                  dashboardController.touchedIndex.value = -1;
                } else {
                  dashboardController.touchedIndex.value =
                      response.lineBarSpots![0].spotIndex;
                }
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final day = DateFormat('EEE')
                        .format(dashboardController.dailyOrder[value.toInt()].date);
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 5.h), // Add space between chart and bottom title
                      child: AppTextStyle(
                        text: day,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                  interval: 1, // Ensure each step is a new day
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) => Padding(
                    padding: EdgeInsets.only(
                        right: 15.w), // Add space between chart and left titles
                    child: AppTextStyle(
                      text: value.toInt().toString(),
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  reservedSize: 40.sp,
                ),
              ),
            ),

            gridData: const FlGridData(show: false),
            borderData: FlBorderData(
              show: false,
            ),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  dashboardController.dailyOrder.length,
                      (index) => FlSpot(index.toDouble(),
                      dashboardController.dailyOrder[index].count.toDouble()),
                ),
                isCurved: false,
                color: const Color(0xFf3c096c),
                barWidth: 2.w,
                belowBarData: BarAreaData(
                  show: true,
                  // color: lineColor?.withOpacity(0.3) ??
                  //     Colors.cyanAccent.withOpacity(0.3),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF652f90),
                      Color(0xFF9556c8),
                      Color(0xFFc5a3e1),
                      Color(0xFFfbfaff),
                    ],
                  ),
                ),
                dotData: const FlDotData(show: false), // No dots
              ),
            ],
          ),
        ),
      );
    });
  }
}
