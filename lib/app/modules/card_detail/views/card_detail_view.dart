import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:footware_client/app/TextFile/textStyles.dart';
import 'package:footware_client/app/data/payment.dart';
import 'package:footware_client/app/modules/homePage/views/home_page_view.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../common/colors.dart';
import '../controllers/card_detail_controller.dart';

class CardDetailView extends GetView<CardDetailController> {
  const CardDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AllColor.navBackgroundColor,
          leading: IconButton(
              onPressed: () {
                Get.offNamed('/home-page');
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: TextStyles(
              color: Colors.black,
              text: "Product Details",
              font_Weight: FontWeight.w600,
              size: 23),
          centerTitle: true,
        ),
        body: SafeArea(
            child: controller.isLoading.value
                ? Center(
                    child: LoadingAnimationWidget.discreteCircle(
                      size: 30,
                      color: Colors.black,
                    ),
                  )
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(8.w),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 8.h, bottom: 10.h),
                            width: Get.width * 1,
                            height: Get.height * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.grey.withAlpha(30),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Image.network(
                              controller.imgUrl.value,
                              // controller.productList[index].imageUrl.toString(),
                              fit: BoxFit.fill,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // Image has finished loading
                                } else {
                                  return Center(
                                      child:
                                          CircularProgressIndicator()); // Show loading indicator while the image is loading
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                // If the image fails to load, show a default image
                                return Image.asset(
                                  'images/loading.png',
                                  // fit: BoxFit.contain,
                                  scale: 5.4,
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextStyles(
                                  color: Colors.black,
                                  text: controller.name.value,
                                  font_Weight: FontWeight.w600,
                                  size: 24),
                              Container(
                                alignment: Alignment.center,
                                width: Get.width * 0.34,
                                height: Get.height * 0.04,
                                decoration: BoxDecoration(
                                  color: Colors.deepOrangeAccent,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: TextStyles(
                                    color: Colors.white,
                                    text: controller.offer.value,
                                    font_Weight: FontWeight.w600,
                                    size: 15),
                              )
                            ],
                          ),
                          TextStyles(
                            color: Colors.black54,
                            text: controller.description.value,
                            font_Weight: FontWeight.w400,
                            size: 14,
                            numberLine: 2,
                          ),
                          TextStyles(
                              color: Color(0xff12af00),
                              text: "Rs. ${controller.price.value}",
                              font_Weight: FontWeight.w600,
                              size: 18),
                          SizedBox(
                            height: 13.h,
                          ),
                          TextFormField(
                            controller: controller.address,
                            onTapOutside: (_) =>
                                FocusManager.instance.primaryFocus!.unfocus(),
                            maxLines: 5,
                            decoration: InputDecoration(
                                hintText: "Enter your Billing Address",
                                filled: true,
                                fillColor: Colors.grey.withAlpha(10),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black87, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.lightBlue, width: 2),
                                ),
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(borderSide: BorderSide.none)),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: Get.width * 0.9,
                              height: Get.height * 0.07,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff291bea)),
                                  onPressed: () {
                                    var payment = Payment(
                                      name: controller.name.value,
                                      amount: double.parse(controller.price.value),
                                      description: controller.description.value,
                                      address: controller.address.text,
                                    );
                                    payment.rozarpayPayment();
                                    controller.address.clear();
                                  },
                                  child: TextStyles(
                                      color: Colors.white,
                                      text: "Buy Now",
                                      font_Weight: FontWeight.normal,
                                      size: 18)),
                            ),
                          )
                        ],
                      ),
                    ),
                  )));
  }
}
