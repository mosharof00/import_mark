import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../gen/colors.gen.dart';
import 'app_text_style.dart';

Widget badgeWidget({
  int? count,
  Function()? onTap,
  required Widget icon,
  Color? badgeColor,
  Color? borderColor,
  Color? countColor,
}) {
  return Container(
    margin: EdgeInsets.all(3.r),
    // padding: EdgeInsets.all(3.r),
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
            Border.all(width: 1, color: borderColor ?? Colors.grey.shade200)),
    child: badges.Badge(
      position: badges.BadgePosition.topEnd(top: 1, end: 5),
      showBadge: true,
      ignorePointer: false,
      onTap: onTap,
      badgeContent: AppTextStyle(
        text: 3.toString(),
        color: countColor ?? ColorName.white,
        fontSize: 10.sp,
      ),
      badgeAnimation: const badges.BadgeAnimation.slide(
        animationDuration: Duration(seconds: 1),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.circle,
        badgeColor: badgeColor ?? Colors.blue,
        padding: const EdgeInsets.all(4),
        borderRadius: BorderRadius.circular(4),
        // badgeGradient: const badges.BadgeGradient.linear(
        //   colors: [ColorName.gradientStart, ColorName.gradientEnd],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
        elevation: 0,
      ),
      child: IconButton(
        onPressed: onTap,
        icon: icon,
      ),
    ),
  );
}
