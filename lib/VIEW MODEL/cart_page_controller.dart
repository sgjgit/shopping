import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/CONSTANTS/constants.dart';
import 'package:shopping/Model/shopping_cart_model.dart';
import 'package:shopping/REPOSITORY/cart_repo.dart';

class CartPageController extends GetxController
    with GetTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  TabController? tabcontroller;
  RxList<CategoryDetails> categoryDetails = <CategoryDetails>[].obs;
  Rx<XFile> pickedFile = XFile("").obs;
  Rx<File> selecedImage = File("").obs;
  RxString profileName = "PRAVIN".obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  @override
  void onInit() {
    super.onInit();
    callingOnInitFunction();
    tabcontroller = TabController(length: 5, vsync: this);
  }

  callingOnInitFunction() async {
    gettingJsonData();
  }

  expandTheItem(CategoryDetails incomingElement, ProductList selectedItem) {
    categoryDetails.value = categoryDetails.map((element) {
      if (element.categoryName.toString().toLowerCase() ==
          incomingElement.categoryName.toString().toLowerCase()) {
        element.productList!.map((e) {
          if (e.productName.toString().toLowerCase() ==
              selectedItem.productName!.toString().toLowerCase()) {
            e.isExpanded = !e.isExpanded;
            return e;
          } else {
            return e;
          }
        }).toList();
        return element;
      } else {
        return element;
      }
    }).toList();
  }

  deleteAProduct(CategoryDetails elementToDelete, ProductList selectedItem) {
    categoryDetails.value = categoryDetails.map((element) {
      if (element.categoryName.toString().toLowerCase() ==
          elementToDelete.categoryName.toString().toLowerCase()) {
        element.productList!.remove(selectedItem);
        return element;
      } else {
        return element;
      }
    }).toList();
  }

  gettingJsonData() async {
    isLoading.value = true;
    List<CategoryDetails> result = await CartRepo.extractJsonItems();
    tabcontroller = TabController(length: result.length, vsync: this);
    categoryDetails.value = result;
    isLoading.value = false;
  }

  callingImagPicker(ImageSource imageSource, String fromWhere) async {}

  pickImage(ImageSource whichSource) async {
    Get.back();
    final imagePicker = ImagePicker();
    pickedFile.value = (await imagePicker.pickImage(source: whichSource))!;
    yellow(pickedFile.value);
    if (pickedFile.value.path.isNotEmpty) {
      selecedImage.value = File(pickedFile.value.path);
    } else {
      return;
    }
  }
}

class CategoryDetails {
  String? categoryName;
  List<ProductList>? productList;
  CategoryDetails({this.categoryName, this.productList});
}
