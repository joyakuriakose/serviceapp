import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:serviceapp/screens/product_listing/pro_listing_controller.dart';
import '../../components/app_buttons.dart';

import '../../components/app_background.dart';
import '../../components/app_empty.dart';
import '../../components/app_refresh.dart';
import '../../components/rounded_loader.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          MyUtils.hideKeyboard();
        },
        child: Scaffold(
            body: Background(
                child: Padding(
          padding: EdgeInsets.only(left: 17.0, right: 17),
          child: AppRefresh(
            refreshFunction: () => controller.refresh(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        'assets/png/applogo.png',
                        width: Get.width * 0.12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
                Text(
                  "Exclusive Offers For You",
                  style: MyTheme.regularTextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Get.height * 0.027,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Expanded(
                  child: Obx(
                    () => controller.isScreenProgress.value
                        ? Center(child: RoundedLoader())
                        : BuildCardWidget(controller: controller),
                  ),
                ),
              ],
            ),
          ),
        ))));
  }
}

class BuildCardWidget extends StatelessWidget {
  final ProductListController controller;

  const BuildCardWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isLoading = controller.isLoading.value;
      final products = controller.productList;
      if (isLoading) {
        Future.delayed(Duration(seconds: 2), () {
          controller.isLoading.value = false;
        });
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: Get.height * 0.15),
            child: RoundedLoader(),
          ),
        );
      } else if (products.isEmpty) {
        return Center(
          child: MAResultEmpty(
            msg: 'Results Empty',
          ),
        );
      } else {
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            final product = products[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 15.0, left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width * 0.9,
                      height: Get.height * 0.17,
                      child: product.images != null && product.images!.isNotEmpty
                          ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: product.images!.length,
                        itemBuilder: (BuildContext context, int imageIndex) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              width: Get.width * 0.6,
                              height: Get.height * 0.17,
                              margin: EdgeInsets.only(right: 8.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '${product.imagesPath}/${product.images![imageIndex]}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                      )
                          : Container(
                        width: Get.width * 0.9,
                        height: Get.height * 0.17,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/png/ac.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.017),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: Get.width * 0.014,
                                height: Get.height * 0.05,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(66, 94, 236, 1),
                                      Color.fromRGBO(34, 61, 192, 1),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.width * 0.02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Brand Name",
                                    style: MyTheme.regularTextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Get.height * 0.018,
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.001),
                                  Text(
                                    product.productName ?? "",
                                    style: MyTheme.regularTextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: Get.height * 0.018,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: Get.width * 0.25),
                          Row(
                            children: [
                              Container(
                                width: Get.width * 0.014,
                                height: Get.height * 0.05,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(66, 94, 236, 1),
                                      // Start color
                                      Color.fromRGBO(34, 61, 192, 1),
                                      // End color
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.width * 0.02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Prize",
                                    style: MyTheme.regularTextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Get.height * 0.018,
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.001),
                                  Text(
                                    product.price ?? "",
                                    style: MyTheme.regularTextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: Get.height * 0.018,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    MAButton(
                      text: 'Buy Now',
                      buttonPress: () async {
                        controller.buynowSubmit(int.parse(product.productId!));
                      },
                      isEnabled: true,
                      padding: const EdgeInsets.all(20),
                      height: Get.height * 0.05,
                      width: Get.width * 0.3,
                      clipBehavior: 0,
                      radius: 30,
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }
}

