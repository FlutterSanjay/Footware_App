import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:footware_client/app/TextFile/textStyles.dart';
import 'package:footware_client/app/common/colors.dart';
import 'package:footware_client/app/common/otp.dart';
import 'package:footware_client/app/modules/login/views/login_view.dart';

import 'package:get/get.dart';

import '../../../common/inputFeild.dart';
import '../../../common/submitButton.dart';
import '../../../common/submmitedButton.dart';
import '../controllers/register_page_controller.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  const RegisterPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterButtons: [
          Center(
            child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(children: [
                  TextSpan(text: "By continuing, You agree our "),
                  TextSpan(
                      text: "Terms and Service ",
                      style: TextStyle(
                          decorationColor: CupertinoColors.activeBlue,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: CupertinoColors.activeBlue))
                ])),
          )
        ],
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextStyles(
                  color: AllColor.allTextColor,
                  text: "Create Your Account !!",
                  font_Weight: FontWeight.bold,
                  size: 28.sp),
              InputFeild(
                keyType: TextInputType.text,
                mobileNumber: controller.nameFeild,
                icon: Icons.phone_android,
                name: 'Your Name',
                maxInput: 20,
                errorText: "Please ensure the name is no longer than 20 characters.",
              ),
              InputFeild(
                keyType: TextInputType.number,
                mobileNumber: controller.mobileFeild,
                icon: Icons.phone_android,
                name: 'Enter your Mobile number',
                errorText: 'Mobile Number must be Correct',
              ),
              SizedBox(
                height: 15.h,
              ),
              Obx(
                () => Otp(
                  isVisible: controller.otpVisible.value,
                  otpController: controller.otpController,
                  otpReceive: (otp) {
                    controller.otpEnter = int.tryParse(otp!);
                  },
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Obx(
                () => SubmittingButton(
                  text: controller.otpVisible.value ? "Register" : "Send OTP",
                  controller: controller,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              InkWell(
                onTap: () {
                  Get.offNamed('/home');
                },
                child: SubmitButton(
                  text: "Login",
                ),
              ),
            ],
          ),
        )));
  }
}
