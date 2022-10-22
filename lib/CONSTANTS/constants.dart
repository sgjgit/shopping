import 'package:flutter/material.dart';
import "dart:developer";

import 'package:get/get.dart';
import 'package:shopping/CONSTANTS/size_config.dart';

TextStyle commonTextStyle(
    {double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    FontStyle? fontStyle,
    TextDecoration? textDecoration}) {
  return TextStyle(
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      color: color,
      fontFamily: 'Lato',
      decoration: textDecoration,
      letterSpacing: letterSpacing ?? 0.0);
}

Align textOnly(
    {required text,
    fontSize,
    FontWeight? fontWeight,
    color,
    AlignmentGeometry? alignment,
    TextOverflow? textOverflow,
    int? maxlines,
    TextAlign? textAlign,
    double? letterSpacing,
    TextDecoration? textDecoration,
    FontStyle? fontStyle}) {
  return Align(
    alignment: alignment ?? Alignment.center,
    child: Text(
      text,
      overflow: textOverflow,
      maxLines: maxlines,
      textAlign: textAlign,

      // softWrap: true,
      style: commonTextStyle(
          fontStyle: fontStyle,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color),
    ),
  );
}

class ConstantMethods {
  // static saveItemLocal(preferenceTypes type, dynamic data, String key) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   switch (type) {
  //     case preferenceTypes.isBool:
  //       preferences.setBool(key, data as bool);
  //       break;
  //     case preferenceTypes.isInt:
  //       preferences.setInt(key, data as int);
  //       break;
  //     case preferenceTypes.isString:
  //       preferences.setString(key, data as String);
  //       break;
  //     case preferenceTypes.isDouble:
  //       preferences.setDouble(key, data as double);
  //       break;
  //   }
  // }

  // static Future getSavedItemFromLocal(String key, preferenceTypes types) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   switch (types) {
  //     case preferenceTypes.isBool:
  //       return preferences.getBool(key);
  //     case preferenceTypes.isInt:
  //       return preferences.getInt(key);
  //     case preferenceTypes.isString:
  //       return preferences.getString(key);
  //     case preferenceTypes.isDouble:
  //       return preferences.getDouble(key);
  //   }
  // }
}

// enum preferenceTypes { isBool, isInt, isString, isDouble }

green(msg) {
  log('\x1B[32m${msg.toString()}\x1B[0m');
}

blue(msg) {
  log('\x1B[34m${msg.toString()}\x1B[0m');
}

yellow(msg) {
  log('\x1B[33m${msg.toString()}\x1B[0m');
}

red(msg) {
  log('\x1B[31m${msg.toString()}\x1B[0m');
}

commonSnackBar(String text) {
  return Get.showSnackbar(GetSnackBar(
    duration: const Duration(seconds: 2),
    messageText: textOnly(
        alignment: Alignment.centerLeft,
        text: text,
        fontSize: SizeConfig.safeBlockVertical! * 1.4,
        color: Colors.white),
  ));
}
