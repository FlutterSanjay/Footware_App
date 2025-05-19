import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class InputFeild extends StatelessWidget {
  const InputFeild({
    super.key,
    required this.keyType,
    required this.mobileNumber,
    required this.icon,
    this.maxInput = 10,
    required this.name,
    required this.errorText,
  });
  final TextInputType keyType;
  final int maxInput;
  final TextEditingController mobileNumber;
  final IconData icon;
  final String name;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      width: Get.width * 0.90,
      child: TextFormField(
        onTapOutside: (_) => FocusManager.instance.primaryFocus!.unfocus(),
        autovalidateMode: AutovalidateMode.always,
        controller: mobileNumber,
        keyboardType: keyType,
        maxLength: maxInput,
        enableSuggestions: true,
        decoration: InputDecoration(
            helperText: errorText,
            helperStyle: TextStyle(color: Color(0x5C000000), fontStyle: FontStyle.italic),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Color(0xff5c23f6))),
            prefixIcon: Icon(icon),
            labelText: name,
            border: OutlineInputBorder(borderRadius: BorderRadius.zero)),
      ),
    );
  }
}
