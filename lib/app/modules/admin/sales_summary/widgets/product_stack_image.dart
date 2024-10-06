import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../global/cached_network_image_builder.dart';



class ProductStackImages extends StatelessWidget {
  const ProductStackImages({super.key, required this.imgUrl, required this.count});
  final String imgUrl;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        cachedImageHelper(
            imgurl: imgUrl,
            imgWidth: 120.w,
            imgHeight: 120.h),
        Positioned(
          top: 0,
          right: 0,
          child: Badge.count(count: count),
        ),
      ],
    );
  }
}
