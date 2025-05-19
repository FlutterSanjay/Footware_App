import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get_storage/get_storage.dart';

class DropMenu extends StatelessWidget {
  DropMenu({
    super.key,
    required this.itemController,
    required this.alignment,
    required this.sortfunction, // sort function for main list
    required this.dropController,
    required this.changeDropItemSelect,
  });

  List<String> itemController; // main list
  VoidCallback sortfunction;
  var dropController;
  void Function(String value) changeDropItemSelect;

  var alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: Get.width * 0.47,
        height: Get.height * 0.05,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white30,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(40),
                blurRadius: 0,
                spreadRadius: 1,
                offset: Offset(0, 2),
              )
            ]),
        alignment: Alignment.center,
        padding: EdgeInsets.all(2.w),
        child: Obx(
          () => DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              focusColor: Colors.white,

              padding: EdgeInsets.all(1.w),
              borderRadius: BorderRadius.circular(8.r),
              iconEnabledColor: Theme.of(context).hintColor,
              // dropdownColor: Color(0x5F000000)
              dropdownColor: Colors.white,
              alignment: Alignment.bottomCenter,

              items: itemController.toSet().map((String value) {
                return DropdownMenuItem<String>(
                  alignment: Alignment.center,
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  changeDropItemSelect(newValue);
                  sortfunction();
                }
              },
              value: dropController,
            ),
          ),
        ),
      ),
    );
  }
}
