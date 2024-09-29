import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:import_mark/global/custom_svg_image.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import '../gen/assets.gen.dart';
import '../gen/colors.gen.dart';
import 'app_text_style.dart';

Widget moneyFrame({
  String? text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? textColor,
  imagePath,
  Color? iconColor,
  double? iconHeight,
  double? iconWidth,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      customSvgImage(
          imagePath: imagePath ?? Assets.icons.crossIcon,
          // Assets.icons.dollarIcon,
          height: iconHeight ?? 12.h,
          width: iconWidth ?? 12.w,
          color: iconColor ?? ColorName.black),
      5.width,
      AppTextStyle(
        text: text ?? "24.00",
        color: textColor ?? Colors.black,
        fontSize: fontSize ?? 12.sp,
        fontWeight: fontWeight ?? FontWeight.w500,
      )
    ],
  );
}
