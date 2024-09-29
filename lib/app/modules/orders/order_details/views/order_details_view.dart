import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/custom_svg_image.dart';
import '../../../../../global/divider.dart';
import '../../../../../global/global_button.dart';
import '../../../../../global/helper_container.dart';
import '../../../../../global/text_widgets.dart';
import '../../../../models/foods_product_model.dart';
import '../../../cart/widgets/cart_list.dart';
import '../../../home/controllers/home_controller.dart';
import '../controllers/order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        title: const AppTextStyle(
          text: 'Order Status',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            children: [
              // Container(
              //   height: 150.h,
              //   width: Get.width,
              //   decoration: BoxDecoration(
              //     color: ColorName.white,
              //     borderRadius: BorderRadius.circular(15.r),
              //   ),
              //   child: Center(
              //       child: Image.asset(
              //         Assets.images.foodDelivery.path,
              //       )
              //
              //     // CircleAvatar(
              //     //   radius: 70.r,
              //     //   backgroundImage: AssetImage(
              //     //     Assets.images.foodDelivery.path,
              //     //   ),
              //     // ),
              //   ),
              // ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextStyle(
                        text: 'Estimated time of delivery',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.start,
                      ),
                      AppTextStyle(
                        text: "10:15 - 10:20",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 25.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: ColorName.primaryColor,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppTextStyle(
                                text: "Teacking",
                                color: ColorName.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                              10.width,
                              customSvgImage(
                                  imagePath: Assets.icons.radioOnIcon,
                                  color: Colors.white)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  AppTextStyle(
                    text: "Near You",
                    color: ColorName.primaryColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              15.height,

              /// Your orders view
              Container(
                width: Get.width,
                // height: 400.h,
                decoration: BoxDecoration(
                  color: ColorName.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      10.height,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          5.width,
                          const Icon(
                            Icons.shopping_cart_rounded,
                            color: Colors.green,
                          ),
                          10.width,
                          // (${products.length})
                          AppTextStyle(
                            text: 'Your Order',
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                          // const Spacer(),
                          // viewProducts  == true ? InkWell(
                          //   onTap: (){
                          //     Get.toNamed(Routes.PRODUCTS);
                          //   },
                          //     child: const Icon(Icons.add)) : 5.width,
                        ],
                      ),
                      10.height,
                      divider(),
                      5.height,
                      ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final Meal meal =
                            Get.find<HomeController>().canadianMeals[index];
                            return CartListView(
                                meal: meal,
                                index: index,
                                quantityWidgets: false);
                          })
                    ],
                  ),
                ),
              ),
              15.height,

              helperContainer(
                icon: Icon(
                  MdiIcons.truckDelivery,
                  color: Colors.green,
                ),
                text: 'Delivery',
                leading: CachedNetworkImage(
                  imageUrl:
                  "https://play-lh.googleusercontent.com/ge5slpBr9DmVDPk5yjIddZhCR5lYqRXJv5QAunyvRrOGv48VR1aaCyEfPix0xbKQ3w",
                  imageBuilder: (context, imageProvider) => Container(
                    width: 45.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                ),
                titleText: "Home  (Dhaka)",
                subtitleText: "Gulshan-1, Badda link road",
              ),
              15.height,
              helperContainer(
                icon: Icon(
                  MdiIcons.creditCardOutline,
                  color: Colors.green,
                ),
                text: 'Payment Methods',
                leading: CachedNetworkImage(
                  imageUrl:
                  "https://d2u0ktu8omkpf6.cloudfront.net/1f22b58c6f6bc0db5c56051467e5f6748e3995c29bcce234.jpg",
                  imageBuilder: (context, imageProvider) => Container(
                    width: 45.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                ),
                titleText: "Bkash",
                subtitleText: "01314859997",
              ),
              15.height,
              helperContainer(
                icon: Icon(
                  MdiIcons.brightnessPercent,
                  color: Colors.green,
                ),
                text: 'Discounts',
                leading: Icon(
                  MdiIcons.brightnessPercent,
                  color: Colors.white,
                ),
                titleText: "Best Deal: 20% off",
                subtitleText: "20DEALS,Spend (&150). valid till 20/05/2024",
              ),
              15.height,
              Container(
                width: Get.width,
                padding: EdgeInsets.all(15.r),
                // height:
                decoration: BoxDecoration(
                  color: ColorName.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.fileDocumentOutline,
                          color: Colors.green,
                        ),
                        10.width,
                        AppTextStyle(
                          text: 'Review Summary',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ],
                    ),
                    customDivider(),
                    10.height,
                    summaryOptionsRow(
                        leadingText: 'Subtotal (3 items)',
                        thrillingText: '৳ 1000'),
                    5.height,
                    summaryOptionsRow(
                        leadingText: 'Delivery Charge', thrillingText: '৳ 100'),
                    5.height,
                    summaryOptionsRow(
                        leadingText: 'Promos', thrillingText: '৳ 50'),
                    5.height,
                    summaryOptionsRow(
                        leadingText: 'Tax', thrillingText: '৳ 120'),
                    5.height,
                    customDivider(),
                    5.height,
                    summaryOptionsRow(
                        leadingText: 'Total',
                        fontSizeLeadingText: 15.sp,
                        fontWeightLeadingText: FontWeight.w500,
                        thrillingText: '৳ 1170',
                        fontSizeThrillingText: 18.sp,
                        fontWeightThrillingText: FontWeight.w600),
                  ],
                ),
              ),
              15.height,
              Container(
                width: Get.width,
                padding: EdgeInsets.all(15.r),
                // height:
                decoration: BoxDecoration(
                  color: ColorName.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.informationBoxOutline,
                          color: Colors.green,
                        ),
                        10.width,
                        AppTextStyle(
                          text: 'Information Details',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ],
                    ),
                    customDivider(),
                    10.height,
                    summaryOptionsRow(
                        leadingText: 'Purchase Data',
                        thrillingText: '20 May 2024'),
                    5.height,
                    summaryOptionsRow(
                        leadingText: 'Purchase Hour',
                        thrillingText: '08:30 PM'),
                    5.height,
                    summaryOptionsRow(
                      leadingText: 'Invoice Number',
                      thrillingText: 'NNNED123GIU',
                      thrillingIcon: Icon(
                        Icons.copy_sharp,
                        color: Colors.black,
                        size: 18.sp,
                      ),
                    ),
                    summaryOptionsRow(
                      leadingText: 'Receipt Number',
                      thrillingText: 'UBLYCUOJNX',
                      thrillingIcon: Icon(
                        Icons.copy_sharp,
                        color: Colors.black,
                        size: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                child: globalButton(
                    onTap: () {},
                    shadowColor: Colors.transparent,
                    text: "Confirm Order",
                    // width: 300.w,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
