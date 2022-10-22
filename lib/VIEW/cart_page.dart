import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shopping/CONSTANTS/constants.dart';
import 'package:shopping/CONSTANTS/route_names.dart';
import 'package:shopping/CONSTANTS/size_config.dart';
import 'package:shopping/Model/shopping_cart_model.dart';
import 'package:shopping/VIEW%20MODEL/cart_page_controller.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final cartPage = Get.find<CartPageController>();
  final drawerKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        key: drawerKey,
        drawer: customDrawer(context),
        appBar: cartPageAppBar(),
        body: Obx(() {
          return ModalProgressHUD(
            inAsyncCall: cartPage.isLoading.value,
            child: cartPage.categoryDetails.isEmpty
                ? Center(
                    child: textOnly(text: "No List"),
                  )
                : Column(
                    children: [
                      Obx(() {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: TabBar(
                                indicatorColor: Colors.black,
                                labelColor: Colors.black,
                                isScrollable: true,
                                unselectedLabelColor: Colors.grey,
                                labelStyle:
                                    commonTextStyle(color: Colors.black),
                                controller: cartPage.tabcontroller,
                                tabs: cartPage.categoryDetails
                                    .map((element) => Tab(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: SizeConfig
                                                        .blockSizeHorizontal! *
                                                    2.0),
                                            child: textOnly(
                                                text: element.categoryName
                                                    .toString(),
                                                fontWeight: FontWeight.w500,
                                                fontSize: SizeConfig
                                                        .safeBlockVertical! *
                                                    1.7),
                                          ),
                                        ))
                                    .toList()),
                          ),
                        );
                      }),
                      expandedTabBarView(),
                    ],
                  ),
          );
        }),
      ),
    );
  }

  Drawer customDrawer(BuildContext context) {
    return Drawer(
      width: SizeConfig.blockSizeHorizontal! * 60,
      child: Column(
        children: [
          SizedBox(height: SizeConfig.safeBlockVertical! * 5.0),
          drawerStack(context),
          SizedBox(height: SizeConfig.safeBlockVertical! * 5.0),
          nameEditRow(context)
        ],
      ),
    );
  }

  Row nameEditRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Obx(() {
            return textOnly(
                alignment: Alignment.center,
                text: cartPage.profileName.value,
                fontSize: SizeConfig.safeBlockVertical! * 4.0);
          }),
        ),
        IconButton(
            onPressed: () {
              nameDialog(context);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ))
      ],
    );
  }

  Future<dynamic> nameDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: SizeConfig.safeBlockVertical! * 20,
              width: SizeConfig.safeBlockHorizontal! * 60,
              child: Column(
                children: [
                  textOnly(
                      text: "Edit Your Name",
                      fontSize: SizeConfig.safeBlockVertical! * 2.2),
                  const Expanded(
                    child: SizedBox(height: 2.0),
                  ),
                  TextFormField(controller: cartPage.nameController.value),
                  SizedBox(height: SizeConfig.safeBlockVertical! * 2.0),
                  ElevatedButton(
                    child: textOnly(text: "OK"),
                    onPressed: () {
                      Get.back();
                      if (cartPage.nameController.value.text.isNotEmpty) {
                        cartPage.profileName.value =
                            cartPage.nameController.value.text;
                      }

                      cartPage.nameController.value.text = "";
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  AppBar cartPageAppBar() {
    return AppBar(
      centerTitle: true,
      title: textOnly(text: "Cart Page"),
      leading: IconButton(
          onPressed: () {
            drawerKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu)),
      actions: [
        IconButton(
            onPressed: () {
              Get.toNamed(MyRoutes.addProductPage,
                  arguments: cartPage
                      .categoryDetails[cartPage.tabcontroller!.index]
                      .categoryName);
            },
            icon: const Icon(Icons.add))
      ],
    );
  }

  Stack drawerStack(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return Container(
            height: SizeConfig.safeBlockHorizontal! * 35,
            width: SizeConfig.safeBlockHorizontal! * 35,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: cartPage.selecedImage.value.path.isEmpty
                ? const Text("")
                : Image.file(
                    cartPage.selecedImage.value,
                    fit: BoxFit.cover,
                  ),
          );
        }),
        Positioned(
            bottom: SizeConfig.blockSizeVertical! * 0.0,
            right: SizeConfig.safeBlockHorizontal! * 1.0,
            child: IconButton(
              icon: Icon(
                Icons.camera_alt_outlined,
                color: Colors.black,
                size: SizeConfig.safeBlockVertical! * 4.0,
              ),
              onPressed: () {
                showImageDialog(context);
              },
            ))
      ],
    );
  }

  Future<dynamic> showImageDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: SizeConfig.safeBlockVertical! * 16,
              width: SizeConfig.safeBlockHorizontal! * 60,
              child: Column(
                children: [
                  textOnly(
                      text: "Select Image From",
                      fontSize: SizeConfig.safeBlockVertical! * 2.2),
                  const Expanded(
                    child: SizedBox(
                      height: 2.0,
                    ),
                  ),
                  imageSelectionRow(),
                ],
              ),
            ),
          );
        });
  }

  Row imageSelectionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {
              cartPage.pickImage(ImageSource.camera);
            },
            child: textOnly(
                text: "Camera",
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        TextButton(
            onPressed: () {
              cartPage.pickImage(ImageSource.gallery);
            },
            child: textOnly(
                text: "Gallery",
                fontWeight: FontWeight.bold,
                color: Colors.black))
      ],
    );
  }

  Expanded expandedTabBarView() {
    return Expanded(child: Obx(() {
      return TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: cartPage.tabcontroller,
          children: cartPage.categoryDetails
              .map(
                (element) => Container(
                  padding: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical! * 2.0,
                      left: SizeConfig.safeBlockHorizontal! * 3.0,
                      right: SizeConfig.safeBlockHorizontal! * 3.0),
                  height: SizeConfig.safeBlockVertical! * 30,
                  width: SizeConfig.safeBlockHorizontal! * 100,
                  child: element.productList!.isEmpty
                      ? Center(
                          child: textOnly(
                              text: "No Items in The List",
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        )
                      : buildListView(element),
                ),
              )
              .toList());
    }));
  }

  ReorderableListView buildListView(CategoryDetails element) {
    return ReorderableListView.builder(
      onReorder: (oldIndex, newIndex) {
        ProductList p = element.productList!.removeAt(oldIndex);
        element.productList!
            .insert(newIndex > oldIndex ? newIndex - 1 : newIndex, p);
      },
      itemCount: element.productList!.length,
      itemBuilder: (context, index1) {
        return customDissmissible(element, index1);
      },
      // separatorBuilder: ((context, index2) {
      //   return Container(
      //     height: SizeConfig.safeBlockVertical! * 2.0,
      //   );
      // }),
    );
  }

  Dismissible customDissmissible(CategoryDetails element, int index1) {
    return Dismissible(
      key: ObjectKey(element.productList![index1]),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal! * 5.0),
        alignment: Alignment.centerRight,
        color: Colors.blue.shade100,
        child: Icon(
          Icons.delete,
          color: Colors.red,
          size: SizeConfig.safeBlockVertical! * 5.0,
        ),
      ),
      onDismissed: (direction) {
        cartPage.deleteAProduct(element, element.productList![index1]);
        commonSnackBar("deleted successfully");
      },
      child: InkWell(
        onTap: () {
          cartPage.expandTheItem(element, element.productList![index1]);
        },
        child: Padding(
          padding: index1 == 0
              ? EdgeInsets.zero
              : EdgeInsets.only(top: SizeConfig.safeBlockVertical! * 0.6),
          child: customCard(element, index1),
        ),
      ),
    );
  }

  Card customCard(CategoryDetails element, int index1) {
    return Card(
      elevation: 3.0,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.safeBlockVertical! * 2.0,
            horizontal: SizeConfig.safeBlockVertical! * 3.0),
        child: Column(
          children: [
            customRow(element.productList![index1].productName.toString(),
                "Product Name"),
            SizedBox(height: SizeConfig.safeBlockVertical! * 1.5),
            customRow(element.productList![index1].modelNumber.toString(),
                "Model Number"),
            SizedBox(height: SizeConfig.safeBlockVertical! * 1.5),
            customRow(element.productList![index1].price.toString(), "Price"),
            Visibility(
              visible: element.productList![index1].isExpanded,
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.safeBlockVertical! * 1.5),
                  customRow(
                      element.productList![index1].manufactureDate.toString(),
                      "Manufactured Date"),
                  SizedBox(height: SizeConfig.safeBlockVertical! * 1.5),
                  customRow(
                      element.productList![index1].manufactureAddress
                          .toString(),
                      "Manufactured Address"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row customRow(String incomingElement, String heading) {
    return Row(
      children: [
        Expanded(
          child: textOnly(
              text: heading,
              color: Colors.grey.shade600,
              fontSize: SizeConfig.safeBlockVertical! * 1.8,
              fontWeight: FontWeight.w400,
              alignment: Alignment.centerLeft),
        ),
        Expanded(
          child: textOnly(
              text: incomingElement,
              color: Colors.black,
              fontSize: SizeConfig.safeBlockVertical! * 1.8,
              fontWeight: FontWeight.w400,
              alignment: Alignment.centerRight),
        ),
      ],
    );
  }
}
