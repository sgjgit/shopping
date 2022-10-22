import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/VIEW%20MODEL/add_product_controller.dart';
import 'package:shopping/VIEW%20MODEL/cart_page_controller.dart';

class CartPageBinding extends Bindings {
  BuildContext? context;
  CartPageBinding({this.context});
  @override
  void dependencies() {
    Get.put(CartPageController());
  }
}

class AddProductPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddProductPageController());
  }
}
