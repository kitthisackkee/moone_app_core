class OrderModel {
  String? id_sale;
  int? total;
  String? name;
  String? tell;
  String? village;
  String? district;
  String? province;

  OrderModel({
    this.id_sale,
    this.total,
    this.name,
    this.tell,
    this.village,
    this.district,
    this.province,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id_sale = json['id_sale'];
    total = json['total'];
    name = json['name'];
    tell = json['tell'];
    village = json['village'];
    district = json['district'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_sale'] = this.id_sale;
    data['toatl'] = this.total;
    data['name'] = this.name;
    data['tell'] = this.tell;
    data['village'] = this.village;
    data['district'] = this.district;
    data['province'] = this.province;

    return data;
  }
}
