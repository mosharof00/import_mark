import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../gen/assets.gen.dart';
import '../gen/colors.gen.dart';
import 'app_text_style.dart';

Widget loadingButton({
  required VoidCallback onTap,
  required RoundedLoadingButtonController controller,
  required String text,
  Color? color,
  Color? valueColor,
  double? height,
  double? blurRadius,
  double? width,
  double? fontSize,
  FontWeight? fontWeight,
  double? borderRadius,
  LinearGradient? gradient,
  Widget? child,
}) {
  return RoundedLoadingButton(
    height: height ?? 45.h,
    width: width ?? Get.width,
    controller: controller,
    color: color ?? ColorName.primaryColor,
    valueColor:valueColor?? Colors.white ,
    onPressed: onTap,
    borderRadius: borderRadius ?? 50.r,
    child: child ??
        Center(
          child: AppTextStyle(
            text: text,
            color: Colors.white,
            fontSize: fontSize ?? 18.sp,
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
        ),
  );
}
