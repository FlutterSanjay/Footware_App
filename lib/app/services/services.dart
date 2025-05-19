import 'dart:convert';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footware_client/app/common/Snackbar/snackbar.dart';
import 'package:http/http.dart' as http;

class Services {
  static Future<String> otpApi(String number, int otp) async {
    try {
      String api_key =
          "u6K0aUyT1gFm4k5XnIQN8btBjGcA9xPpdofwEMvRiWZrJzsShe95APpY3aozfDsrxyFE1GjQ7nTkJed2";
      String url =
          "https://www.fast2sms.com/dev/bulkV2?authorization=$api_key&route=otp&variables_values=$otp&flash=0&numbers=$number&schedule_time=";

      var response =
          await http.get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonBody = jsonDecode(response.body.toString());
        List<dynamic> items = jsonBody['message'] as List<dynamic>;
        return items[0];
      } else {
        Snackbars.showSnackbar(
            title: "Limit Exceed!",
            message: "Try later.",
            fontIcon: FontAwesomeIcons.rectangleXmark,
            margin: 10);
        return "failed";
      }
    } catch (e) {
      print(e.toString());
      return "Error";
    }
  }
}
