// To parse this JSON data, do
//
//     final shoppingCartModel = shoppingCartModelFromJson(jsonString);

import 'dart:convert';

class ShoppingCartModel {
  ShoppingCartModel({
    this.categoryName,
    this.productList,
  });

  String? categoryName;
  List<ProductList>? productList;

  factory ShoppingCartModel.fromRawJson(String str) =>
      ShoppingCartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShoppingCartModel.fromJson(Map<String, dynamic> json) =>
      ShoppingCartModel(
        categoryName: json["categoryName"],
        productList: json["productList"] == null
            ? null
            : List<ProductList>.from(
                json["productList"].map((x) => ProductList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "productList": productList == null
            ? null
            : List<dynamic>.from(productList!.map((x) => x.toJson())),
      };
}

class ProductList {
  ProductList(
      {this.productName,
      this.modelNumber,
      this.price,
      this.manufactureDate,
      this.manufactureAddress,
      this.isExpanded = false});

  String? productName;
  String? modelNumber;
  String? price;
  String? manufactureDate;
  String? manufactureAddress;
  bool isExpanded;

  factory ProductList.fromRawJson(String str) =>
      ProductList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        productName: json["productName"],
        modelNumber: json["modelNumber"],
        price: json["price"],
        manufactureDate: json["manufactureDate"],
        manufactureAddress: json["manufactureAddress"],
        isExpanded: false,
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "modelNumber": modelNumber,
        "price": price,
        "manufactureDate": manufactureDate,
        "manufactureAddress": manufactureAddress,
        "isExpanded": isExpanded,
      };
}
