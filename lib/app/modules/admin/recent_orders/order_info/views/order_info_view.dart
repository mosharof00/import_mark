import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:import_mark/app/models/foods_product_model.dart';
import 'package:import_mark/global/app_text_style.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../../global/app_text_style_over_flow.dart';
import '../../../../../../global/awesome_alert_dialog.dart';
import '../../../../../../global/cached_network_image_builder.dart';
import '../../../../../../global/divider.dart';
import '../../../../../../global/global_button.dart';
import '../../../../../../global/methods/order_status_color.dart';
import '../../../../../../global/parse_dateAndTime.dart';
import '../../../../../../helper/appbar_title.dart';
import '../../../../orders/widgets/order_details_hellper_container.dart';
import '../../../sales_summary/widgets/product_labels.dart';
import '../../widget/recent_order_list.dart';
import '../controllers/order_info_controller.dart';
import '../widget/order_products.dart';

class OrderInfoView extends GetView<OrderInfoController> {
  const OrderInfoView({super.key});
  @override
  Widget build(BuildContext context) {
    final Meal order = Get.arguments['order'];
    final orderStatus = Get.arguments['status'];
    controller.newStatus.value = orderStatus;
    controller.updateActiveStep(status: controller.newStatus.value);
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Order Info'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              orderStatus == 'Cancelled' ||
                      orderStatus == 'Rejected' ||
                      orderStatus == 'Returned'
                  ? 0.height
                  : Obx(() => IconStepper(
                        enableStepTapping: false,
                        icons: [
                          Icon(
                            MdiIcons.archiveClockOutline,
                            color: ColorName.white,
                          ),
                          Icon(
                            MdiIcons.packageVariantClosed,
                            color: ColorName.white,
                          ),
                          Icon(
                            MdiIcons.packageVariantClosedCheck,
                            color: ColorName.white,
                          ),
                        ],
                        stepReachedAnimationEffect: Curves.bounceOut,
                        activeStep: controller.activeStep.value,
                        stepColor: ColorName.gray70,
                        activeStepColor: controller.headerColor(),
                        activeStepBorderColor: controller.headerColor(),
                        activeStepBorderWidth: 1,
                        lineColor: ColorName.green,
                        enableNextPreviousButtons: false,
                        onStepReached: (index) {
                          controller.activeStep.value = index;
                        },
                      )),
              10.height,
              Material(
                borderRadius: BorderRadius.circular(15.r),
                elevation: 2,
                child: Container(
                  height: 130.h,
                  width: Get.width,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: ColorName.white,
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Stack(
                                children: List.generate(
                                  // order.orderproducts!.length,
                                  1,
                                  (index) {
                                    return Positioned(
                                      top: index <= 3 ? index * 2.h : 6.h,
                                      left: index <= 3 ? index * 3.w : 9.w,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorName.white,
                                              width: 1.5.w),
                                        ),
                                        child: cachedImageHelper(
                                          imgurl: order.strMealThumb!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            5.width,
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Row(children: [
                                      userInfoRecentOrders(
                                        icon: Icons.token_outlined,
                                        text: "24jhg345gk4",
                                        fontSize: 14.sp,
                                        color: Colors.black87,
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () async {
                                          if (controller.isSelect.value) {
                                            controller.isSelect.value = false;
                                          } else {
                                            controller.isSelect.value = true;
                                            const String textToCopy =
                                                "24jhg345gk4";
                                            if (textToCopy.isNotEmpty) {
                                              try {
                                                await Clipboard.setData(
                                                    const ClipboardData(
                                                        text: textToCopy));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: const AppTextStyle(
                                                        text:
                                                            'Copied to Clipboard!'),
                                                    backgroundColor: ColorName
                                                        .white
                                                        .withOpacity(0.5),
                                                    duration: const Duration(
                                                        microseconds: 200),
                                                  ),
                                                );
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'Failed to copy to clipboard.')),
                                                );
                                              }
                                            }
                                          }
                                        },
                                        child: Icon(
                                          controller.isSelect.value
                                              ? Icons.check
                                              : Icons.copy,
                                          size: 18,
                                        ),
                                      )
                                    ]),
                                  ),
                                  5.height,
                                  userInfoRecentOrders(
                                    icon: FontAwesomeIcons.calendar,
                                    text: DateTimeUtils.parseDate(
                                      "2024-10-01T00:00:00.000000Z",
                                    ),
                                    fontSize: 14.sp,
                                    color: Colors.black87,
                                  ),
                                  5.height,
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: Obx(
                                      () => LabelContainer(
                                        labelTitle: controller.newStatus.value,
                                        containerColor:
                                            OrderStatusColor.getColor(
                                                controller.newStatus.value),
                                        containerHeight: 35.h,
                                        containerWidth: 150.w,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            height: 18.h,
                            width: 18.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: Center(
                              child: AppTextStyle(
                                text: 1.toString(),
                                color: ColorName.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              15.height,
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(15.r),
                child: Container(
                  // height: 120.h,
                  width: Get.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: ColorName.white,
                  ),
                  child: SizedBox(
                    width: 0.2.sw,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        circularImage(
                            imgUrl:
                                'https://i.pinimg.com/736x/8d/de/f6/8ddef6e048aa4fbd04f7949103ffc943.jpg',
                            radius: 35.r,
                            imgHeight: 70.h,
                            imgWidth: 70.w,
                            imgRadius: 50.r),
                        5.width,
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Container(
                            height: 90.h,
                            width: 1.w,
                            color: ColorName.gray70,
                          ),
                        ),
                        5.width,
                        SizedBox(
                          width: 0.63.sw,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  userInfoRecentOrders(
                                      icon: FontAwesomeIcons.user,
                                      text: 'Mosharof',
                                      fontSize: 12.sp),
                                ],
                              ),
                              3.height,
                              userInfoRecentOrders(
                                  icon: FontAwesomeIcons.coins,
                                  text: "50,000".toString(),
                                  fontSize: 12.sp),
                              3.height,
                              userInfoRecentOrders(
                                  icon: Icons.add_box_rounded,
                                  text: 1.toString(),
                                  fontSize: 12.sp),
                              3.height,
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
                                  SizedBox(
                                    width: 0.55.sw,
                                    child: AppTextStyleOverFlow(
                                      text: 'Dhaka',
                                      textAlign: TextAlign.start,
                                      fontSize: 12.sp,
                                      maxLines: 2,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              10.height,
              OrderProducts(order: order),
              10.height,
              Obx(() {
                controller.getPaymentMethod('Cash On Delivery');
                return orderDetailsHelperContainer(
                  showIcon: false,
                  onPressed: () {},
                  icon: Icon(
                    MdiIcons.creditCardOutline,
                    color: Colors.green,
                  ),
                  text: 'Payment Methods',
                  leading: circularImage(
                      imgUrl: controller.image.value,
                      radius: 22.r,
                      imgRadius: 50.r),
                  titleText: controller.gateway.value,
                  subtitleText: '',
                  isTrailing: true,
                  trailWidget: Container(
                    decoration: BoxDecoration(
                        color: 'due' == "due"
                            ? ColorName.crimsonRed
                            : Colors.green,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      child: AppTextStyle(
                        text: 'Confirm',
                        color: ColorName.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }),
              // order.couriers == null
              //     ? 0.height
              //     : Column(
              //   children: [
              //     15.height,
              //     helperContainer(
              //       icon: Icon(
              //         MdiIcons.truckDelivery,
              //         color: Colors.green,
              //       ),
              //       text: 'Courier',
              //       leading: circularImage(
              //           imgUrl: order.couriers!.image!,
              //           radius: 22.r,
              //           imgRadius: 50.r),
              //       titleText: order.couriers!.courierName!,
              //       subtitleText: order.hubName!,
              //       isTrailing: false,
              //     ),
              //   ],
              // ),
              10.height,
              orderDetailsHelperContainer(
                icon: Icon(
                  MdiIcons.brightnessPercent,
                  color: Colors.green,
                ),
                text: 'Discount',
                leading: Icon(
                  MdiIcons.brightnessPercent,
                  color: Colors.white,
                ),
                titleText: 'No Promos Selected',
                subtitleText: '',
                isTrailing: false,
              ),
              10.height,
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
                        leadingText: '${'Subtotal'.tr} \$ 50,000 ${'Item'.tr})',
                        thrillingText: '+ 50,000'),
                    5.height,
                    summaryOptionsRow(
                        leadingText: 'Shipping Charge', thrillingText: '+ 300'),
                    5.height,
                    summaryOptionsRow(
                        leadingText: 'Discount', thrillingText: '- 2000'),
                    5.height,
                    summaryOptionsRow(
                        leadingText: 'Tax', thrillingText: '+ \$ 400'),
                    5.height,
                    summaryOptionsRow(
                        leadingText: 'Vat', thrillingText: '+ \$ 500'),
                    5.height,
                    customDivider(paddingHorizontal: 0),
                    5.height,
                    Obx(() {
                      return summaryOptionsRow(
                        leadingText: 'Total',
                        fontSizeLeadingText: 15.sp,
                        fontWeightLeadingText: FontWeight.w500,
                        thrillingText: '\$ ${controller.totalSum(
                          "50000",
                          '500',
                          '4000',
                        )}',
                        fontSizeThrillingText: 18.sp,
                        fontWeightThrillingText: FontWeight.w600,
                      );
                    }),
                    80.height,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      ///    for  Cancel  Or  Accept  bottomNavigationBar
      bottomNavigationBar: orderStatus == 'Cancelled' ||
              orderStatus == 'Rejected' ||
              orderStatus == 'Returned'
          ? 0.height
          : Obx(() => Visibility(
                visible: controller.activeStep.value == 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          awesomeAlertDialog(
                              context,
                              DialogType.question,
                              'Want to Reject the Order?',
                              'Are you Sure?',
                              'No',
                              () {},
                              'Yes', () {
                            // controller.fetchChangeAdminOrderStatus(
                            //     invoiceId: order.invoiceId!,
                            //     status: 'Rejected');
                          }, true);
                        },
                        child: Container(
                          height: 45.h,
                          width: Get.width / 2.2,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(50.r)),
                          child: Center(
                            child: AppTextStyle(
                              text: 'Reject',
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      globalButton(
                          onTap: () {
                            awesomeAlertDialog(
                                context,
                                DialogType.question,
                                'Want to Accept the Order?',
                                'Are you Sure?',
                                'No',
                                () {},
                                'Yes', () {
                              controller.fetchChangeAdminOrderStatus(
                                  invoiceId: "24jhg345gk4",
                                  status: 'Confirmed');
                            }, true);
                          },
                          text: 'Accept',
                          width: Get.width / 2.2),
                    ],
                  ),
                ),
              )),

      ///   for Change Status
      floatingActionButton: orderStatus == 'Cancelled' ||
              orderStatus == 'Rejected'
          ? 0.height
          : Obx(() => Visibility(
                visible: controller.activeStep.value == 1 ||
                    controller.activeStep.value == 2 ||
                    controller.activeStep.value == 3,
                child: Container(
                  height: 40.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: controller.buttonColor(),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (controller.activeStep.value == 3) {
                        Get.back();
                      } else {
                        awesomeAlertDialog(
                            context,
                            DialogType.question,
                            'Want to Change the Status?',
                            'Are you Sure?',
                            'No',
                            () {},
                            'Yes', () {
                          controller.fetchChangeAdminOrderStatus(
                              invoiceId: '24jhg345gk4',
                              status: controller.newStatus.value == 'Confirmed'
                                  ? 'Ongoing'
                                  : controller.newStatus.value == 'Ongoing'
                                      ? 'Delivered'
                                      : 'Pending');
                        }, true);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextStyle(
                              text: controller.buttonText(),
                              fontSize: 14.sp,
                              color: ColorName.white),
                          const Icon(
                            Icons.arrow_forward,
                            color: ColorName.white,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
    );
  }
}
