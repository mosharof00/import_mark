import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';

Widget profileOptions({
  required VoidCallback onTap,
  required String text,
  required String icon,
  Color? bgColor,
  Color? textColor,
  Color? iconColor,
  double? iconHeight,
  double? iconWidth,
}) {
  return CupertinoButton(
    padding: EdgeInsets.only(top: 0.h),
    onPressed: onTap,
    child: Container(
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: bgColor ?? ColorName.white,
        // border: Border.all(color: ColorName.primaryColor),
      ),
      child: Row(
        children: [
          10.width,
          SvgPicture.asset(
            icon,
            height: iconHeight ?? 17.h,
            width: iconWidth ?? 17.w,
            colorFilter:
                ColorFilter.mode(iconColor ?? Colors.black, BlendMode.srcIn),
          ),
          20.width,
          AppTextStyle(
            text: text,
            color: textColor ?? Colors.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_sharp,
            size: 17.sp,
          ),
          5.width,
        ],
      ),
    ),
  );
}
