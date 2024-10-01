import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import '../../../../../global/app_text_style.dart';

class CustomClayContainer extends StatelessWidget {
  const CustomClayContainer(
      {super.key,
        required this.title,
        required this.widget,
        this.height,
        this.width,
        this.color});
  final String title;
  final Widget widget;
  final double? height;
  final double? width;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      // emboss: true,
      width: width ?? double.infinity,
      height: height ?? 170.h,
      decoration: BoxDecoration(
        // color: const Color(0xFFffeef1),
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2.r,
                offset: Offset(2.w, 1.w))
          ]),

      child: Column(
        children: [
          10.height,
          AppTextStyle(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          Expanded(flex: 2, child: widget),
          5.height
        ],
      ),
    );
  }
}
