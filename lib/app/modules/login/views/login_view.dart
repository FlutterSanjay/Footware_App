import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footware_client/app/TextFile/textStyles.dart';

import 'package:get/get.dart';

import '../../../common/inputFeild.dart';
import '../../../common/submitButton.dart';
import '../../../common/submmitedButton.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextStyles(
                color: Color(0xff5c23f6),
                text: "Welcome Back!",
                font_Weight: FontWeight.w600,
                size: 28.sp),
            InputFeild(
              keyType: TextInputType.number,
              mobileNumber: controller.mobileNumber,
              icon: Icons.phone_android,
              name: 'Mobile Number',
              errorText: 'Mobile Number must be Correct',
            ),
            SizedBox(
              height: 12.h,
            ),
            ElevatedButton(
              onPressed: () {
                controller.userLogin();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff5c23f6),
              ),
              child: TextStyles(
                  color: Colors.white,
                  text: "Login",
                  font_Weight: FontWeight.w300,
                  size: 14.sp),
            ),
            SizedBox(
              height: 8.h,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/register-page');
              },
              child: SubmitButton(
                text: "Register new account",
              ),
            ),
          ],
        )),
      ),
    );
  }
}
