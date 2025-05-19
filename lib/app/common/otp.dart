import "package:flutter/material.dart";
import "package:otp_text_field_v2/otp_field_v2.dart";

class Otp extends StatelessWidget {
  const Otp(
      {super.key,
      required this.isVisible,
      required this.otpController,
      required this.otpReceive});
  final bool isVisible;
  final OtpFieldControllerV2 otpController;
  final Function(String?) otpReceive;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: OTPTextFieldV2(
        controller: otpController,
        length: 4,
        width: MediaQuery.of(context).size.width,
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldWidth: 45,
        fieldStyle: FieldStyle.box,
        outlineBorderRadius: 8,
        style: TextStyle(fontSize: 17),
        onChanged: (pin) {
          print("Changed: " + pin);
        },
        onCompleted: (pin) {
          otpReceive(pin);
        },
      ),
    );
  }
}
