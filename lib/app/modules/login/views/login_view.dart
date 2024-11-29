import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:import_mark/global/log_printer.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_input_textformfield.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/loading_buttoon.dart';
import '../../../routes/app_pages.dart';
import '../../register/widgets/app_input_with_title.dart';
import '../controllers/login_controller.dart';
import '../widgets/login_UI_helper.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final  formKey = GlobalKey<FormState>();
    Get.put(LoginController);
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
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
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
                    30.height,
                    AppTextStyle(
                      text: 'Welcome \nBack!',
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.start,
                    ),
                    30.height,
                    AppTextStyle(
                      text: 'Email',
                      textAlign: TextAlign.start,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    5.height,
                    AppInputTextFormField(
                      controller: controller.emailEditingController,
                      focusedBorderColor: ColorName.primaryColor,
                      hintText: 'Email',
                      errorTextColor: ColorName.textFieldErrorColor,
                      errorBorderColor: ColorName.textFieldErrorColor,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
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
                    15.height,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppTextStyle(
                        text: 'Password',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    5.height,
                    Password(
                      controller: controller,
                      textFieldController: controller.passEditingController,
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
                    Row(
                      children: [
                        Obx(() {
                          if (controller.boxCheck.value) {
                            return boxUnChecked(onTap: () {
                              controller.boxCheck.value = false;
                            });
                          } else {
                            return boxChecked(onTap: () {
                              controller.boxCheck.value = true;
                            });
                          }
                        }),
                        10.width,
                        AppTextStyle(
                          text: 'Remember Me',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.FORGOT_PASSWORD);
                          },
                          child: AppTextStyle(
                            text: 'Forgot Password?',
                            color: ColorName.primaryColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    // 25.height,
                    // // orPart(),
                    // 25.height,
                    // signInOption(
                    //   onTap: () {
                    //     Get.find<LoginController>().signInWithGoogle();
                    //   },
                    //   icon: Assets.icons.googleIcon,
                    //   text: 'Continue with Google',
                    // ),
                    30.height,
                    loadingButton(
                      controller: controller.btnController,
                      valueColor: Colors.white,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          controller.logIn(
                            email: controller.emailEditingController.text,
                            password: controller.passEditingController.text,
                          );
                        } else {
                          controller.btnController.stop();
                          Log.i("Ontapped");
                        }
                      },
                      text: "Login",
                    ),
                    20.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppTextStyle(text: "Don't have an account?"),
                        CupertinoButton(
                          onPressed: () {
                            Get.toNamed(Routes.REGISTER);
                          },
                          child: AppTextStyle(
                            text: "Sign Up",
                            color: ColorName.primaryColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    // 15.height,
                    // orPart(),
                    // 15.height,
                    // loadingButton(
                    //   onTap: () {
                    //    // final registerController = Get.put(RegisterController());
                    //    // registerController.signUpOrInWithGoogle();
                    //   },
                    //   controller: controller.btnController,
                    //   valueColor: ColorName.white,
                    //   fontSize: 16.sp,
                    //   fontWeight: FontWeight.w600,
                    //   text: 'Continue with Google',
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Center(
                    //         child: AppTextStyle(
                    //           text: 'Continue with Google',
                    //           textAlign: TextAlign.center,
                    //           color:  Colors.white,
                    //           fontSize:  18.sp,
                    //           fontWeight:  FontWeight.w600,
                    //         ),
                    //       ),
                    //     ],
                    //   )
                    // ),
                    50.height,
                  ],
                ),
              ),
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
