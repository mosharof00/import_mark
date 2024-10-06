// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'package:get/get.dart';
// import 'package:import_mark/app/models/foods_product_model.dart';
// import 'package:import_mark/global/sizedbox_extension.dart';
// import 'package:import_mark/helper/helper_utils.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:pdf/pdf.dart';
//
// import '../../../../../gen/colors.gen.dart';
// import '../../../../../global/app_text_style.dart';
// import '../../../../../global/app_text_style_over_flow.dart';
// import '../../../../../global/cached_network_image_builder.dart';
// import '../../../../../global/divider.dart';
// import '../../../../../global/global_button.dart';
// import '../../../../../global/helper_container.dart';
// import '../../../../../global/parse_dateAndTime.dart';
//
// import 'package:pdf/widgets.dart' as pw;
//
// import 'package:flutter/cupertino.dart';
//
// import '../app/modules/admin/sales_summary/widgets/product_labels.dart';
// import '../app/modules/home/controllers/home_controller.dart';
// import '../app/modules/orders/order_details/widget/orderDetailsContainer.dart';
//
// class OrderDetailsLayout extends StatelessWidget {
//   const OrderDetailsLayout({super.key, required this.order, required this.payOnTap, required this.generateInvoiceOnTap});
//   final Meal order;
//   final VoidCallback payOnTap;
//   final VoidCallback generateInvoiceOnTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         10.height,
//         orderDetailsContainer(
//           icon: const Icon(
//             Icons.person,
//             color: Colors.green,
//           ),
//           text: 'User Information',
//           leading: circularImage(
//             imgUrl: 'https://i.pinimg.com/564x/8b/11/a8/8b11a86980c64720a41ec22332a83115.jpg',
//             radius: 22.r,
//           ),
//           firstTitleTextKey: 'Name :   ',
//           firstTitleTextValue: 'User1',
//           secondTitleTextKey: 'Phone :   ',
//           secondTitleTextValue: '+8801314859997',
//           subtitleTextKey: 'Address : ',
//           subtitleTextValue: 'Dhaka',
//           isTrailing: false,
//         ),
//         10.height,
//         orderDetailsContainer(
//           icon: const Icon(
//             Icons.location_on_rounded,
//             color: Colors.green,
//           ),
//           text: 'Delivery Address',
//           leading: const Icon(
//             Icons.location_on_sharp,
//             color: Colors.white,
//           ),
//           firstTitleTextKey: 'City :       ',
//           firstTitleTextValue: 'Dhaka',
//           secondTitleTextKey: 'District :  ',
//           secondTitleTextValue: 'Dhaka',
//           subtitleTextKey: 'Address : ',
//           subtitleTextValue: 'Uttara',
//           isTrailing: false,
//         ),
//         15.height,
//         Container(
//           width: Get.width,
//           decoration: BoxDecoration(
//               color: ColorName.white,
//               borderRadius: BorderRadius.circular(15.r)),
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               children: [
//                 10.height,
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     5.width,
//                     const Icon(
//                       Icons.shopping_cart_rounded,
//                       color: Colors.green,
//                     ),
//                     10.width,
//                     AppTextStyle(
//                       text:
//                           '${'Your Order'.tr} (${2})',
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16.sp,
//                     ),
//                     const Spacer(),
//                     const ProductLabels(text: 'Confirmed')
//                   ],
//                 ),
//                 10.height,
//                 customDivider(),
//                 5.height,
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: 2,
//                   itemBuilder: (context, index) {
//                     final Meal orderProduct =
//                         Get.find<HomeController>().canadianMeals[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         width: Get.width,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             cachedImageHelper(
//                                 imgurl: orderProduct.strMealThumb!,
//                                 imgHeight: 115.h,
//                                 imgWidth: 0.3.sw),
//                             10.width,
//                             SizedBox(
//                               width: 0.4.sw,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   AppTextStyleOverFlow(
//                                     text: orderProduct.strMeal!,
//                                     maxLines: 2,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 14.sp,
//                                   ),
//                                   5.height,
//                                   // AppTextStyle(
//                                   //   text:
//                                   //   '${'Size'.tr} : ${orderProduct.size}',
//                                   //   fontSize: 12.sp,
//                                   // ),
//                                   // 5.width,
//                                   // AppTextStyle(
//                                   //   text:
//                                   //   '${'Color'.tr} : ${orderProduct.color}',
//                                   //   fontSize: 12.sp,
//                                   // ),
//                                   5.height,
//                                   AppTextStyle(
//                                     text: '${'Quantity'.tr} : 2',
//                                     fontSize: 12.sp,
//                                   ),
//                                   5.height,
//                                   Row(
//                                     children: [
//                                       AppTextStyle(
//                                         text: '${'Price'.tr} : ',
//                                         fontSize: 12.sp,
//                                       ),
//                                       AppTextStyle(
//                                         text: '${orderProduct.idMeal} Tk',
//                                         fontSize: 13.sp,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//         15.height,
//         Container(
//           width: Get.width,
//           decoration: BoxDecoration(
//               color: ColorName.white,
//               borderRadius: BorderRadius.circular(15.r)),
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               children: [
//                 10.height,
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     5.width,
//                     Icon(
//                       MdiIcons.creditCardOutline,
//                       color: Colors.green,
//                     ),
//                     10.width,
//                     AppTextStyle(
//                       text:
//                       'Payment Methods',
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16.sp,
//                     ),
//                     const Spacer(),
//                     const ProductLabels(text: 'Confirmed')
//                   ],
//                 ),
//                 10.height,
//                 customDivider(),
//                 5.height,
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: 2,
//                   itemBuilder: (context, index) {
//                     final Meal orderProduct =
//                     Get.find<HomeController>().canadianMeals[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child:ListTile(
//                         leading: circularImage(
//                             imgUrl: "https://www.citybankplc.com/newsevent/1626346970.jpg",
//                             radius: 15.r, imgRadius: 15.r),
//                         title: const AppTextStyle(text: 'City Bank',),
//                         trailing: AppTextStyle(text: '${HelperUtils.currencySymbol} ${50000}'),
//                       )
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//         // Obx(() {
//         //   final test = Get.find<HomeController>().notificationCount.value;
//         //   // controller
//         //   //     .getPaymentMethod(controller.myOrder.paymentMethod.toString());
//         //   return helperContainer(
//         //     showIcon: false,
//         //     onPressed: () {},
//         //     icon: Icon(
//         //       MdiIcons.creditCardOutline,
//         //       color: Colors.green,
//         //     ),
//         //     text: 'Payment Methods',
//         //     leading: circularImage(
//         //         imgUrl: "https://www.citybankplc.com/newsevent/1626346970.jpg",
//         //         radius: 22.r, imgRadius: 50.r),
//         //     titleText: controller.gateway.value,
//         //     subtitleText: '',
//         //     isTrailing: true,
//         //     trailWidget: Container(
//         //       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
//         //       height: 25.h,
//         //       width: 60.w,
//         //       decoration: BoxDecoration(
//         //         borderRadius: BorderRadius.circular(15.r),
//         //         color:
//         //         'Due'  ==
//         //                     'Due'
//         //                 ? ColorName.crimsonRed
//         //                 : ColorName.green,
//         //       ),
//         //       child: InkWell(
//         //         onTap: controller.myOrder.paymentStatus!
//         //                     .toString()
//         //                     .capitalize ==
//         //                 'Due'
//         //             ? () {
//         //                 // final paymentController =
//         //                 //     Get.put(PaymentMethodsController());
//         //
//         //               }
//         //             : null,
//         //         child: Center(
//         //           child: labels(
//         //             text: 'Due' ==
//         //                     'Due'
//         //                 ? 'Pay'
//         //                 : 'Paid',
//         //             color: ColorName.white,
//         //             fontSize: 13.sp,
//         //           ),
//         //         ),
//         //       ),
//         //     ),
//         //   );
//         // }),
//         // controller.myOrder.couriers == null
//         //     ? 0.height
//         //     : Column(
//         //         children: [
//         //           15.height,
//         //           helperContainer(
//         //             icon: Icon(
//         //               MdiIcons.truckDelivery,
//         //               color: Colors.green,
//         //             ),
//         //             text: 'Courier',
//         //             leading: circularImage(
//         //                 imgUrl: controller.myOrder.couriers!.image!,
//         //                 radius: 22.r,
//         //                 imgRadius: 50.r),
//         //             titleText: controller.myOrder.couriers!.courierName!,
//         //             subtitleText: controller.myOrder.hubName!,
//         //             isTrailing: false,
//         //           ),
//         //         ],
//         //       ),
//         // 15.height,
//         // helperContainer(
//         //   icon: Icon(
//         //     MdiIcons.brightnessPercent,
//         //     color: Colors.green,
//         //   ),
//         //   text: 'Discount',
//         //   leading: Icon(
//         //     MdiIcons.brightnessPercent,
//         //     color: Colors.white,
//         //   ),
//         //   titleText: controller.myOrder.coupon == null
//         //       ? 'No Promos Selected'.tr
//         //       : controller.myOrder.coupon.toString(),
//         //   subtitleText: controller.myOrder.coupon == null
//         //       ? ''
//         //       : controller.myOrder.coupon.toString(),
//         //   isTrailing: false,
//         // ),
//         15.height,
//         Container(
//           width: Get.width,
//           padding: EdgeInsets.all(15.r),
//           // height:
//           decoration: BoxDecoration(
//             color: ColorName.white,
//             borderRadius: BorderRadius.circular(15.r),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(
//                     MdiIcons.fileDocumentOutline,
//                     color: Colors.green,
//                   ),
//                   10.width,
//                   AppTextStyle(
//                     text: 'Review Summary',
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16.sp,
//                   ),
//                 ],
//               ),
//               customDivider(),
//               10.height,
//               summaryOptionsRow(
//                   leadingText: '${'Subtotal'.tr} (2 items)',
//                   thrillingText: '${HelperUtils.currencySymbol} ${50000}'),
//               5.height,
//               summaryOptionsRow(
//                   leadingText: 'Shipping Charge',
//                   thrillingText: '+${HelperUtils.currencySymbol} ${600}'),
//               5.height,
//               summaryOptionsRow(
//                   leadingText: 'Discount',
//                   thrillingText: '-${HelperUtils.currencySymbol} ${5000}'),
//               5.height,
//               summaryOptionsRow(
//                   leadingText: 'Tax',
//                   thrillingText: '${HelperUtils.currencySymbol} ${0}'),
//               5.height,
//               summaryOptionsRow(
//                   leadingText: 'Vat',
//                   thrillingText: '${HelperUtils.currencySymbol} ${0}'),
//               5.height,
//               customDivider(),
//               5.height,
//               Obx(() {
//                 return summaryOptionsRow(
//                   leadingText: 'Total',
//                   fontSizeLeadingText: 15.sp,
//                   fontWeightLeadingText: FontWeight.w500,
//                   thrillingText:'${HelperUtils.currencySymbol} ${50000+600+5000}',
//                   //     '${HelperUtils.currencySymbol} ${controller.totalSum(
//                   //   "50000",
//                   //   '600',
//                   //   "5000",
//                   // )}',
//                   fontSizeThrillingText: 18.sp,
//                   fontWeightThrillingText: FontWeight.w600,
//                 );
//               }),
//             ],
//           ),
//         ),
//         15.height,
//         Container(
//           width: Get.width,
//           padding: EdgeInsets.all(15.r),
//           // height:
//           decoration: BoxDecoration(
//             color: ColorName.white,
//             borderRadius: BorderRadius.circular(15.r),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(
//                     MdiIcons.informationBoxOutline,
//                     color: Colors.green,
//                   ),
//                   10.width,
//                   AppTextStyle(
//                     text: 'Information Details',
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16.sp,
//                   ),
//                 ],
//               ),
//               customDivider(),
//               10.height,
//               summaryOptionsRow(
//                 leadingText: 'Purchase Date',
//                 thrillingText: DateTimeUtils.parseDate(
//                   controller.myOrder.createdAt!.toString(),
//                 ),
//               ),
//               5.height,
//               // summaryOptionsRow(
//               //     leadingText: 'Purchase Hour',
//               //     thrillingText: orderController.formatTime(controller
//               //         .myOrder.createdAt!.toString())),
//               summaryOptionsRow(
//                   leadingText: 'Purchase Time',
//                   thrillingText: DateTimeUtils.parseTime(
//                       '2024-09-09T08:16:13.950Z'),
//               5.height,
//               Obx(() {
//                 return summaryOptionsRow(
//                     leadingText: 'Invoice Number',
//                     thrillingText: controller.myOrder.invoiceId.toString(),
//                     thrillingIcon: InkWell(
//                       onTap: () async {
//                         if (controller.isSelect.value) {
//                           controller.isSelect.value = false;
//                         } else {
//                           controller.isSelect.value = true;
//                           final String textToCopy =
//                               controller.myOrder.invoiceId.toString();
//                           if (textToCopy.isNotEmpty) {
//                             try {
//                               await Clipboard.setData(
//                                   ClipboardData(text: textToCopy));
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: const AppTextStyle(
//                                       text: 'Copied to Clipboard!'),
//                                   backgroundColor:
//                                       ColorName.white.withOpacity(0.5),
//                                   duration: const Duration(microseconds: 200),
//                                 ),
//                               );
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content:
//                                         Text('Failed to copy to clipboard.')),
//                               );
//                             }
//                           }
//                         }
//                       },
//                       child: Icon(
//                         controller.isSelect.value ? Icons.check : Icons.copy,
//                         size: 18,
//                       ),
//                     ));
//               }),
//             ],
//           ),
//         ),
//         30.height,
//         globalButton(
//           onTap: () async {
//             // Generate PDF file
//             final pdfFile = await PdfInvoiceApiFromApi.generate(
//               controller.myOrder,
//               PdfColors.black,
//               pw.Font.courier(),
//             );
//
//             // Open the PDF file
//             FileHandleApi.openFile(pdfFile);
//           },
//           text: "Generate Invoice",
//         )
//       ],
//     );
//   }
// }