import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:import_mark/global/app_text_style.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/badges_widget.dart';
import '../../../../../global/shimmer_loading.dart';
import '../../../../routes/app_pages.dart';
import '../../../profile/controllers/profile_controller.dart';
import '../../../profile/views/profile_view.dart';
import '../controllers/dashboard_controller.dart';
import 'charts/bar_chart1.dart';
import 'custom_clay_container.dart';

Widget headerWidget(BuildContext context) {
  final profileController = Get.put(ProfileController());
  final dashBoardController = Get.put(DashboardController());
  return Container(
    color: ColorName.bgColor,
    child: SizedBox(
      height: 0.50.sh,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipPath(
            // clipper: OvalBottomBorderClipper(),
            child: Container(
              height: 290.h,
              color: ColorName.adminPrimaryColor,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 55.h,
                          child: Obx(() {
                            // final ProfileGetModel profile =
                            //     profileController.profileDetails.value;
                            final test =
                                dashBoardController.notificationCount.value;
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                SizedBox(width: 10.w),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextStyle(
                                        text: 'Admin',
                                        color: ColorName.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700),
                                    AppTextStyle(
                                        text: 'mosharof5khan@gmail.com',
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400)
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 100.h,
            left: -60.w,
            child: Container(
              height: 200.h,
              width: 200.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            top: -80.h,
            right: -80.w,
            child: Container(
              height: 200.h,
              width: 200.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            top: 0.14.sh,
            left: 20.w,
            right: 20.w,
            child: const CustomClayContainer(
              // color: Color(0xFFffeef1),
              title: 'Total Weekly Enrolled',
              widget: BarChart1(
                barColor: ColorName.adminPrimaryColor,
              ),
            ),
          ),

          // ///                   Message Icon                    ////
          // Positioned(
          //   right: 58.w,
          //   top: 30.h,
          //   child: Obx(
          //         () => badgeWidget(
          //       count: 2,
          //       onTap: () {
          //         Get.toNamed(Routes.SUPPORT);
          //       },
          //       icon: SvgPicture.asset(
          //         Assets.images.support,
          //         colorFilter:
          //         const ColorFilter.mode(ColorName.white, BlendMode.srcIn),
          //         fit: BoxFit.fill,
          //         height: 30.h,
          //         width: 30.w,
          //       ),
          //     ),
          //   ),
          // ),

          ///                   Notification Icon                ///
          Positioned(
            right: 10.w,
            top: 30.h,
            child: Obx(
              () => badgeWidget(
                badgeColor: ColorName.adminPrimaryColor,
                count: dashBoardController.notificationCount.value,
                onTap: () {
                  Get.toNamed(Routes.NOTIFICATION);
                },
                icon: SvgPicture.asset(
                  Assets.icons.notificationsIcon,
                  height: 20.h,
                  width: 20.w,
                  colorFilter:
                      const ColorFilter.mode(ColorName.white, BlendMode.srcIn),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
