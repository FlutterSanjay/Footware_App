import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footware_client/app/data/payment.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/Snackbar/snackbar.dart';
import '../../../model/product/product.dart';

class CardDetailController extends GetxController {
  TextEditingController address = TextEditingController();
  // Arguments Data Receive from HomePage Card
  Future<SharedPreferences> sPref = SharedPreferences.getInstance();
  var imgUrl = "".obs;
  var name = "".obs;
  var description = "".obs;
  var price = "".obs;
  var offer = "".obs;
  int priceString = 0;

  RxBool isLoading = false.obs;

  Future<void> getSelectedCardData() async {
    try {
      final SharedPreferences sp = await sPref;
      imgUrl.value = sp.getString("imageUrl")!;
      name.value = sp.getString("name")!;
      description.value = sp.getString("description")!;
      price.value = sp.getString("price")!;
      priceString = int.parse(sp.getString("price")!);
      offer.value = sp.getString("offer")!;

      isLoading.value = true;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //TODO: Implement CardDetailController
  late CollectionReference productCollection;

  var productList = <Product>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    getSelectedCardData();
    // print("Data : " + data[0]);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    productCollection = firestore.collection('products');

    super.onInit();
  }

  fetchData() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> product = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      if (product.isNotEmpty) {
        productList.value = product;
        print(productList[0].toJson());

        Snackbars.showSnackbar(
            title: "Successfully",
            message: "Product Fetched successfully",
            fontIcon: FontAwesomeIcons.caretRight);

        isLoading.value = true;
      } else {
        productList.clear(); // Clear the list if no products
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
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
