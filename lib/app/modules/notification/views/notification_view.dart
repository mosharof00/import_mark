import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/shimmer_loading.dart';
import '../../../models/foods_product_model.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/notification_controller.dart';
import 'dart:math' as math;

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    List elements = [
      {'name': 'John', 'group': 'Today'},
      {'name': 'Will', 'group': 'Yesterday'},
      {'name': 'Beth', 'group': 'Today'},
      {'name': 'Miranda', 'group': 'Yesterday'},
      {'name': 'Mike', 'group': 'Last Week'},
      {'name': 'Danny', 'group': 'Last Week'},
      {'name': 'John', 'group': 'Today'},
      {'name': 'Will', 'group': 'Yesterday'},
      {'name': 'Beth', 'group': 'Today'},
      {'name': 'Miranda', 'group': 'Yesterday'},
      {'name': 'Mike', 'group': 'Last Week'},
      {'name': 'Danny', 'group': 'Last Week'},
      {'name': 'John', 'group': 'Today'},
      {'name': 'Will', 'group': 'Yesterday'},
      {'name': 'Beth', 'group': 'Today'},
      {'name': 'Miranda', 'group': 'Yesterday'},
      {'name': 'Mike', 'group': 'Last Week'},
      {'name': 'Danny', 'group': 'Last Week'},
      {'name': 'John', 'group': 'Today'},
      {'name': 'Will', 'group': 'Yesterday'},
      {'name': 'Beth', 'group': 'Today'},
      {'name': 'Miranda', 'group': 'Yesterday'},
      {'name': 'Mike', 'group': 'Last Week'},
      {'name': 'Danny', 'group': 'Last Week'},
      {'name': 'John', 'group': 'Today'},
      {'name': 'Will', 'group': 'Yesterday'},
      {'name': 'Beth', 'group': 'Today'},
      {'name': 'Miranda', 'group': 'Yesterday'},
      {'name': 'Mike', 'group': 'Last Week'},
      {'name': 'Danny', 'group': 'Last Week'},
    ];
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: const AppTextStyle(text: 'Notifications'),
        centerTitle: true,
      ),
      body: GroupedListView<dynamic, String>(
        elements: elements,
        groupBy: (element) => element['group'],
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) =>
            item1['name'].compareTo(item2['name']),
        order: GroupedListOrder.ASC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Padding(
          padding: EdgeInsets.all(5.0.r),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextStyle(
                text: value,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: ColorName.primaryColor),
          ),
        ),
        itemBuilder: (
            c,
            element,
            ) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: const AppTextStyle(
                text: "Healthy food is super cheap",
                textAlign: TextAlign.start,
              ),
              subtitle: AppTextStyle(
                  text: '3 min ago',
                  fontSize: 12.sp,
                  textAlign: TextAlign.start,
                  color: ColorName.primaryColor),
              onTap: () {
                // Get.toNamed(Routes.NOTIFICATION_DETAILS),
                final random = math.Random();

                // Generate a random integer between 0 (inclusive) and 100 (exclusive)
                int randomNumber = random.nextInt(20);
                final Meal meal = homeController.canadianMeals[randomNumber];
                Get.toNamed(
                  Routes.PRODUCT_DETAILS,
                  arguments: meal,
                );
              },
              leading: CachedNetworkImage(
                imageUrl:
                'https://cdn.pixabay.com/photo/2015/12/15/06/42/kids-1093758_1280.jpg',
                imageBuilder: (context, imageProvider) => Container(
                  width: 60.0.w,
                  height: 60.0.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => shimmerLoadingWidget(
                    height: 60.0.h, width: 60.0.w, borderRadius: 10.r),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
        },
      ),
      // body:ListView.builder(
      //   // padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
      //   // scrollDirection: axis ?? Axis.horizontal,
      //   shrinkWrap: true,
      //   itemCount: homeController.productList.length,
      //   itemBuilder: (context, item) {
      //     final products = homeController.productList[item];
      //     return Card(
      //       child:SizedBox(
      //         height: 30,
      //         child: AppTextStyle(
      //           text:homeController.productList[item].title.toString() ,
      //         ),
      //       ),
      //     );
      //   },
      // )
    );
  }
}



// Widget shopaholicSeller(){
//   return Scaffold(
//     backgroundColor: ColorName.bgColor,
//     appBar: AppBar(
//       title: const AppTextStyle(text: 'Notifications'),
//       centerTitle: true,
//       backgroundColor: ColorName.bgColor,
//       surfaceTintColor: ColorName.bgColor,
//     ),
//     body: Obx(() {
//       if (controller.isLoading.value == 0) {
//         if (controller.notificationList.isNotEmpty) {
//           return GroupedListView<NotificationData, String>(
//             elements: controller.notificationModel.value.data ?? [],
//             groupBy: (element) => HelperUtils.groupByDate(element.createdAt),
//             groupComparator: (value1, value2) =>
//                 HelperUtils.groupComparator(value1, value2),
//             itemComparator: (item1, item2) =>
//                 item1.title!.compareTo(item2.title!),
//             order: GroupedListOrder.ASC,
//             useStickyGroupSeparators: true,
//             groupSeparatorBuilder: (String value) => Padding(
//               padding: EdgeInsets.all(5.0.r),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: AppTextStyle(
//                   text: value,
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.w400,
//                   color: ColorName.primaryColor,
//                 ),
//               ),
//             ),
//             itemBuilder: (c, element) {
//               return Container(
//                 margin: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom:
//                     BorderSide(width: 1.w, color: Colors.grey.shade300),
//                   ),
//                 ),
//                 child: ListTile(
//                   title: AppTextStyle(
//                     text: element.title!,
//                     textAlign: TextAlign.start,
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       element.description == null
//                           ? const SizedBox.shrink()
//                           : AppTextStyle(
//                         text: element.description!,
//                         fontSize: 12.sp,
//                         textAlign: TextAlign.start,
//                         color: ColorName.primaryColor,
//                       ),
//                       3.height,
//                       AppTextStyle(
//                         text: HelperUtils.formatTimeAgo(element.createdAt!),
//                         fontSize: 12.sp,
//                         textAlign: TextAlign.start,
//                         color: ColorName.primaryColor,
//                       ),
//                     ],
//                   ),
//                   onTap: () {
//                     // Handle tap
//                   },
//                   leading: CircleAvatar(
//                     backgroundColor: ColorName.primaryColor.withOpacity(0.2),
//                     child: Center(
//                         child: SvgPicture.asset(
//                           Assets.images.singleLogoSvg,
//                           height: 25,
//                           width: 25,
//                         )),
//                   ),
//                   trailing: cachedImageHelper(
//                       imgurl: element.image == null ? '' : element.image!,
//                       imgHeight: 70.h,
//                       imgWidth: 50.w),
//                 ),
//               );
//             },
//           );
//         } else {
//           return ServerErrorWidget(
//             svgImagePath: Assets.icons.emptyNotification,
//             title: 'Sorry',
//             message: "You don't have any notification yet.",
//             iconHeight: 200.h,
//             iconWidth: 200,
//           );
//         }
//       } else if (controller.isLoading.value == 1) {
//         return Center(
//             child: loadingAnimationWidget(
//                 color: ColorName.primaryColor, size: 40));
//       } else {
//         return const ServerErrorWidget(
//           iconHeight: 300,
//           iconWidth: 300,
//         );
//       }
//     }),
//   );
// }