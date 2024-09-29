import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import '../gen/colors.gen.dart';
import 'app_text_style.dart';
import 'app_text_style_over_flow.dart';

Widget headerText(
    {required VoidCallback onPressed,
    String? leading,
    Widget? icon,
    String? thrilling}) {
  return Row(
    children: [
      AppTextStyle(
        text: leading ?? "Special Offers",
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      5.width,
      icon ?? 0.width,
      const Spacer(),
      TextButton(
        onPressed: onPressed,
        child: AppTextStyle(
          text: thrilling ?? '',
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: ColorName.primaryColor,
        ),
      )
    ],
  );
}

Widget titleText(
    {required String text, Color? color, int? maxLines, TextAlign? textAlign}) {
  return AppTextStyle(
    text: text,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    textAlign: textAlign ?? TextAlign.center,
  );
}

Widget productTitleText({required String text, Color? color, int? maxLines}) {
  return AppTextStyleOverFlow(
    text: text,
    color: color ?? Colors.black,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    maxLines: maxLines ?? 1,
  );
}

Widget productSubtitleText({required String text, Color? color}) {
  return AppTextStyle(
    text: text,
    color: color ?? Colors.black54,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );
}

Widget productDescriptionText(
    {required String text, Color? color, int? maxLines}) {
  return AppTextStyle(
    text: text,
    color: color ?? Colors.black54,
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    maxLines: maxLines ?? 1,
  );
}

Widget textFieldTitleText({required String text}){
  return   AppTextStyle(
    text: text,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );
}


Widget divider({Color? color, double? height, h, double? paddingVertical}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: paddingVertical ?? 10.h),
    child: Divider(
      height: height ?? 1.h,
      color: color ?? Colors.grey.shade300,
    ),
  );
}

Widget c({Color? color, double? height, double? width}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 7.w),
    height: height ?? 12.h,
    width: width ?? 1.w,
    color: color ?? Colors.black26,
  );
}