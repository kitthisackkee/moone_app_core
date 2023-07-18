class ProductModel {
  int? idPro;
  String? namePro;
  String? typeP;
  int? qty;
  int? price;
  String? picture;
  String? detail;

  ProductModel(
      {this.idPro,
      this.namePro,
      this.typeP,
      this.qty,
      this.price,
      this.picture,
      this.detail});

  ProductModel.fromJson(Map<String, dynamic> json) {
    idPro = json['id_pro'];
    namePro = json['name_pro'];
    typeP = json['type_p'];
    qty = json['qty'];
    price = json['price'];
    picture = json['picture'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pro'] = this.idPro;
    data['name_pro'] = this.namePro;
    data['type_p'] = this.typeP;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['picture'] = this.picture;
    data['detail'] = this.detail;
    return data;
  }
}
