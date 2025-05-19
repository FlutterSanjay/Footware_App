import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../TextFile/textStyles.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.text,
  });
  final String? text;

  // void Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return TextStyles(
        color: Color(0xff5c23f6), text: text, font_Weight: FontWeight.w400, size: 12.sp);
  }
}
