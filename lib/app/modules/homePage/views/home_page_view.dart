import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footware_client/app/TextFile/textStyles.dart';
import 'package:footware_client/app/common/choiceDropMenu.dart';
import 'package:footware_client/app/common/colors.dart';
import 'package:footware_client/app/common/drop_menu.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../card_detail/views/card_detail_view.dart';
import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.fetchData();
        controller.selectedIndex.value = (-1);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AllColor.navBackgroundColor,
            actions: [
              IconButton(
                  onPressed: () {
                    controller.box.erase();
                    Get.offAllNamed('/home');
                    Get.snackbar("Success", "Logout Successfully",
                        colorText: Colors.green);
                  },
                  icon: Icon(Icons.logout, color: Colors.black))
            ],
            title: TextStyles(
                color: AllColor.allTextColor,
                text: "Footware Store",
                font_Weight: FontWeight.w600,
                size: 24),
            centerTitle: true,
          ),
          body: Obx(
            () => controller.isLoading.value
                ? Center(
                    child: LoadingAnimationWidget.discreteCircle(
                      size: 30,
                      color: Colors.black,
                    ),
                  )
                : controller.productList.isEmpty
                    ? Center(
                        child: LoadingAnimationWidget.discreteCircle(
                          size: 30,
                          color: Colors.black,
                        ),
                      )
                    : SafeArea(
                        child: Column(
                        children: [
                          SizedBox(
                            // loading functionaliy later
                            height: Get.height * 0.055,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.productCategoryList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    controller.filterCategory(controller
                                        .productCategoryList[index].name
                                        .toString());
                                    controller.selectedIndex.value = index;
                                  },
                                  child: Obx(
                                    () => Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 1.r,
                                                blurRadius: 2.r,
                                                offset: Offset(0.0, 1.5.r))
                                          ],
                                          borderRadius: BorderRadius.circular(3.r),
                                          color: controller.selectedIndex.value != index
                                              ? Colors.deepPurple[900]
                                              : Color(0xffe55b6f)),
                                      margin: EdgeInsets.only(
                                          top: 5.h, left: 5.w, right: 5.w, bottom: 5.h),
                                      width: Get.width * 0.219,
                                      height: Get.height * 0.037,
                                      child: TextStyles(
                                          color: Colors.white,
                                          text:
                                              controller.productCategoryList[index].name,
                                          font_Weight: FontWeight.w400,
                                          size: 12),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, _) {
                                return SizedBox(
                                  width: 2.h,
                                );
                              },
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Choicedropmenu(
                                  items: controller.choiceMenuList.toList(),
                                  onSelectChange: (selectedItems) {
                                    controller.filterByBrand(selectedItems);
                                  },
                                )),
                                Flexible(
                                  child: DropMenu(
                                    itemController: controller.list,
                                    alignment: Alignment.centerLeft,
                                    dropController: controller.offerData.value,
                                    changeDropItemSelect: controller.changeOfferValue,
                                    sortfunction: controller.sortByPrice,
                                  ),
                                ),
                              ]),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
                              child: Obx(
                                () => GridView.builder(
                                    itemCount: controller.productShowList.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 14,
                                            mainAxisSpacing: 10,
                                            childAspectRatio: 0.7),
                                    itemBuilder: (builder, index) {
                                      return productCard(index, controller);
                                    }),
                              ),
                            ),
                          )
                        ],
                      )),
          )),
    );
  }
}

InkWell productCard(int index, controller) {
  return InkWell(
    onTap: () {
      Get.toNamed('/card-detail');
      controller.setCardData(index);
    },
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xfffffbfb),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            spreadRadius: 1.5.r,
            blurRadius: 2.r,
            offset: Offset(0.0, 1.5.r),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h, bottom: 8.h),
            width: Get.width * 1,
            height: Get.height * 0.18,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Image.network(
              controller.productShowList[index].imageUrl,
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
          Divider(
            color: Colors.black,
            thickness: 0.5.h,
            height: 2.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8, bottom: 3),
            child: TextStyles(
                color: Colors.black,
                text: controller.productShowList[index].name,
                font_Weight: FontWeight.w500,
                size: 13),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 8),
            child: TextStyles(
                color: Colors.black,
                text: "Rs : ${controller.productShowList[index].price}",
                font_Weight: FontWeight.w500,
                size: 13),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 8),
            child: Container(
              width: Get.width * 0.3,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              height: Get.height * 0.032,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: TextStyles(
                color: Colors.white,
                text: controller.productShowList[index].offer,
                font_Weight: FontWeight.w500,
                size: 12,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
