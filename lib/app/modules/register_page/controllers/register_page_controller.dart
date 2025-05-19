import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footware_client/app/model/user/users.dart';
import 'package:get/get.dart';
import 'package:otp_text_field_v2/otp_text_field_v2.dart';

import '../../../common/Snackbar/snackbar.dart';
import '../../../services/services.dart';

class RegisterPageController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  //TODO: Implement RegisterPageController
  TextEditingController nameFeild = TextEditingController();
  TextEditingController mobileFeild = TextEditingController();
  OtpFieldControllerV2 otpController = OtpFieldControllerV2();

  RxBool otpVisible = false.obs;

  int? otpSend;
  int? otpEnter;

  final count = 0.obs;
  @override
  void onInit() {
    userCollection = firestore.collection("users"); // collection mean table
    super.onInit();
  }

  addUsers() async {
    try {
      if (otpEnter == otpSend) {
        if (nameFeild.text.isEmpty || mobileFeild.text.isEmpty) {
          Get.snackbar("Error", "All fields are required", colorText: Colors.red);
          return;
        }
        DocumentReference doc = userCollection.doc();
        Users users = Users(id: doc.id, name: nameFeild.text, number: mobileFeild.text);

        // convert the product into json
        final usersJson = users.toJson();

        doc.set(usersJson);

        Get.snackbar("Success", "Data Added Successfully");

        nameFeild.clear();
        mobileFeild.clear();
        otpController.clear();
        otpVisible.value = false;
        Get.offAllNamed('/home-page');
      } else {
        Snackbars.showSnackbar(
            title: "Submission failed",
            message: "Invalid OTP",
            fontIcon: FontAwesomeIcons.cross);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  otpSendFunction() async {
    try {
      if (nameFeild.text.isEmpty || mobileFeild.text.isEmpty) {
        Get.snackbar("Error", "All fields are required", colorText: Colors.red);
        return;
      }
      var random = Random();
      int otp = 1000 + random.nextInt(9000); // 1000 determines no of digit of otp
      print("Generated OTP: $otp");
      String otpVerify = await Services.otpApi(mobileFeild.text, otp);
      print("OTP Verify: $otpVerify");
      if (otpVerify == "SMS sent successfully.") {
        otpSend = otp;
        Snackbars.showSnackbar(
            title: "Success",
            message: "OTP Send Successfully",
            fontIcon: FontAwesomeIcons.circleRight);
        otpVisible.value = true;
      } else {
        Snackbars.showSnackbar(
            title: "Failure", message: "OTP Not Send!", fontIcon: FontAwesomeIcons.cross);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
