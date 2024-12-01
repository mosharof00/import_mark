import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:import_mark/global/app_text_style.dart';
import 'package:import_mark/global/sizedbox_extension.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style_over_flow.dart';
import '../../../../../global/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../../global/global_snackbar.dart';
import '../../../../../global/loading_buttoon.dart';
import '../../../../../global/log_printer.dart';
import '../../../../../global/shimmer_loading.dart';
import '../../../../../helper/appbar_title.dart';
import '../../../register/widgets/app_input_with_title.dart';
import '../controllers/add_category_controller.dart';

class AddCategoryView extends GetView<AddCategoryController> {
  const AddCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: "Add Category"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.height,
                SizedBox(
                  height: 190,
                  width: Get.width,
                  child: Obx(() {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categoryList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of items per row
                        crossAxisSpacing:
                            5.0, // Spacing between items horizontally
                        mainAxisSpacing:
                            1.0, // Vertical spacing between grid items
                        // Adjust this to control item size
                      ),
                      itemBuilder: (context, index) {
                        final category = controller.categoryList[index];
                        return Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.setBrandForUpdate(category);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: category.image,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 50.0.w,
                                        height: 50.0.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0.0, 1.0),
                                              //(x,y)
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          shimmerLoadingWidget(
                                              borderRadius: 50,
                                              height: 50.0.h,
                                              width: 50.0.w),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.error,
                                        size: 50.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Expanded(
                                      child: AppTextStyleOverFlow(
                                        text: category.name
                                            .split(' ')[0]
                                            .toString(),
                                        fontWeight: FontWeight.w500,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        fontSize: 11.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0.h,
                              right: 20.w,
                              child: Container(
                                height: 20.h,
                                width: 20.w,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorName.white),
                                child: const Center(
                                  child: Icon(
                                    Icons.edit,
                                    size: 12,
                                    color: ColorName.gray410,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }),
                ),
                5.height,
                AppTextStyle(
                    text: 'Add New Brand',
                    fontSize: 16.sp,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500),
                5.height,
                AppTextStyle(
                    text: 'Here you can add/update new Brand',
                    fontSize: 11.sp,
                    textAlign: TextAlign.start,
                    color: ColorName.gray410,
                    fontWeight: FontWeight.w400),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: InkWell(
                    onTap: () {
                      // customBottomSheet(
                      //     context: context,
                      //     onTap1: () {
                      //       // controller.getProfileImageFromFile();
                      //       Get.back();
                      //     },
                      //     svgIcon1: Assets.icons.fileIcon,
                      //     text1: 'File',
                      //     onTap2: () {
                      //       // controller.getProfileImageFromCamera();
                      //       Get.back();
                      //     },
                      //     svgIcon2: Assets.icons.cameraIcon,
                      //     text2: 'Camera',
                      //     icon2Height: 45.h,
                      //     icon2Width: 45.w);
                    },
                    borderRadius: BorderRadius.circular(15.r),
                    // child: Obx(() {
                    //   if (controller.isUpdateMode.value) {
                    //     if (controller.isGetImageFromFile.value) {
                    //       return showImageFromFile(
                    //           image: controller.selectedPhoto.value!.path,
                    //           deleteOnTap: () {
                    //             controller.clear();
                    //           });
                    //     } else {
                    //       return showImageFromNetwork(
                    //           image: controller.selectedPhoto.value!.path,
                    //           deleteOnTap: () {
                    //             controller.clear();
                    //           });
                    //     }
                    //   } else {
                    //     if (controller.isGetImageFromFile.value) {
                    //       return showImageFromFile(
                    //           image: controller.selectedPhoto.value!.path,
                    //           deleteOnTap: () {
                    //             controller.clear();
                    //           });
                    //     } else {
                    //       return picPlaceholderContainer(
                    //           color: controller.selectedPhoto.value == null
                    //               ? controller.errorColor
                    //               : Colors.grey,
                    //           widget: const Icon(
                    //             Icons.add_a_photo_rounded,
                    //             size: 60,
                    //             color: ColorName.primaryColor,
                    //           ));
                    //     }
                    //   }
                    // }),
                  ),
                ),
                30.height,
                AppTextStyle(
                    text: 'Add Name',
                    fontSize: 16.sp,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500),
                5.height,
                AppInputTitle(
                  controller: controller.nameEditingController,
                  label: 'Full Name',
                  hintText: 'Full Name',
                  validatorText: 'Please enter a Name',
                ),
                20.height,
                AppTextStyle(
                    text: 'Add Description',
                    fontSize: 16.sp,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500),
                5.height,
                AppInputTitle(
                  controller: controller.nameEditingController,
                  label: 'Full Name',
                  hintText: 'Full Name',
                  validatorText: 'Please enter Description',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: Obx(() {
          return loadingButton(
            onTap: () {
              if (formKey.currentState!.validate()) {
                if (controller.isUpdateMode.value) {
                  ///  Update Brand
                  // controller.updateBrand();
                } else {
                  if (controller.selectedPhoto.value != null) {
                    ///  Add Brand
                    Log.i("Add brand called");
                    // controller.addBrand();
                  } else {
                    controller.btnController.stop();
                    globalSnackBar(
                        title: "Warning!", message: "Image is required");
                  }
                }
              } else {
                controller.btnController.stop();
                globalSnackBar(
                    title: "Warning!",
                    message: "Please enter all required feeds");
              }
            },
            controller: controller.btnController,
            text: controller.isUpdateMode.value
                ? "Update Brand"
                : "Add New Brand",
          );
        }),
      ),
    );
  }
}
