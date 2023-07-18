import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:moone_app/models/cartModel.dart';
import 'package:moone_app/models/productModel.dart';
import 'package:moone_app/models/productType.dart';
import 'package:moone_app/service/product_api.dart';
import 'package:moone_app/shared/myData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderService extends ChangeNotifier {
  FlutterSecureStorage storage = FlutterSecureStorage();

  var _bill = Random().nextInt(1000000 - 100 + 1) + 100;
  int get bill => _bill;

  List<ProductTypeModel> producttypes = [];
  List<ProductModel> products = [];
  List<CartModel> carts = [];

  int cartNetTotal = 0;

  int selectProductType = 0;
  int cartQty = 1;

  int _pageSelectedIndex = 0;
  int get pageSelected => _pageSelectedIndex;

  final PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;

  set pageSelected(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    _pageSelectedIndex = index;
    notifyListeners();
  }

  Future<void> _savePreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> getPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String data = '';
    if (prefs.getString(key) != null) {
      data = prefs.getString(key).toString();
    }
    return data;
  }

  setDataFromPreferences() async {
    MyData.id_sale = await getPreferences('_bill');
  }

  refreshData() {
    getProductList();
    getProductTypeList();
    selectProductType = 0;
    notifyListeners();
  }

  resetQty() {
    cartQty = 1;
    notifyListeners();
  }

  increaseQty() {
    cartQty += 1;
    notifyListeners();
  }

  decreaseQty() {
    if (cartQty == 1) return;

    cartQty -= 1;
    notifyListeners();
  }

  ProviderService() {
    getProductTypeList();
    getProductList();
  }

  getProductTypeList() async {
    producttypes = await ProductApi().getProductTypeList();
    notifyListeners();
  }

  getProductList() async {
    products = await ProductApi().getProductList();
    notifyListeners();
  }

  getProductListByType(int categoryId) async {
    selectProductType = categoryId;
    products = await ProductApi().getProductListByType(categoryId);
    notifyListeners();
  }

  Future<ProductModel> getProductByproID(String uuid) async {
    return await ProductApi().getProductByproID(uuid);
  }

  // Future<bool> addCart(
  //     String id_sale, String id_pro, String qty, String price) async {

  //   print("========>>>>>>>" + _id_sale.toString());
  //   await storage.write(key: "id_sale", value: _bill.toString());
  //   _id_sale = await storage.read(key: "id_sale");
  //   print("==========_bill ID" + _id_sale.toString());
  //   final isSuccess =
  //       await ProductApi().addCart(_id_sale.toString(), id_pro, qty, price);

  //   if (isSuccess == true) {
  //     final data = bill.toString();
  //     print("==>>>>>>>>>>>>>>DAta:" + data.toString());
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<bool> addCart(String id_pro, String qty, String price) async {
    String? id = await storage.read(key: "id_sale");
    print("=========id1" + id.toString());
    if (id == null || id == "") {
      await storage.write(key: "id_sale", value: bill.toString());
      final isSuccess =
          await ProductApi().addCart(bill.toString(), id_pro, qty, price);
      if (isSuccess == true) {
        final data = bill.toString();
        print("==>>>>>>>>>>>>>>DAta2:" + data.toString());
        return true;
      }
    }
    final isSuccess =
        await ProductApi().addCart(id.toString(), id_pro, qty, price);

    if (isSuccess == true) {
      final data = id.toString();
      print("==>>>>>>>>>>>>>>DAta3:" + data.toString());
      return true;
    } else {
      return false;
    }
  }

  getCartList() async {
    // print("==============ID: " + _id_sale.toString());
    var id = await storage.read(key: "id_sale");
    print("======>>>ID CART" + id.toString());

    carts = await ProductApi().getCart(id.toString());
    cartNetTotal = 0;
    for (int i = 0; i < carts.length; i++) {
      final item = carts[i];
      cartNetTotal +=
          int.parse(item.price.toString()) * int.parse(item.qty.toString());
    }
    notifyListeners();
  }

  Future<bool> deleteCart(String id_sale, String id_pro) async {
    var id = await storage.read(key: "id_sale");
    final isSuccess = await ProductApi().deleteCart(id.toString(), id_pro);
    if (isSuccess == true) {
      getCartList();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateCart(String id_sale, String id_pro, String option) async {
    // final id_sale = await storage.read(key: "id_sale");
    var id = await storage.read(key: "id_sale");
    final isSuccess =
        await ProductApi().updateCart(id.toString(), id_pro, option);
    if (isSuccess == true) {
      getCartList();
      return true;
    } else {
      return false;
    }
  }

  // Future<bool> saveOrder(
  //     {required String id_sale,
  //     required String total,
  //     required String name,
  //     required String tell,
  //     required String village,
  //     required String district,
  //     required String province}) async {
  //   final response = await ProductApi()
  //       .saveOrder(id_sale, total, name, tell, village, district, province);

  //   if (response == 'success') {
  //     // getBookListForManage();
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<bool> saveOrder(String id_sale, String total, String name, String tell,
      String village, String district, String province) async {
    var id = await storage.read(key: "id_sale");
    final isSuccess = await ProductApi().saveOrder(
        id.toString(), total, name, tell, village, district, province);
    if (isSuccess == true) {
      await storage.delete(key: "id_sale").toString();

      return true;
    } else {
      return false;
    }
  }

  Future<bool> searchhProduct(String name_pro) async {
    final isSuccess = await ProductApi().searchProduct(name_pro);
    if (isSuccess == true) {
      getCartList();
      return true;
    } else {
      return false;
    }
  }
}
