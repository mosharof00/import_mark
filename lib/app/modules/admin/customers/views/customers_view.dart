import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:import_mark/global/staggered_scale_list_animation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/models/foods_product_model.dart';
import 'package:import_mark/global/sizedbox_extension.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/cached_network_image_builder.dart';
import '../../../../../global/loading_animation_widget.dart';
import '../../../../../global/not_search_items_found_widget.dart';
import '../../../../../helper/appbar_title.dart';
import '../controllers/customers_controller.dart';

class CustomersView extends GetView<CustomersController> {
  const CustomersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Customers'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return loadingAnimationWidget();
        } else if (controller.customerList.isEmpty) {
          return NotSearchedItemFoundWidget(
            iconSvgPath: Assets.images.emptySearch,
            heightLogo: 150.h,
            widthLogo: 150.w,
            title: 'Empty Customer',
            description: "No Customers have been added yet.",
          );
        } else {
          return ListView.builder(
            itemCount:
                controller.customerList.length, // Assuming you have 10 items
            itemBuilder: (context, index) {
              final Meal customers = controller.customerList[index];
              return StaggeredScaleListAnimation(
                positionIndex: index,
                child: Container(
                  // padding:  EdgeInsets.all(15.r), // Padding inside the card
                  margin: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 8.h), // Margin around the card
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        blurRadius: 5, // Softness of the shadow
                        spreadRadius: 5, // Spread radius
                        offset: const Offset(0, 5), // Vertical offset
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(15.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Header Row (Name, Call Button, More Options)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  circularImage(
                                      imgUrl:
                                          "https://i.pinimg.com/564x/8b/11/a8/8b11a86980c64720a41ec22332a83115.jpg"),
                                  5.width,
                                  // User name and email
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextStyle(
                                        text: 'Mosharof Khan',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextStyle(
                                        text: 'mosharof5khan@gmail.com',
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                        color: ColorName.gray410,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              8.height, // Space between header and content
                              Container(
                                  color: Colors.grey.shade300,
                                  height: 1.h,
                                  width: Get.width),
                              8.height,
                              // User contact details
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.phone,
                                          color: Colors.blueAccent, size: 18),
                                      10.width,
                                      AppTextStyle(
                                        text: "+8801314859997",
                                        fontSize: 14.sp,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                  8.height,
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          color: Colors.redAccent, size: 18),
                                      10.width,
                                      AppTextStyle(
                                        text: "Dhaka",
                                        fontSize: 14.sp,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          // More Options Button
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                // Handle edit action
                                print('Edit action clicked');
                              } else if (value == 'delete') {
                                // Handle delete action
                                print('Delete action clicked');
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return {'Edit', 'Delete'}.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice.toLowerCase(),
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                            icon: const Icon(Icons.more_vert,
                                color: Colors.black54),
                          ),

                          /// Call Button
                          5.height,
                          IconButton(
                            icon: const Icon(Icons.call, color: Colors.green),
                            onPressed: () async {
                              makePhoneCall('+8801314859997');
                              // await FlutterPhoneDirectCaller.callNumber('+8801521226758');
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}

/// Function to make phone call
Future<void> makePhoneCall(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: "tel", path: phoneNumber);
  try {
    await launchUrl(phoneUri);
  } catch (error) {
    throw ("Cannot dial");
  }
}
