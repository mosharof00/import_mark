import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/modules/register/controllers/register_controller.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';

class AgreeTerm extends StatelessWidget {
  const AgreeTerm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Row(
      children: [
        Obx(() {
          if (controller.isAgree.value) {
            return boxChecked(onTap: () {
              controller.isAgree.value = false;
            });
          } else {
            return boxUnChecked(onTap: () {
              controller.isAgree.value = true;
              debugPrint(controller.isAgree.value.toString());
            });
          }
        }),
        15.width,
        AppTextStyle(
          text: 'I agree to Tutors Plan',
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
        AppTextStyle(
          text: ' Terms & Conditions.',
          color: ColorName.primaryColor,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

Widget boxChecked({required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 15.h,
      width: 15.w,
      decoration: BoxDecoration(
        color: ColorName.primaryColor,
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: const Center(
        child: Icon(Icons.check, color: Colors.white, size: 15),
      ),
    ),
  );
}

Widget boxUnChecked({required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 15.h,
      width: 15.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.r),
        border: Border.all(width: 1.w, color: ColorName.primaryColor),
      ),
    ),
  );
}
