import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../global/shimmer_loading.dart';
import '../controllers/home_controller.dart';

class Banners extends StatelessWidget {
  const Banners({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return CarouselSlider.builder(
      carouselController: controller.carouselSliderController,
      itemCount: controller.sliderPicture.length,
      options: CarouselOptions(
          // aspectRatio: 2,
          height: 0.18.sh,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.5,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, reason) {
            controller.bannerCurrentIndex.value = index;
          }),
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          InkWell(
        onTap: () {
          // Get.to(
          // () => const Test(),
          // );
        },
        child: Hero(
          tag: controller.sliderPicture[itemIndex],
          child: CachedNetworkImage(
            imageUrl: controller.sliderPicture[itemIndex],
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 0.3.sh,
                margin: EdgeInsets.only(left: 5.w, right: 5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              );
            },
            placeholder: (context, url) =>
                shimmerLoadingWidget(height: 0.3.sh, width: Get.width),
            errorWidget: (context, url, error) => Image.asset(
              Assets.images.phoneimage.path,
              width: Get.width,
            ),
          ),
        ),
      ),
    );
  }
}
