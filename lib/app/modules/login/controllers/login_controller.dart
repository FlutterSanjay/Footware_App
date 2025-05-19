import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footware_client/app/common/Snackbar/snackbar.dart';
import 'package:footware_client/app/model/user/users.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  // first Intialized getStorage in main .dart
  GetStorage box = GetStorage(); // get storage use as Share preferences
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userReference;
  //TODO: Implement HomeController
  TextEditingController mobileNumber = TextEditingController();

  @override
  void onInit() {
    userReference = firestore.collection("users");
    super.onInit();
  }

  userLogin() async {
    try {
      if (mobileNumber.text.isEmpty) {
        Snackbars.showSnackbar(
            title: "Mandatory",
            message: "All fields required",
            fontIcon: FontAwesomeIcons.rectangleXmark);
        return;
      } else {
        var querySnapshot = await userReference
            .where('number', isEqualTo: mobileNumber.text)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var userDoc = querySnapshot.docs.first;
          var userData = userDoc.data() as Map<String, dynamic>;
          box.write("loginData", userData);
          Get.offAllNamed('/home-page');

          Get.snackbar("Success", "Login Successful", colorText: Colors.green);
          mobileNumber.clear();
        } else {
          Get.snackbar("Alert!", "Please Register to Proceed", colorText: Colors.red);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Direct Login once Login
  Users? loginUser;
  @override
  void onReady() {
    Map<String, dynamic>? user = box.read('loginData');
    if (user != null) {
      print(user['id']);
      loginUser = Users.fromJson(user); // map to json
      print('User Login Data :${loginUser?.toJson()}');
      Get.offAllNamed('/home-page');
    }
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
