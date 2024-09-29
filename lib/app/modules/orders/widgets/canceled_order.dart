// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shopaholic/app/modules/my_order/controllers/my_order_controller.dart';
// import 'package:shopaholic/global/sizedbox_extension.dart';
//
// import '../../../../gen/assets.gen.dart';
// import '../../../../gen/colors.gen.dart';
// import '../../../../global/app_linear_gradient.dart';
// import '../../../../global/app_text_style.dart';
// import '../../../../global/app_text_style_over_flow.dart';
// import '../../../../global/global_button.dart';
// import '../../../../global/shimmer_loading.dart';
// import '../../../models/product_model.dart';
// import '../../home/controllers/home_controller.dart';
//
// class CanceledOrder extends StatelessWidget {
//   const CanceledOrder({super.key, required this.products, required this.producSize, required this.producColor, required this.producQty, this.arguments});
//   final List<int> products;
//   final String producSize;
//   final String producColor;
//   final int producQty;
//   final dynamic arguments;
//
//
//   @override
//   Widget build(BuildContext context) {
//     final orderController = Get.put(MyOrderController());
//     return Obx(() => ListView.builder(
//       shrinkWrap: true,
//       physics: const AlwaysScrollableScrollPhysics(),
//       itemCount: products?.isEmpty ?? true ? 0 : products!.length,
//       itemBuilder: (context, item) {
//         if (arguments == null || products == null ) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               60.height,
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(50),
//                 child: SvgPicture.asset(
//                   Assets.images.emptycart,
//                   height: 250.h,
//                   width: Get.width,
//                 ),
//               ),
//               10.height,
//               Text(
//                 'No Order Placed!'.tr,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.montserrat(
//                   textStyle: TextStyle(
//                     color: ColorName.black,
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }
//         final homeController = Get.put(HomeController());
//         final ProductModel product = homeController.productList
//             .firstWhere((p) => p.id == products?[item]);
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Material(
//             elevation: 3,
//             borderRadius: BorderRadius.circular(15.r),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.r),
//                 color: ColorName.white,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.shopping_bag,
//                           color: Colors.green,
//                         ),
//                         10.width,
//                         AppTextStyle(
//                           text: 'Today , 2024',
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         const Spacer(),
//                         IconButton(
//                           onPressed: () {
//                             products?.remove(product.id);
//                           },
//                           icon: const Icon(
//                             Icons.cancel_rounded,
//                             color: Colors.green,
//                           ),
//                         ),
//                       ],
//                     ),
//                     5.height,
//                     Container(
//                       width: Get.width,
//                       height: 1,
//                       color: Colors.pink.shade100,
//                     ),
//                     10.height,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: product.images?.isEmpty ==
//                                 null ||
//                                 product.images!.isEmpty
//                                 ? CachedNetworkImage(
//                               imageUrl: orderController.picture
//                                   .value, // Placeholder
//                               placeholder: (context, url) =>
//                                   Center(
//                                     child: shimmerLoadingWidget(),
//                                   ),
//                               errorWidget:
//                                   (context, url, error) =>
//                               const Icon(Icons.error),
//                             )
//                                 : CachedNetworkImage(
//                               imageUrl: product.images![0],
//                             ),
//                           ),
//                         ),
//                         10.width,
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             mainAxisAlignment:
//                             MainAxisAlignment.start,
//                             crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                             children: [
//                               AppTextStyleOverFlow(
//                                 text: product.title!,
//                                 maxLines: 3,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 14.sp,
//                               ),
//                               5.height,
//                               AppTextStyle(
//                                 text: 'Size : $producSize',
//                                 fontSize: 13.sp,
//                               ),
//                               5.height,
//                               AppTextStyle(
//                                 text: 'Color : $producColor',
//                                 fontSize: 13.sp,
//                               ),
//                               5.height,
//                               Row(
//                                 children: [
//                                   AppTextStyle(
//                                     text:
//                                     'Qty : ${producQty.toString()}',
//                                     fontSize: 13.sp,
//                                   ),
//                                 ],
//                               ),
//                               5.height,
//                               Row(
//                                 children: [
//                                   AppTextStyle(
//                                     text:
//                                     '${product.price.toString()} Tk',
//                                     fontSize: 16.sp,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                   const Spacer(),
//                                   globalButton(
//                                       onTap: () {},
//                                       text: 'Track Order',
//                                       width: Get.width / 4,
//                                       blurRadius: 1,
//                                       gradient:
//                                       appSecondLinearGradient(),
//                                       shadowColor:
//                                       Colors.transparent,
//                                       fontSize: 11.sp,
//                                       height: 30),
//                                   5.width,
//                                 ],
//                               ),
//                               10.height,
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     ),);
//   }
// }
