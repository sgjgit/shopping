import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:shopping/Model/shopping_cart_model.dart';
import 'package:shopping/VIEW%20MODEL/cart_page_controller.dart';

class CartRepo {
  static Future<List<CategoryDetails>> extractJsonItems() async {
    String result = await rootBundle.loadString("assets/shopping_list.json");
    List<CategoryDetails> categoryDetailsList = [];
    List<dynamic> list = json.decode(result);
    List<ShoppingCartModel> shoppinCartModel =
        list.map((e) => ShoppingCartModel.fromJson(e)).toList();
    for (var element in shoppinCartModel) {
      // yellow(element.productList);
      // green(element.categoryName);
      categoryDetailsList.add(CategoryDetails(
          categoryName: element.categoryName,
          productList: element.productList));
    }
    return categoryDetailsList;
  }
}
