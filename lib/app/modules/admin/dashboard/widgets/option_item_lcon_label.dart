import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import '../../../../../global/app_text_style.dart';

class OptionItemLabel extends StatelessWidget {
  const OptionItemLabel({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            fit: BoxFit.fill,
            height: 70.h,
            width: 70.w,
            // colorFilter:
            //     const ColorFilter.mode(ColorName.primaryColor, BlendMode.srcIn),
          ),
          SizedBox(height: 10.h),
          AppTextStyle(
              text: title,
              color: Colors.black,
              fontSize: 15.sp,
              maxLines: 2,
              fontWeight: FontWeight.w500,
              height: 0.09),
          5.height,
        ],
      ),
    );
  }
}
