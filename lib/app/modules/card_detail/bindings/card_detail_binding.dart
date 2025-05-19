import 'package:get/get.dart';

import '../controllers/card_detail_controller.dart';

class CardDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardDetailController>(
      () => CardDetailController(),
    );
  }
}
