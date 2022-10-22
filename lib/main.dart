import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/BINDING/bindings.dart';
import 'package:shopping/CONSTANTS/route_names.dart';
import 'package:shopping/CONSTANTS/routes.dart';
import 'package:shopping/CONSTANTS/size_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //   home: TT(),
    // );

    return GetMaterialApp(
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaleFactor: SizeConfig.textScale),
            child: child!);
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: routes,
      initialRoute: MyRoutes.cartPage,
      initialBinding: CartPageBinding(),
    );
  }
}
