import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment {
  Payment(
      {required this.name,
      required this.address,
      required this.amount,
      required this.description});

  String name;
  String address;

  String description;
  double amount;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void rozarpayPayment() {
    try {
      // Login user Detail
      GetStorage box = GetStorage();
      Map<String, dynamic>? user = box.read('loginData');
      if (user != null) {
        Razorpay razorpay = Razorpay();

        var options = {
          'key': 'rzp_test_gtcNTi9mqwQ7r4',
          'amount': amount * 100,
          'name': name,
          // 'address':address,
          'description': description
        };
        print('options:$options');
        void handlePaymentSuccess(PaymentSuccessResponse response) {
          CollectionReference orderCollection = firestore.collection('orders');
          DocumentReference doc = orderCollection.doc();
          if (address.isNotEmpty && response.paymentId != null) {
            var order = {
              'item': name,
              'price': amount,
              'address': address,
              'id': user['id'],
              'mobile': user['number'],
              'dateTime': DateTime.now().toString(),
              'transactionId': response.paymentId,
            };
            doc.set(order);
            Get.snackbar("Payment Successful", 'Transaction ID: ${response.paymentId}');

            // Dialog Box
            showDialog(response.orderId.toString());
          } else {
            Get.snackbar("Invalid !", "Fill Address", colorText: Colors.red);
          }
        }

        void handlePaymentError(PaymentFailureResponse response) {
          Get.snackbar("Payment Failed", 'Error: ${response.message}');

          // Do something when payment fails
        }

        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
        razorpay.open(options);

        // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
      } else {
        Get.snackbar("Failed!", "User not registered. Please sign up to continue.",
            colorText: Colors.red);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void showDialog(String orderId) {
    Get.defaultDialog(
      title: "Order Successful",
      content: Text("your Order Id : $orderId"),
      confirm: ElevatedButton(
        onPressed: () {
          Get.offAndToNamed('/home-page');
        },
        child: Text("Close"),
      ),
    );
  }
}
