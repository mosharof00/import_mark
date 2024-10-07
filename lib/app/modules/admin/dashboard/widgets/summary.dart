import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';

class Summary extends StatelessWidget {
  const Summary({
    super.key,
    required this.firstContainerNumber,
    required this.firstContainerText,
    required this.secondContainerNumber,
    required this.secondContainerText,
    required this.thirdContainerNumber,
    required this.thirdContainerText,
  });

  final String firstContainerNumber;
  final String firstContainerText;
  final String secondContainerNumber;
  final String secondContainerText;
  final String thirdContainerNumber;
  final String thirdContainerText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: ColorName.adminPrimaryColor.withOpacity(0.9),
        // color: ColorName.bgColor
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child:  SummaryOfOrders(
              title: firstContainerNumber.toString(),
              desc: firstContainerText,
            ),
          ),
          Expanded(
            flex: 1,
            child: SummaryOfOrders(
              title: secondContainerNumber.toString(),
              desc: secondContainerText,
            ),
          ),
          Expanded(
            flex: 1,
            child: SummaryOfOrders(
              title: thirdContainerNumber.toString(),
              desc: thirdContainerText,
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryOfOrders extends StatelessWidget {
  const SummaryOfOrders({super.key, required this.title, required this.desc});

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.r),
      child: ClayContainer(
        color: ColorName.adminPrimaryColor.withOpacity(0.9),
        height: 90.h,
        curveType: CurveType.none,
        borderRadius: 8.r,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextStyle(
                  text: title,
                  color: ColorName.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              AppTextStyle(
                  text: desc,
                  color: ColorName.white.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ],
          ),
        ),
      ),
    );
  }
}
