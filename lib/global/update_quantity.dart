import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:import_mark/global/custom_svg_image.dart';
import '../gen/assets.gen.dart';
import '../gen/colors.gen.dart';
import 'app_text_style.dart';

class UpdateQuantity extends StatelessWidget {
  const UpdateQuantity({
    super.key,
    required this.text,
    required this.plusOnTap,
    required this.minusOnTap,
  });
  final int text;
  final VoidCallback plusOnTap;
  final VoidCallback minusOnTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      width: 140.w,
      child: Row(
        children: [
          IconButton(
              onPressed: minusOnTap,
              icon: Icon(
                Icons.minimize,
                size: 20.sp,
              )
              //  customSvgImage(
              //     imagePath: Assets.icons.minusIcon,
              //     color:
              //     text > 1 ? ColorName.primaryColor :
              //     Colors.grey,
              //     width: 20.w,
              //     height: 20.h),
              ),
          AppTextStyle(
            text: text.toString(),
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
          IconButton(
              onPressed: plusOnTap,
              icon: Icon(
                Icons.add,
                size: 20.sp,
              )
              // customSvgImage(
              //     imagePath: Assets.icons.plusIcon,
              //     color: ColorName.primaryColor,
              //     width: 20.w,
              //     height: 20.h),
              ),
        ],
      ),
    );
  }
}
