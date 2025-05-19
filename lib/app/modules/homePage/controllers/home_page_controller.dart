import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:footware_client/app/model/product_category/product_category.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/product/product.dart';

class HomePageController extends GetxController {
  GetStorage box = GetStorage();
  Future<SharedPreferences> sPref = SharedPreferences.getInstance();

  late CollectionReference productCollection;
  late CollectionReference productCategory;
  var productList = <Product>[].obs;
  var productShowList = <Product>[].obs;
  var productCategoryList = <Product_Category>[].obs;
  var list = <String>["Sort", "High To Low", "Low To High"].obs;

  RxBool isLoading = false.obs;

  RxInt selectedIndex = (-1).obs;

  @override
  void onInit() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    productCollection = firestore.collection("products");
    productCategory = firestore.collection("category");
    await fetchCategories();
    await fetchData();

    super.onInit();
  }

  RxString offerData = "Sort".obs;
  sortByPrice() {
    List<Product> sortedList = List<Product>.from(productShowList);

    if (offerData.value == "Low To High") {
      sortedList.sort((a, b) => a.price!.compareTo(b.price!));
      productShowList.assignAll(sortedList);
    } else if (offerData.value == "High To Low") {
      sortedList.sort((a, b) => b.price!.compareTo(a.price!));
      productShowList.assignAll(sortedList);
    } else {
      productShowList.assignAll(sortedList);
    }
  }

  // Choice Menu List

  //add(elemnet); and remove() ->push and pop of set
  var choiceMenuList = <String>{}.obs;
  var sortMenuList = <String>{}.obs;

  var choiceListSelect = <String>[].obs;

  // Update the Selected item
  void changeOfferValue(String newValue) {
    offerData.value = newValue;
  }

  void loadCategory() {
    try {
      int len = productList.length;
      for (int i = 0; i < len; i++) {
        // list.add(productList[i].offer.toString());
        choiceMenuList.add(productList[i].brand.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // set the Selected Card Data
  Future<void> setCardData(int index) async {
    final SharedPreferences sp = await sPref;
    sp.setString("imageUrl", productList[index].imageUrl.toString());
    sp.setString("name", productList[index].name.toString());
    sp.setString("description", productList[index].description.toString());
    sp.setString("price", productList[index].price.toString());
    sp.setString("offer", productList[index].offer.toString());
  }

  // Fetch Data from database
  fetchData() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> product = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      if (product.isNotEmpty) {
        productList.value = product;
        productShowList.assignAll(product);
        print(productList[1].toJson());

        loadCategory();

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

  //fetch Categories
  fetchCategories() async {
    try {
      QuerySnapshot productSnapshot = await productCategory.get();
      final List<Product_Category> productCategories = productSnapshot.docs
          .map((doc) => Product_Category.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      if (productCategories.isNotEmpty) {
        productCategoryList.value = productCategories;
        print(productCategoryList[0].toJson());

        loadCategory();
        isLoading.value = true;
      } else {
        productList.clear(); // Clear the list if no products
      }
    } catch (e) {
      print(e.toString());
      isLoading.value = false;
    }
  }

  filterCategory(String category) async {
    try {
      productShowList.clear();
      productShowList.value =
          productList.where((product) => product.brand == category).toList();
    } catch (e) {
      print(e);
    }
  }

  filterByBrand(List<String> brands) async {
    try {
      if (brands.isEmpty) {
        print("Empty");
        fetchData();
      } else {
        print("NotEmpty");
        List<String> lowerCaseBrands =
            brands.map((brand) => brand.toLowerCase()).toList();
        productShowList.value = productList
            .where((product) => lowerCaseBrands.contains(
                product.brand?.toLowerCase())) // Convert product.brand to lowercase
            .toList();
      }
      print(choiceMenuList);
    } catch (e) {
      print("Error in filterByBrand: $e");
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
}
