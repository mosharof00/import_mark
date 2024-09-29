import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../global/app_input_textformfield.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../../global/global_button.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final String imageURL = Get.arguments;
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const AppTextStyle(
          text: 'Edit Profile',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    height: 200.h,
                    width: 200.w,
                    decoration: ShapeDecoration(
                      // color: Colors.white,
                      shape: const StarBorder(
                        innerRadiusRatio: .9,
                        pointRounding: .2,
                        points: 12,
                      ),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(imageURL)),
                      shadows: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.8),
                          blurRadius: 100.r,
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(.5),
                          spreadRadius: 2.r,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 40.h,
                    left: 173.w,
                    child: InkWell(
                      onTap: () {
                        ///              Get  Profile Photo
                        customBottomSheet(
                            context: context,
                            fileOnTap: () {
                              controller.getProfileImageFromFile();
                              Get.back();
                            },
                            svgPicture1: SvgPicture.asset(
                              Assets.icons.fileIcon,
                            ),
                            text1: 'File',
                            cameraOnTap: () {
                              controller.getProfileImageFromCamera();
                              Get.back();
                            },
                            svgPicture2: SvgPicture.asset(
                              Assets.icons.cameraIcon1,
                            ),
                            text2: 'Camera');
                      },
                      child: Container(
                        height: 22.h,
                        width: 22.w,
                        decoration: const BoxDecoration(
                            color: ColorName.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1, 2),
                                  blurRadius: 3)
                            ]),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 18.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    20.height,
                    AppTextStyle(
                      text: 'Full Name',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    5.height,
                    const AppInputTextFormField(
                      // prefixIcon: Icon(Icons.person),
                      // prefixIcon: SvgPicture.asset(
                      //   Assets.icons.userIcon,
                      //   width: 12.w,
                      //   height: 12.h,
                      // ),
                      hintText: 'Name',
                    ),
                    20.height,
                    AppTextStyle(
                      text: 'Email',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    5.height,
                    const AppInputTextFormField(
                      // prefixIcon: Icon(Icons.person),
                      keyboardType: TextInputType.emailAddress,
                      // prefixIcon: SvgPicture.asset(
                      //   Assets.icons.emailIcon,
                      //   width: 12.w,
                      //   height: 12.h,
                      // ),
                      hintText: 'Email',
                    ),
                    20.height,
                    AppTextStyle(
                      text: 'Phone Number',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    5.height,
                    IntlPhoneField(
                      // focusNode: focusNode,
                      decoration: InputDecoration(
                        iconColor: ColorName.primaryColor,
                        hintText: 'Enter Number'.tr,
                        fillColor: const Color(0xFFe9ecef),
                        filled: true,
                        contentPadding: EdgeInsets.zero,
                        hintStyle: const TextStyle(
                          fontFamily: FontFamily.gothic,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: Color(0xFFadb5bd),
                            width: 1,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      languageCode: "en",
                      onChanged: (phone) {
                        debugPrint(
                            'Selected Phone Number is : ${phone.completeNumber}');
                      },
                      onCountryChanged: (country) {
                        debugPrint(
                            'Country changed to:  ${country.name} code is : ${country.code}');
                      },
                    ),
                    AppTextStyle(
                      text: 'Gender',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    5.height,
                    Obx(() => Container(
                      height: 43.h,
                      width: Get.width,
                      padding: EdgeInsets.only(left: 10.w, right: 7.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFe9ecef),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: DropdownButton(
                        hint: AppTextStyle(
                          text: 'Select gender',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        underline: const SizedBox(),
                        isExpanded: true,
                        elevation: 0,
                        iconSize: 30.sp,
                        value: controller.selectedGender.value == ""
                            ? null
                            : controller.selectedGender.value,
                        onChanged: (newValue) {
                          controller
                              .upDateSelectedGender(newValue.toString());
                        },
                        items: controller.dropDownClassList.map((e) {
                          return DropdownMenuItem(
                              value: e.toString(),
                              child: AppTextStyle(
                                  text: e.toString(),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500));
                        }).toList(),
                      ),
                    )),
                    20.height,
                    // AppTextStyle(
                    //   text: 'Date of Birth',
                    //   fontSize: 14.sp,
                    //   fontWeight: FontWeight.w600,
                    // ),
                    5.height,
                    // Container(
                    //   height: 43.h,
                    //   width: Get.width,
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xFFe9ecef),
                    //     borderRadius: BorderRadius.circular(8.r),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       10.width,
                    //       Obx(() {
                    //         if (controller.date.value.isEmpty) {
                    //           return AppTextStyle(
                    //             text:
                    //             '${controller.myData.value!.day}/${controller.myData.value!.month}/${controller.myData.value!.year}',
                    //             fontSize: 14.sp,
                    //             fontWeight: FontWeight.w500,
                    //             // color: Colors.grey,
                    //           );
                    //         } else {
                    //           return AppTextStyle(
                    //             text: controller.date.value.toString(),
                    //             fontSize: 14.sp,
                    //             fontWeight: FontWeight.w500,
                    //           );
                    //         }
                    //       }),
                    //       const Spacer(),
                    //       InkWell(
                    //         onTap: () async {
                    //           var results = await showCalendarDatePicker2Dialog(
                    //             context: context,
                    //             config: CalendarDatePicker2WithActionButtonsConfig(
                    //               // calendarType: CalendarDatePicker2Type.range,
                    //                 firstDate: DateTime(1950)),
                    //             dialogSize: const Size(325, 400),
                    //             value: [
                    //               controller.myData.value ?? DateTime.now(),
                    //             ],
                    //             borderRadius: BorderRadius.circular(15),
                    //           );
                    //           if (results != null && results.isNotEmpty) {
                    //             controller.setDate(results[0]);
                    //           }
                    //         },
                    //         child: SvgPicture.asset(
                    //           Assets.icons.calenderIcon,
                    //           colorFilter: const ColorFilter.mode(
                    //               ColorName.primaryColor, BlendMode.srcIn),
                    //           width: 20.w,
                    //           height: 20.h,
                    //         ),
                    //       ),
                    //       10.width
                    //     ],
                    //   ),
                    // ),
                    15.height,
                    globalButton(onTap: () {}, text: "Save"),
                    15.height,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
