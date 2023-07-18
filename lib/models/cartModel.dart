// To parse this JSON data, do
//
//     final CartModel = CartModelFromJson(jsonString);

import 'dart:convert';

class CartModel {
  int? idSale;
  int? idPro;
  String? namePro;
  int? qty;
  int? price;
  String? picture;
  String? detail;

  CartModel({
    this.idSale,
    this.idPro,
    this.namePro,
    this.qty,
    this.price,
    this.picture,
    this.detail,
  });

  CartModel copyWith({
    int? idSale,
    int? idPro,
    String? namePro,
    int? qty,
    int? price,
    String? picture,
    String? detail,
  }) =>
      CartModel(
        idSale: idSale ?? this.idSale,
        idPro: idPro ?? this.idPro,
        namePro: namePro ?? this.namePro,
        qty: qty ?? this.qty,
        price: price ?? this.price,
        picture: picture ?? this.picture,
        detail: detail ?? this.detail,
      );

  factory CartModel.fromRawJson(String str) =>
      CartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        idSale: json["id_sale"],
        idPro: json["id_pro"],
        namePro: json["name_pro"],
        qty: json["qty"],
        price: json["price"],
        picture: json["picture"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "id_sale": idSale,
        "id_pro": idPro,
        "name_pro": namePro,
        "qty": qty,
        "price": price,
        "picture": picture,
        "detail": detail,
      };
}
