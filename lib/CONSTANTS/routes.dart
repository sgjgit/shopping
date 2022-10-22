import 'package:get/get.dart';
import 'package:shopping/BINDING/bindings.dart';
import 'package:shopping/VIEW/add_product_page.dart';
import 'package:shopping/VIEW/cart_page.dart';

import 'route_names.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
      name: MyRoutes.cartPage,
      page: () => CartPage(),
      binding: CartPageBinding()),
  GetPage(
      name: MyRoutes.addProductPage,
      page: () => AddProductPage(),
      binding: AddProductPageBinding())
];
