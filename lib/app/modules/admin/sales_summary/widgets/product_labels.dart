import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';

class ProductLabels extends StatelessWidget {
  const ProductLabels(
      {super.key,
      required this.text,
      this.height,
      this.width,
      this.containerColor,
      this.fontWeight,
      this.fontSize});
  final String text;
  final double? height;
  final double? width;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? containerColor;
  @override
  Widget build(BuildContext context) {
    return LabelContainer(
        // containerHeight: height ?? 25,
        // containerWidth: width ?? 70,
        labelTitle: text,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? 10.sp,
        containerColor: text == 'due' ||
                text == 'Due' ||
                text == 'Canceled' ||
                text == 'canceled'
            ? ColorName.crimsonRed
            : containerColor ?? ColorName.green);
  }
}

Widget labels(
    {String? text,
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines}) {
  return AppTextStyle(
    text: text!,
    maxLines: maxLines,
    textAlign: textAlign,
    fontWeight: fontWeight ?? FontWeight.w600,
    fontSize: fontSize ?? 10.sp,
    color: color ?? ColorName.black,
  );
}

class LabelContainer extends StatelessWidget {
  const LabelContainer(
      {super.key,
      this.paddingVertical,
      this.paddingHorizontal,
      required this.labelTitle,
      this.fontSize,
      this.fontWeight,
      required this.containerColor});
  final double? paddingVertical;
  final double? paddingHorizontal;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color containerColor;
  final String labelTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: paddingVertical ?? 3, horizontal: paddingHorizontal ?? 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: containerColor,
      ),
      child: Center(
          child: labels(
              text: labelTitle, color: ColorName.white, fontSize: fontSize)),
    );
  }
}
