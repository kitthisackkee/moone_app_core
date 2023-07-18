class ProductTypeModel {
  int? idType;
  String? nameType;

  ProductTypeModel({this.idType, this.nameType});

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
    idType = json['id_type'];
    nameType = json['name_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_type'] = this.idType;
    data['name_type'] = this.nameType;
    return data;
  }
}
