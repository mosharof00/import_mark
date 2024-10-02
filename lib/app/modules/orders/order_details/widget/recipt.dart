// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:shopaholic_seller/app/repository/api_endpoint.dart';
// import 'package:shopaholic_seller/helper/helper_utils.dart';
//
// import '../../../../gen/assets.gen.dart';
// import '../../../models/order place/user_orderlist_post_model.dart';
// import '../../my_order/controllers/my_order_controller.dart';
// import 'fileHandle.dart';
//
// class PdfInvoiceApiFromApi {
//   final MyOrderController myOrderController = Get.find();
//   static Future<File> generate(
//       MyOrder invoiceData, PdfColor color, pw.Font fontFamily) async {
//     final pdf = pw.Document();
//
//     final iconImage = (await rootBundle.load(HelperUtils.appLogo))
//         .buffer
//         .asUint8List();
//
//     final tableHeaders = [
//       'Description',
//       'Quantity',
//       'Unit Price',
//     ];
//
//     final tableData = invoiceData.orderproducts
//         ?.map((product) => [
//       product.productName,
//       product.qty.toString(),
//       '\$${product.price}',
//     ])
//         .toList();
//
//     pdf.addPage(
//       pw.MultiPage(
//         build: (context) {
//           return [
//             pw.Row(
//               children: [
//                 pw.Image(
//                   pw.MemoryImage(iconImage),
//                   height: 100.h,
//                   width: 130.w,
//                 ),
//                 pw.SizedBox(width: 1 * PdfPageFormat.mm),
//                 pw.Spacer(),
//                 pw.SizedBox(
//                   width: 0.5.sw,
//                   child: pw.Column(
//                     mainAxisSize: pw.MainAxisSize.min,
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text(
//                         invoiceData.name!,
//                         style: pw.TextStyle(
//                           fontSize: 15.5,
//                           fontWeight: pw.FontWeight.bold,
//                           color: color,
//                           font: fontFamily,
//                         ),
//                       ),
//                       pw.Text(
//                         invoiceData.email!,
//                         style: pw.TextStyle(
//                           fontSize: 14.0,
//                           color: color,
//                           font: fontFamily,
//                         ),
//                       ),
//                       pw.Text(
//                         parseTime(
//                           invoiceData.createdAt.toString(),
//                         ),
//                         style: pw.TextStyle(
//                           fontSize: 14.0,
//                           color: color,
//                           font: fontFamily,
//                         ),
//                       ),
//                       pw.Row(children: [
//                         pw.Expanded(
//                           flex: 1,
//                           child: pw.Text(
//                             invoiceData.address.toString(),
//                             maxLines: 3,
//                             style: pw.TextStyle(
//                               fontSize: 14.0,
//                               color: color,
//                               font: fontFamily,
//                             ),
//                           ),
//                         ),
//                         pw.Text(
//                           ' ${invoiceData.district.toString()}, ${invoiceData.city.toString()}',
//                           style: pw.TextStyle(
//                             fontSize: 14.0,
//                             color: color,
//                             font: fontFamily,
//                           ),
//                         ),
//                       ])
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             pw.Row(
//               mainAxisSize: pw.MainAxisSize.min,
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text(
//                   'Invoice ID: ',
//                   style: pw.TextStyle(
//                     fontSize: 14.0,
//                     fontWeight: pw.FontWeight.bold,
//                     color: color,
//                     font: fontFamily,
//                   ),
//                 ),
//                 pw.Text(
//                   invoiceData.invoiceId!,
//                   style: pw.TextStyle(
//                     fontSize: 14.0,
//                     fontWeight: pw.FontWeight.bold,
//                     color: color,
//                     font: fontFamily,
//                   ),
//                 ),
//               ],
//             ),
//             pw.SizedBox(height: 1 * PdfPageFormat.mm),
//             pw.Divider(),
//             pw.SizedBox(height: 1 * PdfPageFormat.mm),
//             pw.Text(
//               'Dear ${invoiceData.name},\nThank you for your purchase! We appreciate your business and hope you enjoy your product. If you have any questions or need assistance, please don\'t hesitate to reach out.',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: 14.0,
//                 color: color,
//                 font: fontFamily,
//               ),
//             ),
//             pw.SizedBox(height: 5 * PdfPageFormat.mm),
//             ///
//             /// PDF Table Create
//             ///
//             pw.TableHelper.fromTextArray(
//               headers: tableHeaders,
//               data: tableData!,
//               border: null,
//               headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               headerDecoration:
//               const pw.BoxDecoration(color: PdfColors.grey300),
//               cellHeight: 30.0,
//               cellAlignments: {
//                 0: pw.Alignment.centerLeft,
//                 1: pw.Alignment.centerRight,
//                 2: pw.Alignment.centerRight,
//                 3: pw.Alignment.centerRight,
//                 4: pw.Alignment.centerRight,
//               },
//             ),
//             pw.Divider(),
//             pw.Container(
//               alignment: pw.Alignment.centerRight,
//               child: pw.Row(
//                 children: [
//                   pw.Spacer(flex: 4),
//                   pw.Expanded(
//                     flex: 4,
//                     child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'Sub total :',
//                                 style: pw.TextStyle(
//                                   fontWeight: pw.FontWeight.bold,
//                                   color: color,
//                                   fontSize: 13,
//                                   font: fontFamily,
//                                 ),
//                               ),
//                             ),
//                             pw.Text(
//                               '\$ ${invoiceData.subTotal}',
//                               style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold,
//                                 color: color,
//                                 fontSize: 13,
//                                 font: fontFamily,
//                               ),
//                             ),
//                           ],
//                         ),
//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'Shipping Charge :',
//                                 style: pw.TextStyle(
//                                   fontWeight: pw.FontWeight.bold,
//                                   color: color,
//                                   fontSize: 13,
//                                   font: fontFamily,
//                                 ),
//                               ),
//                             ),
//                             pw.Text(
//                               '\$ ${invoiceData.shippingCharge}',
//                               style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold,
//                                 color: color,
//                                 fontSize: 13,
//                                 font: fontFamily,
//                               ),
//                             ),
//                           ],
//                         ),
//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'Promos & Coupon :',
//                                 style: pw.TextStyle(
//                                   fontWeight: pw.FontWeight.bold,
//                                   color: color,
//                                   fontSize: 13,
//                                   font: fontFamily,
//                                 ),
//                               ),
//                             ),
//                             pw.Text(
//                               '\$ ${invoiceData.discount}',
//                               style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold,
//                                 color: color,
//                                 fontSize: 13,
//                                 font: fontFamily,
//                               ),
//                             ),
//                           ],
//                         ),
//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'VAT :',
//                                 style: pw.TextStyle(
//                                   fontWeight: pw.FontWeight.bold,
//                                   color: color,
//                                   fontSize: 13,
//                                   font: fontFamily,
//                                 ),
//                               ),
//                             ),
//                             pw.Text(
//                               '\$ ${invoiceData.vat}',
//                               style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold,
//                                 color: color,
//                                 fontSize: 13,
//                                 font: fontFamily,
//                               ),
//                             ),
//                           ],
//                         ),
//                         pw.Divider(),
//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'Total amount :',
//                                 style: pw.TextStyle(
//                                   fontSize: 14.0,
//                                   fontWeight: pw.FontWeight.bold,
//                                   color: color,
//                                   font: fontFamily,
//                                 ),
//                               ),
//                             ),
//                             pw.Text(
//                               '\$ ${invoiceData.total}',
//                               style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold,
//                                 color: color,
//                                 fontSize: 14,
//                                 font: fontFamily,
//                               ),
//                             ),
//                           ],
//                         ),
//                         pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                         pw.Container(height: 1, color: PdfColors.grey400),
//                         pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
//                         pw.Container(height: 1, color: PdfColors.grey400),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ];
//         },
//         footer: (context) {
//           return pw.Column(
//             mainAxisSize: pw.MainAxisSize.min,
//             children: [
//               pw.Divider(),
//               pw.SizedBox(height: 2 * PdfPageFormat.mm),
//               pw.Text(
//                 'Shopaholic',
//                 style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     color: color,
//                     font: fontFamily),
//               ),
//               pw.SizedBox(height: 1 * PdfPageFormat.mm),
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.center,
//                 children: [
//                   pw.Text(
//                     'Address: ',
//                     style: pw.TextStyle(
//                         fontWeight: pw.FontWeight.bold,
//                         color: color,
//                         font: fontFamily),
//                   ),
//                   pw.Text(
//                     'Merul Badda, Dhaka 1212',
//                     style: pw.TextStyle(color: color, font: fontFamily),
//                   ),
//                 ],
//               ),
//               pw.SizedBox(height: 1 * PdfPageFormat.mm),
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.center,
//                 children: [
//                   pw.Text(
//                     'Website: ',
//                     style: pw.TextStyle(
//                         fontWeight: pw.FontWeight.bold,
//                         color: color,
//                         font: fontFamily),
//                   ),
//                   pw.Text(
//                     ApiEndpoint.domainUrl,
//                     style: pw.TextStyle(color: color, font: pw.Font.courier()),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//
//     return FileHandleApi.saveDocument(name: 'invoice_from_api.pdf', pdf: pdf);
//   }
// }
//
// String parseTime(String date) {
//   final month = DateFormat('MMMM').format(DateTime.parse(date));
//   final day = DateFormat('d').format(DateTime.parse(date));
//   final year = DateFormat('y').format(DateTime.parse(date));
//   return '$day $month, $year';
// }
