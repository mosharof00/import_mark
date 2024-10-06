import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../controllers/dashboard_controller.dart';
import '../weekly_chart_helper.dart';

class BarChart1 extends StatelessWidget {
  const BarChart1({super.key, this.barColor});
  final Color? barColor;
  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.put(DashboardController());
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: BarChart(
          BarChartData(
            maxY: dashboardController.getMaxY(),
            minY: 0,
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (_) => ColorName.primaryColor,
                tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                tooltipMargin: 0,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final DailyCourseSaleStaticModel order =
                  dashboardController.dailyOrder[groupIndex];
                  String weekday = DateFormat('EEEE').format(order.date);
                  return BarTooltipItem(
                    '$weekday\n',
                    GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: order.count.toString(),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  );
                },
              ),
              touchCallback: (FlTouchEvent event, barTouchResponse) {
                if (!event.isInterestedForInteractions ||
                    barTouchResponse == null ||
                    barTouchResponse.spot == null) {
                  dashboardController.touchedIndex.value = -1;
                } else {
                  dashboardController.touchedIndex.value =
                      barTouchResponse.spot!.touchedBarGroupIndex;
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
                    getTitlesWidget: (value, meta) =>
                        getTitles(value, meta, dashboardController.dailyOrder)),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) =>
                        leftTitles(value, meta, dashboardController.dailyOrder)),
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: dashboardController.showingGroups(barColor: barColor),
            gridData: const FlGridData(show: false),
          ),
          swapAnimationCurve: Curves.easeInOut,
          swapAnimationDuration: dashboardController.animDuration,
        ),
      );
    });
  }
}
