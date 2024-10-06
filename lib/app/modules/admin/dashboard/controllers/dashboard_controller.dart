import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../gen/colors.gen.dart';

class DashboardController extends GetxController with GetTickerProviderStateMixin {
  //TODO: Implement DashboardController
  ScrollController scrollController = ScrollController();

  final notificationCount = 5.obs;
  ///  Fot animation
  final shouldAnimate = true.obs;
  final test = 0.obs;

  ///  For Line Chart
  var weeklySteps = <double>[2000, 4000, 5000, 7000, 9000, 6500, 8000].obs;

  /// For Bar Chart
  final touchedIndex = RxInt(-1);
  final List<Color> availableColors = [
    ColorName.adminPrimaryColor,
    ColorName.crimsonRed,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
  ].obs;

  final Color barBackgroundColor = ColorName.black.withOpacity(0.1);
  final Color touchedBarColor = ColorName.crimsonRed;
  final Duration animDuration = const Duration(milliseconds: 150);
  List<DailyCourseSaleStaticModel> dailyOrder = [
    DailyCourseSaleStaticModel(date: DateTime(2024 - 08 - 30), count: 0),
    DailyCourseSaleStaticModel(date: DateTime(2024 - 08 - 31), count: 2),
    DailyCourseSaleStaticModel(date: DateTime(2024 - 09 - 01), count: 6),
    DailyCourseSaleStaticModel(date: DateTime(2024 - 09 - 02), count: 20),
    DailyCourseSaleStaticModel(date: DateTime(2024 - 09 - 03), count: 10),
    DailyCourseSaleStaticModel(date: DateTime(2024 - 09 - 04), count: 15),
    DailyCourseSaleStaticModel(date: DateTime(2024 - 09 - 05), count: 8),
  ];
  double getMaxY() {
    if (dailyOrder.isNotEmpty) {
      int maxCount =
      dailyOrder.map((e) => e.count).reduce((a, b) => a > b ? a : b);
      // int maxCount = count.map((e) => e).reduce((a, b) => a > b ? a : b);
      return maxCount.toDouble();
    } else {
      return 0;
    }
  }

  List<BarChartGroupData> showingGroups({Color? barColor}) {
    return List.generate(dailyOrder.length, (i) {
      final dayOrder = dailyOrder[i];
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            borderRadius: BorderRadius.circular(2.r),
            toY: touchedIndex.value == i
                ? dayOrder.count.toDouble() + 0.2
                : dayOrder.count.toDouble(),
            color: touchedIndex.value == i
                ? availableColors[Random().nextInt(availableColors.length)]
                : barColor,
            width: 15,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: getMaxY(),
              color: barBackgroundColor,
            ),
          ),
        ],
      );
    });
  }

  scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> stopAnimation()async{
    await Future.delayed(const Duration(seconds: 2));
    shouldAnimate.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    // fadeInAnimationController;
    stopAnimation();
    super.onInit();
  }
}
class DailyCourseSaleStaticModel {
  DailyCourseSaleStaticModel({required this.date, required this.count});
  DateTime date;
  int count;
}
