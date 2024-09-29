import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_text_style.dart';

Widget labels(
    {required String text,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    int? maxLines,
    TextAlign? textAlign}) {
  return AppTextStyle(
    text: text,
    fontWeight: fontWeight ?? FontWeight.w600,
    fontSize: fontSize ?? 16.sp,
    color: color,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines ?? 1,
  );
}
