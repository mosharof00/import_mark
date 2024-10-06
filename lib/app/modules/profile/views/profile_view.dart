import 'package:cached_network_image/cached_network_image.dart';
// import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:import_mark/global/sizedbox_extension.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/bottom_sheets/log_out_bottom_sheet.dart';
import '../../../../global/label_text.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_option.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    final String imageURL;
    if (controller.isAdmin.value) {
      imageURL =
      'https://i.pinimg.com/736x/8d/de/f6/8ddef6e048aa4fbd04f7949103ffc943.jpg';
    } else {
      imageURL =
      "https://www.photodoozy.com/uploads/thumbs/mehmet-s-rainy-day-hyperrealistic-3d-ai-profile-picture-with-cute-cat-and-lovely-after-rain-vibes-photodoozy.jpg";
    }
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading:
        controller.isFromNaveBar.value ? false : true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                FractionallySizedBox(
                  widthFactor: .6,
                  child: Hero(
                    tag: const Key('image'),
                    child: Container(
                      height: 260.h,
                      width: 260.w,
                      decoration: ShapeDecoration(
                        // color: Colors.white,
                        shape: const StarBorder(
                          innerRadiusRatio: .9,
                          pointRounding: .2,
                          points: 12,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(imageURL),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.8),
                            blurRadius: 120.r,
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(.5),
                            spreadRadius: 2.r,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                labels(text: 'Mosharof Khan', fontSize: 20.sp),
                labels(
                    text: 'mosharof5khan@gmail.com',
                    fontSize: 12.sp,
                    color: ColorName.gray410),
              ],
            ),
          ),
          Expanded(
              flex: 5,
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15.r,
                      )
                    ]),
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        profileOptions(
                          onTap: () {
                            Get.toNamed(Routes.ADMIN_MAIN_PAGE);
                          },
                          text: 'Switch Account',
                          icon: Assets.icons.switchAccountIcon,
                          iconHeight: 20.h,
                          iconWidth: 20.w,
                        ),
                        profileOptions(
                            onTap: () {
                              Get.toNamed(Routes.EDIT_PROFILE,
                                  arguments: imageURL);
                            },
                            text: 'Edit Profile',
                            icon: Assets.images.userOutlineIcon),
                        // profileOptions(
                        //   onTap: () {
                        //     Get.toNamed(Routes.BOOKMARK);
                        //   },
                        //   text: 'Bookmark',
                        //   icon: Assets.images.bookmark,
                        //   iconHeight: 16.h,
                        //   iconWidth: 16.w,
                        // ),
                        profileOptions(
                            onTap: () {},
                            text: 'Payment Methods',
                            icon: Assets.images.paymentMethodsIcon),
                        profileOptions(
                            onTap: () {},
                            text: 'Account & Security',
                            icon: Assets.images.securityIcon),
                        profileOptions(
                            onTap: () {
                              // Get.toNamed(Routes.SETTINGS);
                            },
                            text: 'Settings',
                            icon: Assets.images.settingIcon),
                        profileOptions(
                            onTap: () {},
                            text: 'Notification',
                            icon: Assets.images.notificationsIcon),
                        profileOptions(
                            onTap: () {},
                            text: 'Help & Support',
                            icon: Assets.images.helpConterIcon),
                        profileOptions(
                            onTap: () {
                              LogOutBottomSheet.show(context, () {
                                // if (Get.find<LoginController>().users == null) {
                                //   Get.find<LoginController>().auth.signOut();
                                // }
                                Get.offAllNamed(Routes.LOGIN);
                              }, () {
                                Get.back();
                              });
                            },
                            text: 'Sign Out',
                            icon: Assets.images.logoutIcon,
                            iconColor: ColorName.crimsonRed),
                        10.height
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
