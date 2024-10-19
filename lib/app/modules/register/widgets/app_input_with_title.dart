import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_input_textformfield.dart';
import '../../../../global/app_text_style.dart';

class AppInputTitle extends StatelessWidget {
  const AppInputTitle({
    super.key,
    required this.label,
    this.textInputType,
    this.hintText,
    this.controller,
    this.validatorText,
    this.maxLines,
    this.onFieldSubmitted,
  });
  final String label;
  final TextInputType? textInputType;
  final String? hintText;
  final TextEditingController? controller;
  final String? validatorText;
  final int? maxLines;
  final void Function(String?)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(
          text: label,
          textAlign: TextAlign.start,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        5.height,
        AppInputTextFormField(
          controller: controller,
          focusedBorderColor: ColorName.primaryColor,
          hintText: hintText ?? label,
          maxLines: maxLines,
          // fillColor: Colors.grey.shade100,
          // borderColor: Colors.transparent,
          errorTextColor: ColorName.textFieldErrorColor,
          errorBorderColor: ColorName.textFieldErrorColor,
          obscureText: false,
          keyboardType: textInputType,
          onFieldSubmitted: onFieldSubmitted,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty || value.trim().isEmpty) {
              return validatorText;
            }
            return null;
          },
        ),
      ],
    );
  }
}

class Password extends StatelessWidget {
  const Password(
      {super.key,
      required this.controller,
      required this.hidePassword,
      this.textFieldController,
      this.validator});
  final GetxController controller;
  final RxBool hidePassword;
  final TextEditingController? textFieldController;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => AppInputTextFormField(
            controller: textFieldController,
            maxLines: 1,
            focusedBorderColor: ColorName.primaryColor,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            // fillColor: Colors.grey.shade100,
            // borderColor: Colors.transparent,
            errorTextColor: ColorName.textFieldErrorColor,
            errorBorderColor: ColorName.textFieldErrorColor,
            obscureText: hidePassword.value,
            suffixIcon: hidePassword.value
                ? InkWell(
                    onTap: () {
                      hidePassword.value = false;
                    },
                    child: Icon(MdiIcons.eyeOff),
                  )
                : InkWell(
                    onTap: () {
                      hidePassword.value = true;
                    },
                    child: Icon(MdiIcons.eye),
                  ),
            hintText: 'Password',
            validator: validator,
          ),
        ),
      ],
    );
  }
}
