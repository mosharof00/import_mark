import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:import_mark/app/modules/login/widgets/login_UI_helper.dart';

import '../../../../global/global_snackbar.dart';
import '../../../../global/label_text.dart';
import '../../../../global/log_printer.dart';
import '../../../../helper/config.dart';
import '../controllers/register_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_input_textformfield.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/loading_buttoon.dart';
import '../../../routes/app_pages.dart';
import '../widgets/agree_terms.dart';
import '../widgets/app_input_with_title.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(RegisterController);
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorName.bgColor,
        // appBar: AppBar(
        //   backgroundColor: ColorName.bgColor,
        //   title: Image.asset(Assets.images.vendorLogo.path,
        //   height: 80.h,
        //     width: 80.w,
        //   ),
        //   centerTitle: true,
        // ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    Assets.images.logo.path,
                    height: 150.h,
                    width: 150.w,
                  ),
                ),
                20.height,
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppTextStyle(
                    text: 'Welcome to Import Mart.',
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.start,
                  ),
                ),
                23.height,
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppInputTitle(
                        controller: controller.nameEditingController,
                        label: 'Full Name',
                        hintText: 'Full Name',
                        validatorText: 'Please enter a Name',
                      ),
                    ],
                  ),
                ),
                15.height,
                labels(text: 'Email'),
                AppInputTextFormField(
                  controller: controller.emailEditingController,
                  focusedBorderColor: ColorName.primaryColor,
                  hintText: 'Email',
                  errorTextColor: ColorName.textFieldErrorColor,
                  errorBorderColor: ColorName.textFieldErrorColor,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  autoValidateMode: AutovalidateMode.disabled,
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
                15.height,
                labels(text: 'Password'),
                10.height,
                Password(
                  controller: controller,
                  textFieldController: controller.passwordEditingController,
                  hidePassword: controller.hidePassword,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                10.height,
                labels(text: 'Confirm Password'),
                5.height,
                Password(
                  controller: controller,
                  textFieldController:
                      controller.confirmPasswordEditingController,
                  hidePassword: controller.hideConfirmPassword,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().isEmpty) {
                      return 'Please enter Confirm Password';
                    } else if (value !=
                        controller.passwordEditingController.text) {
                      return 'Password dit not match';
                    } else {
                      return null;
                    }
                  },
                ),
                10.height,
                const AgreeTerm(),
                30.height,
                Obx(() {
                  return loadingButton(
                      controller: controller.btnController,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (controller.isAgree.value) {
                            controller.signUp();
                          } else {
                            globalSnackBar(
                                durationInSeconds: 2,
                                title: 'Message',
                                message: 'Please Agree to Terms & Condition');
                          }
                        } else {
                          globalSnackBar(
                            title: 'Message',
                            message: 'Please enter all required feeds',
                            durationInSeconds: 2,
                          );
                        }
                        controller.btnController.stop();
                      },
                      text: 'Sign Up',
                      width: Get.width,
                      color: controller.isAgree.value
                          ? ColorName.primaryColor
                          : ColorName.gray410);
                }),

                10.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppTextStyle(text: "Don't have an account?"),
                    CupertinoButton(
                      onPressed: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      child: AppTextStyle(
                        text: "Sign In",
                        color: ColorName.primaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget signInOption(
    {required VoidCallback onTap, required String icon, required String text}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 40.h,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: const Color(0xFFdee2e6), width: 1.w)),
      child: Row(
        children: [
          10.width,
          SvgPicture.asset(
            icon,
            width: 25.w,
          ),
          Expanded(
            child: AppTextStyle(
              text: text,
              textAlign: TextAlign.center,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          30.width
        ],
      ),
    ),
  );
}
