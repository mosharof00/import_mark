import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/models/foods_product_model.dart';
import 'package:import_mark/app/modules/admin/recent_orders/controllers/recent_orders_controller.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/app_text_style_over_flow.dart';
import '../../../../../global/methods/order_status_color.dart';
import '../../../../../global/parse_dateAndTime.dart';
import '../../../../../global/shimmer_loading.dart';
import '../../sales_summary/widgets/product_labels.dart';

class RecentOrderList extends StatelessWidget {
  const RecentOrderList({
    super.key,
    required this.order,
    required this.onTap,
    required this.color,
  });
  final Meal order;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.r),
        child: Material(
          borderRadius: BorderRadius.circular(15.r),
          elevation: 2,
          child: Container(
            height: 210.h,
            width: Get.width,
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: ColorName.white,
            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///   for image section
                  Expanded(
                    child: Stack(children: [
                      ...List.generate(
                          // order.orderproducts!.length > 3
                          //     ? 3
                          //     : order.orderproducts!.length,
                        1,
                              (index) {
                        return Positioned(
                          top: index <= 3 ? index * 3.h : 9.h,
                          left: index <= 3 ? index * 5.h : 15.w,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorName.white, width: 1.5.w),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: CachedNetworkImage(
                                imageUrl: order.strMealThumb!,
                                fit: BoxFit.cover,
                                height: 170.h,
                                width: 150.w,
                                placeholder: (context, url) =>
                                    shimmerLoadingWidget(
                                        height: Get.height, width: Get.width),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  Assets.images.phoneimage.path,
                                  height: Get.height,
                                  width: Get.width,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorName.primaryColor,
                          ),
                          child: Center(
                            child: AppTextStyle(
                              text: 1.toString(),
                              color: ColorName.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 2.h,
                        right: 13.w,
                        child: Container(
                          decoration: BoxDecoration(
                              color: 'paid'  == "paid"
                                  ? Colors.green
                                  : ColorName.crimsonRed,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 1.h),
                            child: const AppTextStyle(
                              // text: order.paymentStatus!.capitalize.toString(),
                              text:'paid' ,
                              color: ColorName.white,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  5.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        8.height,
                        userInfoRecentOrders(
                          icon: Icons.token_outlined,
                          text: '24jhg345gk4',
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                        5.height,
                        userInfoRecentOrders(
                          icon: FontAwesomeIcons.clock,
                          text: DateTimeUtils.formatTimeAgo(
                             "2024-10-01T00:00:00.000000Z"),
                          fontSize: 12.sp,
                        ),
                        5.height,
                        userInfoRecentOrders(
                            icon: FontAwesomeIcons.user,
                            text: "Mosharof",
                            fontSize: 12.sp),
                        5.height,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.black87,
                              size: 18,
                            ),
                            // SvgPicture.asset(svg, height: 10.h, width:10.w),
                            8.width,
                            Expanded(
                              child: AppTextStyleOverFlow(
                                text: 'Dhaka',
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                fontSize: 12.sp,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        5.height,
                        userInfoRecentOrders(
                            icon: FontAwesomeIcons.coins,
                            text: '20373',
                            fontSize: 12.sp),
                        5.height,
                        userInfoRecentOrders(
                            icon: Icons.add_box_rounded,
                            text: '${1} Pcs',
                            fontSize: 12.sp),
                        10.height,
                        LabelContainer(
                          labelTitle: Get.find<RecentOrdersController>().selectedStatus.value,
                          containerColor:
                              OrderStatusColor.getColor(Get.find<RecentOrdersController>().selectedStatus.value),
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget userInfoRecentOrders(
    {IconData? icon,
    required String text,
    double? fontSize,
    String? svg,
    double? iconSize,
    Color? color,
    int? maxLines}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(
        icon,
        color: Colors.black87,
        size: iconSize ?? 15,
      ),
      // SvgPicture.asset(svg, height: 10.h, width:10.w),
      8.width,
      AppTextStyle(
          text: text,
          maxLines: maxLines,
          textAlign: TextAlign.start,
          fontSize: fontSize ?? 13.sp,
          color: color ?? Colors.black54),
    ],
  );
}

Widget titleWidget(
    {required IconData icon,
    required String text,
    double? fontSize,
    double? iconSize,
    Widget? trailingWidget}) {
  return SizedBox(
    height: 20.h,
    width: Get.width / 2,
    child: ListTile(
      horizontalTitleGap: 0,
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      leading: Icon(
        icon,
        size: iconSize ?? 18,
      ),
      title: AppTextStyle(
          text: text, fontSize: fontSize ?? 13.sp, color: Colors.black54),
      trailing: trailingWidget ?? const SizedBox.shrink(),
    ),
  );
}
