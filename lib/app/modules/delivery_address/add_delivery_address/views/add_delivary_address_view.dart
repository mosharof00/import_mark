import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/models/address_model.dart';
import 'package:import_mark/global/global_snackbar.dart';
import 'package:import_mark/global/loading_buttoon.dart';
import 'package:import_mark/global/log_printer.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import 'package:import_mark/helper/helper_utils.dart';

import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_input_textformfield.dart';
import '../../../../../global/app_text_style.dart';

import '../../../../../helper/appbar_title.dart';
import '../controllers/add_delivary_address_controller.dart';

class AddDeliveryAddressView extends GetView<AddDeliveryAddressController> {
  const AddDeliveryAddressView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controller = Get.put(AddDeliveryAddressController());
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        title: appbarTitle(text: 'Add Address Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextStyle(
                  text: 'Address Title',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                3.height,
                AppInputTextFormField(
                  controller: controller.addressTitleTextController,
                  hintText: 'Enter Address Title',
                  fontSize: 11.sp,
                  borderRadius: 15,
                  fillColor: Colors.white,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().isEmpty) {
                      return 'Please enter a Address';
                    }
                    return null;
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                5.height,
                AppTextStyle(
                  text: 'Name',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                3.height,
                AppInputTextFormField(
                  controller: controller.nameTextController,
                  hintText: 'Enter Receipt Name',
                  fontSize: 11.sp,
                  borderRadius: 15,
                  fillColor: Colors.white,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().isEmpty) {
                      return 'Please enter a Receipt';
                    }
                    return null;
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                5.height,
                AppTextStyle(
                  text: 'Phone No.',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                3.height,
                AppInputTextFormField(
                  controller: controller.phoneTextController,
                  hintText: 'Enter Phone No.',
                  keyboardType: TextInputType.number,
                  fontSize: 11.sp,
                  borderRadius: 15,
                  fillColor: Colors.white,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().isEmpty) {
                      return 'Please enter a Phone number';
                    }
                    return null;
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                5.height,
                AppTextStyle(
                  text: 'Email',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                3.height,
                AppInputTextFormField(
                  controller: controller.emailTextController,
                  hintText: 'Enter Email Address',
                  fontSize: 11.sp,
                  borderRadius: 15,
                  fillColor: Colors.white,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().isEmpty) {
                      return 'Please enter a Email';
                    } else {
                      final emailRegex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                    }
                    return null;
                  },
                ),
                5.height,
                AppTextStyle(
                  text: 'City',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                3.height,
                AppInputTextFormField(
                  controller: controller.cityTextController,
                  hintText: 'Ex. Dhaka',
                  fontSize: 11.sp,
                  borderRadius: 15,
                  maxLines: 3,
                  // maxLength: 200,
                  fillColor: Colors.white,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().isEmpty) {
                      return 'Please enter a City';
                    }
                    return null;
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                5.height,
                AppTextStyle(
                  text: 'District',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                3.height,
                AppInputTextFormField(
                  controller: controller.districtTextController,
                  hintText: 'Ex. Dhaka',
                  fontSize: 11.sp,
                  borderRadius: 15,
                  maxLines: 3,
                  // maxLength: 200,
                  fillColor: Colors.white,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().isEmpty) {
                      return 'Please enter a District';
                    }
                    return null;
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                5.height,
                AppTextStyle(
                  text: 'Area',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                3.height,
                AppInputTextFormField(
                  controller: controller.areaTextController,
                  hintText: 'Enter Your Area',
                  fontSize: 11.sp,
                  borderRadius: 15,
                  maxLines: 3,
                  // maxLength: 200,
                  fillColor: Colors.white,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().isEmpty) {
                      return 'Please enter a Area';
                    }
                    return null;
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                5.height,
                AppTextStyle(
                  text: 'Address',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                3.height,
                AppInputTextFormField(
                  controller: controller.addressTextController,
                  hintText: 'Enter Delivery Address',
                  fontSize: 11.sp,
                  borderRadius: 15,
                  maxLines: 3,
                  // maxLength: 200,
                  fillColor: Colors.white,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().isEmpty) {
                      return 'Please enter a Address';
                    }
                    return null;
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                10.height,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: loadingButton(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  ///   for update address
                  if (controller.isUpdating.value) {
                    Log.i(
                        "Existing address id: ${controller.address.value!.id}");
                    controller.updateAddress(Address(
                        id: controller.address.value!.id,
                        addressTitle:
                            controller.addressTitleTextController.text,
                        name: controller.nameTextController.text,
                        phone: controller.phoneTextController.text,
                        email: controller.emailTextController.text,
                        city: controller.cityTextController.text,
                        district: controller.districtTextController.text,
                        area: controller.areaTextController.text,
                        address: controller.addressTextController.text));
                  } else {
                    ///   for add a new address
                    controller.addAddress(Address(
                        id: HelperUtils.getUuId(),
                        addressTitle:
                            controller.addressTitleTextController.text,
                        name: controller.nameTextController.text,
                        phone: controller.phoneTextController.text,
                        email: controller.emailTextController.text,
                        city: controller.cityTextController.text,
                        district: controller.districtTextController.text,
                        area: controller.areaTextController.text,
                        address: controller.addressTextController.text));
                  }
                } else {
                  controller.btnController.stop();
                  globalSnackBar(
                      title: "Message!",
                      message: "Please enter all required feeds");
                }
              },
              controller: controller.btnController,
              text: "Saved")),
    );
  }
}
