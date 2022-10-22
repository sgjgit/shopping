import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shopping/CONSTANTS/constants.dart';
import 'package:shopping/CONSTANTS/size_config.dart';
import 'package:shopping/VIEW%20MODEL/add_product_controller.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});
  final addProduct = Get.find<AddProductPageController>();
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.shade300,
    ),
  );
  OutlineInputBorder focusedBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue),
  );
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: addPageAppBar(),
      body: Obx(() {
        return ModalProgressHUD(
          inAsyncCall: addProduct.isLoading.value,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.safeBlockHorizontal! * 5.0,
                  right: SizeConfig.safeBlockHorizontal! * 5.0,
                  top: SizeConfig.safeBlockVertical! * 2.0),
              child: mainColumn(context),
            ),
          ),
        );
      }),
    );
  }

  AppBar addPageAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal! * 18.0),
        child: textOnly(
            text: "Add Product",
            color: Colors.white,
            alignment: Alignment.centerLeft,
            fontSize: SizeConfig.safeBlockVertical! * 2.4,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Column mainColumn(BuildContext context) {
    return Column(
      children: [
        customText("Product Name"),
        SizedBox(height: SizeConfig.safeBlockVertical! * 1.0),
        customFormField(addProduct.productNameText.value, "Product Name"),
        SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
        customText("Model Number"),
        SizedBox(height: SizeConfig.safeBlockVertical! * 1.0),
        customFormField(addProduct.modelNumberText.value, "Model Number"),
        SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
        customText("Price"),
        SizedBox(height: SizeConfig.safeBlockVertical! * 1.0),
        customFormField(addProduct.priceText.value, "Price",
            textInputFormatter: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
            ],
            keyboardType: TextInputType.number,
            maxlength: 10),
        SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
        customText("Manufactured Date"),
        SizedBox(height: SizeConfig.safeBlockVertical! * 1.0),
        calendarRow(context),
        SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
        customText("Manufactured Address"),
        SizedBox(height: SizeConfig.safeBlockVertical! * 1.0),
        customFormField(
            addProduct.manufacturedAddressText.value, "Manufactured Address"),
        SizedBox(height: SizeConfig.blockSizeVertical! * 5.0),
        InkWell(
          onTap: () {
            addProduct.creatingNewProduct();
          },
          child: Container(
            height: SizeConfig.safeBlockVertical! * 5.0,
            width: SizeConfig.safeBlockHorizontal! * 50.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius:
                  BorderRadius.circular(SizeConfig.safeBlockVertical! * 0.6),
            ),
            child: textOnly(
                text: "SUBMIT",
                fontSize: SizeConfig.safeBlockVertical! * 1.8,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical! * 5.0),
      ],
    );
  }

  Row calendarRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: customFormField(
            addProduct.manufacturedDateText.value,
            "YYYY-MM-DD",
            enabled: false,
          ),
        ),
        IconButton(
            constraints: BoxConstraints(
                maxHeight: SizeConfig.safeBlockVertical! * 5.5,
                maxWidth: SizeConfig.safeBlockHorizontal! * 8.0),
            padding: EdgeInsets.only(
                left: SizeConfig.safeBlockHorizontal! * 2.0,
                right: SizeConfig.safeBlockHorizontal! * 2.0),
            onPressed: () {
              addProduct.pickDate(context);
            },
            icon: const Icon(Icons.calendar_today))
      ],
    );
  }

  SizedBox customFormField(
      TextEditingController textEditingController, String hintText,
      {Widget? suffixIcon,
      List<TextInputFormatter>? textInputFormatter,
      TextInputType? keyboardType,
      int? maxlength,
      bool enabled = true,
      double? width}) {
    return SizedBox(
      height: SizeConfig.safeBlockVertical! * 5.5,
      width: width ?? SizeConfig.safeBlockHorizontal! * 100,
      child: TextFormField(
        enabled: enabled,
        maxLength: maxlength,
        keyboardType: keyboardType,
        inputFormatters: textInputFormatter,
        textAlignVertical: TextAlignVertical.center,
        controller: textEditingController,
        decoration: InputDecoration(
            counterText: "",
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: commonTextStyle(
                color: Colors.grey.shade400,
                fontSize: SizeConfig.safeBlockVertical! * 1.8),
            contentPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal! * 2.0),
            enabledBorder: outlineInputBorder,
            border: outlineInputBorder,
            disabledBorder: outlineInputBorder,
            focusedBorder: focusedBorder),
      ),
    );
  }

  Align customText(String text) {
    return textOnly(
        text: "$text :",
        alignment: Alignment.centerLeft,
        fontWeight: FontWeight.w500,
        fontSize: SizeConfig.safeBlockVertical! * 1.8,
        color: Colors.black);
  }
}
