import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/CONSTANTS/constants.dart';
import 'package:shopping/Model/shopping_cart_model.dart';
import 'package:shopping/VIEW%20MODEL/cart_page_controller.dart';

class AddProductPageController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<TextEditingController> productNameText = TextEditingController().obs;
  Rx<TextEditingController> modelNumberText = TextEditingController().obs;
  Rx<TextEditingController> priceText = TextEditingController().obs;
  Rx<TextEditingController> manufacturedDateText = TextEditingController().obs;
  Rx<TextEditingController> manufacturedAddressText =
      TextEditingController().obs;
  String? argument;
  final cartpage = Get.find<CartPageController>();
  @override
  void onInit() {
    super.onInit();
    argument = Get.arguments;
  }

  creatingNewProduct() async {
    if (productNameText.value.text.isEmpty) {
      return commonSnackBar("Please enter product name");
    }
    if (modelNumberText.value.text.isEmpty) {
      return commonSnackBar("Please enter model number");
    }
    if (priceText.value.text.isEmpty) {
      return commonSnackBar("Please enter product price");
    }
    if (manufacturedDateText.value.text.isEmpty) {
      return commonSnackBar("Please enter manufactured Date");
    }
    if (manufacturedAddressText.value.text.isEmpty) {
      return commonSnackBar("Please enter the address");
    }
    isLoading.value = true;
    ProductList productToAdd = ProductList(
        manufactureAddress: manufacturedAddressText.value.text,
        manufactureDate: manufacturedDateText.value.text,
        price: priceText.value.text,
        modelNumber: modelNumberText.value.text,
        productName: productNameText.value.text);

    cartpage.categoryDetails.map((element) {
      if (element.categoryName.toString().toLowerCase() ==
          argument!.toLowerCase()) {
        element.productList!.add(productToAdd);
        return element;
      } else {
        return element;
      }
    }).toList();
    // clearingFields();
    Get.back();
    commonSnackBar("Product added Successfully");
    isLoading.value = false;
  }

  clearingFields() {
    manufacturedAddressText.value.text = "";
    manufacturedDateText.value.text = "";
    priceText.value.text = "";
    modelNumberText.value.text = "";
    productNameText.value.text = "";
  }

  pickDate(context) async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.grey,
              splashColor: Colors.black,
              colorScheme: const ColorScheme.light(
                  primary: Colors.blue,
                  onSecondary: Colors.black,
                  onPrimary: Colors.white,
                  surface: Colors.black,
                  onSurface: Colors.black,
                  secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? const Text(""),
          );
        });

    if (date != null) {
      manufacturedDateText.value.text = date.toString().substring(0, 11);
    } else {
      return;
    }
  }
}
