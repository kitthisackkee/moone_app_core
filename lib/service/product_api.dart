import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moone_app/components/api.dart';
import 'package:moone_app/models/cartModel.dart';
import 'package:moone_app/models/productModel.dart';

import 'package:moone_app/models/productType.dart';
import 'package:moone_app/shared/myData.dart';

class ProductApi {
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<List<ProductTypeModel>> getProductTypeList() async {
    List<ProductTypeModel> producttypes = [];
    final http.Response response = await http.get(
        Uri.parse('${baseUrl.toString()}/category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        });

    if (response.statusCode == 200) {
      producttypes = (json.decode(response.body) as List)
          .map((e) => ProductTypeModel.fromJson(e))
          .toList();
      return producttypes;
    } else {
      throw Exception('Failed to get productType');
    }
  }

  Future<List<ProductModel>> getProductList() async {
    List<ProductModel> products = [];
    final http.Response response = await http.get(
        Uri.parse('${baseUrl.toString()}/product_list'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        });

    if (response.statusCode == 200) {
      products = (json.decode(response.body) as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return products;
    } else {
      throw Exception('Failed to book');
    }
  }

  Future<List<ProductModel>> getProductListByType(
      int categoryId, String name_pro) async {
    List<ProductModel> products = [];
    final http.Response response = await http.get(
        Uri.parse('${baseUrl.toString()}/product/${categoryId}/${name_pro}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        });

    if (response.statusCode == 200) {
      products = (json.decode(response.body) as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return products;
    } else {
      throw Exception('Failed to book');
    }
  }

  Future<ProductModel> getProductByproID(String uuid) async {
    ProductModel product = ProductModel();
    final http.Response response = await http.get(
        Uri.parse('${baseUrl.toString()}/product_detail/${uuid}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        });

    if (response.statusCode == 200) {
      product = ProductModel.fromJson(json.decode(response.body));

      return product;
    } else {
      throw Exception('Failed to book');
    }
  }

  Future<bool> addCart(
      String id_sale, String id_pro, String qty, String price) async {
    final http.Response response =
        await http.post(Uri.parse('${baseUrl.toString()}/product/add-cart'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "Accept": "application/json",
            },
            body: jsonEncode(<String, String>{
              'id_sale': id_sale,
              'id_pro': id_pro,
              'qty': qty,
              'price': price,
            }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<CartModel>> getCart(String id_sale) async {
    List<CartModel> carts = [];
    final http.Response response =
        await http.post(Uri.parse('${baseUrl.toString()}/product/get-cart'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "Accept": "application/json",
            },
            body: jsonEncode(<String, String>{
              'id_sale': id_sale,
            }));

    if (response.statusCode == 200) {
      carts = (json.decode(response.body) as List)
          .map((e) => CartModel.fromJson(e))
          .toList();
      return carts;
    } else {
      throw Exception('Failed to book');
    }
  }

  Future<bool> deleteCart(String id_sale, String id_pro) async {
    final http.Response response =
        await http.post(Uri.parse('${baseUrl.toString()}/product/delete-cart'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "Accept": "application/json",
            },
            body: jsonEncode(<String, String>{
              'id_sale': id_sale,
              'id_pro': id_pro,
            }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateCart(String id_sale, String id_pro, String option) async {
    final http.Response response = await http.post(
        Uri.parse('${baseUrl.toString()}/product/update-cart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        },
        body: jsonEncode(<String, String>{
          'id_sale': id_sale,
          'id_pro': id_pro,
          'option': option
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Future<bool> saveOrder(String id_sale, String total, String name, String tell,
  //     String village, String district, String province) async {
  //   final http.Response response =
  //       await http.post(Uri.parse('${baseUrl.toString()}/product/order'),
  //           headers: <String, String>{
  //             'Content-Type': 'application/json; charset=UTF-8',
  //             "Accept": "application/json",
  //           },
  //           body: jsonEncode(<String, String>{
  //             'id_sale': id_sale,
  //             'total': total,
  //             'name': name,
  //             'tell': tell,
  //             'village': tell,
  //             'district': tell,
  //             'province': tell,
  //           }));

  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<bool> saveOrder(String id_sale, String total, String name, String tell,
      String village, String district, String province) async {
    final http.Response response =
        await http.post(Uri.parse('${baseUrl.toString()}/product/order'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "Accept": "application/json",
            },
            body: jsonEncode(<String, String>{
              'id_sale': id_sale,
              'total': total,
              'name': name,
              'tell': tell,
              'village': village,
              'district': district,
              'province': province,
            }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ProductModel>> searchProductName(String name_pro) async {
    List<ProductModel> products = [];
    final http.Response response = await http.get(
        Uri.parse('${baseUrl.toString()}/product/${name_pro}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        });

    if (response.statusCode == 200) {
      products = (json.decode(response.body) as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return products;
    } else {
      throw Exception('Failed to book');
    }
  }
}
