import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles extends StatelessWidget {
  String? text;
  Color color = Colors.black;
  FontWeight font_Weight = FontWeight.normal;
  double size = 12;
  int numberLine;

  TextStyles(
      {super.key,
      required this.color,
      required this.text,
      required this.font_Weight,
      this.numberLine = 1,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
        overflow: TextOverflow.ellipsis,
        maxLines: numberLine,
        text!,
        style: GoogleFonts.roboto(
          textStyle: TextStyle(color: color, fontWeight: font_Weight, fontSize: size),
        ));
  }
}
