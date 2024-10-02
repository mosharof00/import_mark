import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/modules/home/controllers/home_controller.dart';
import 'package:import_mark/app/routes/app_pages.dart';
import 'package:import_mark/gen/assets.gen.dart';
import 'package:import_mark/gen/colors.gen.dart';
import 'package:import_mark/global/app_text_style.dart';
import 'package:import_mark/global/badges_widget.dart';
import 'package:import_mark/global/shimmer_loading.dart';
import 'package:import_mark/global/sizedbox_extension.dart';

import '../../profile/controllers/profile_controller.dart';
import '../../profile/views/profile_view.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorName.bgColor, boxShadow: [
        BoxShadow(
          color: Colors.black12,
          offset: const Offset(2, 2),
          blurRadius: 1.r,
        )
      ]),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                10.width,
                GestureDetector(
                  onTap: () {
                    Get.put(ProfileController()).isAdmin.value = false;
                    Get.put(ProfileController()).isFromNaveBar.value = false;
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const ProfileView(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin =
                              Offset(-1.0, 0.0); // Start from the left
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Hero(
                    tag: const Key('image'),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://www.photodoozy.com/uploads/thumbs/mehmet-s-rainy-day-hyperrealistic-3d-ai-profile-picture-with-cute-cat-and-lovely-after-rain-vibes-photodoozy.jpg',
                      imageBuilder: (context, imageProvider) => Container(
                        width: 60.0.w,
                        height: 60.0.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => shimmerLoadingWidget(
                          borderRadius: 50, height: 60.0.h, width: 60.0.w),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                10.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextStyle(
                      text: "Hi,",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    AppTextStyle(
                      text: "Mosharof Khan",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ],
                ),
                15.width,
                const Spacer(),
                Obx(
                  () => badgeWidget(
                    badgeColor: ColorName.primaryColor,
                    count: Get.find<HomeController>().notificationCount.value,
                    onTap: () {
                      Get.toNamed(Routes.NOTIFICATION);
                    },
                    icon: SvgPicture.asset(
                      Assets.icons.notificationsIcon,
                      height: 20.h,
                      width: 20.w,
                      colorFilter: const ColorFilter.mode(
                          ColorName.primaryColor, BlendMode.srcIn),
                    ),
                  ),
                ),
                // badgeWidget(
                //   count: 5,
                //   onTap: () {
                //     Get.toNamed(Routes.CART);
                //   },
                //   icon: SvgPicture.asset(
                //     Assets.icons.orderIcon,
                //     height: 20.h,
                //     width: 20.w,
                //     colorFilter: const ColorFilter.mode(
                //         ColorName.primaryColor, BlendMode.srcIn),
                //   ),
                // ),
                10.width,
              ],
            )
          ]),
    );
  }
}
