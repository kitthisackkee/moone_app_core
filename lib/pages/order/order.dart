import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moone_app/components/colors.dart';
import 'package:moone_app/models/orderModel.dart';
import 'package:moone_app/pages/cart/cart.dart';
import 'package:moone_app/pages/home/home.dart';
import 'package:moone_app/provider/providerService.dart';
import 'package:moone_app/shared/myData.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    super.key,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final telController = TextEditingController();
  final addressController = TextEditingController();
  final districtController = TextEditingController();
  final provinceController = TextEditingController();

  FlutterSecureStorage storage = FlutterSecureStorage();
  String? id;
  String? totalNetPrice;

  @override
  void initState() {
    // final providerService =
    //     Provider.of<ProviderService>(context, listen: false);
    // providerService.getCartList();
    super.initState();
    bill_id();
    // totalPrice();
  }

  bill_id() async {
    var _id = await storage.read(key: "id_sale");
    setState(() {
      id = _id;
    });
  }

  void totalPrice() async {
    totalNetPrice = await storage.read(key: "total");
  }

  @override
  Widget build(BuildContext context) {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);
    // providerService.getCartList();

    final id_sale = ModalRoute.of(context)?.settings.arguments;

    // OrderModel order = param != null ? param as OrderModel : OrderModel();
    // if (param != null) {
    //   totalNetPrice = order.total.toString();
    //   nameController.text = order.name.toString();
    //   telController.text = order.tell.toString();
    //   addressController.text = order.village.toString();
    //   districtController.text = order.district.toString();
    //   provinceController.text = order.province.toString();
    // }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                // providerService.id_sale = storage.delete(key: "id_sale");
                // print("======>>" + providerService.bill.toString());
              });
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          "ສັ່ງຊື້ສິນຄ້າ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: primaryColorBlack,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'ກະລຸນາຖ່າຍລະຫັດໃບບິນຂອງທ່ານ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    "ໄວ້ເພື່ອກວດສອບສິນຄ້າຂອງທ່ານ.${id}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300),
                  child: TextFormField(
                    controller: nameController,
                    // keyboardType: TextInputType.,
                    decoration: InputDecoration(
                        hintText: "ຊື່:...........",
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.person,
                          color: primaryColorBlack,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "ກະລຸນາປ້ອນຊື່";
                      }
                      // return "ເບີໂທຕ້ອງເປັນ 10 ຕົວເລກ";
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: telController,
                    // keyboardType: TextInputType.,
                    decoration: InputDecoration(
                        hintText: "ເບີໂທ:...........",
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.person,
                          color: primaryColorBlack,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "ກະລຸນາປ້ອນເບີ";
                      }
                      // return "ເບີໂທຕ້ອງເປັນ 10 ຕົວເລກ";
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300),
                  child: TextFormField(
                    controller: addressController,
                    // keyboardType: TextInputType.,
                    decoration: InputDecoration(
                        hintText: "ສະຖານທີ່ບ່ອນສົ່ງທີ່ຢູ່ປະຈຸບັນ:...........",
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.person,
                          color: primaryColorBlack,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "ກະລຸນາປ້ອນສະຖານທີ່ບ່ອນສົ່ງ(ທີ່ຢູ່ປະຈຸບັນ)";
                      }
                      // return "ເບີໂທຕ້ອງເປັນ 10 ຕົວເລກ";
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300),
                  child: TextFormField(
                    controller: districtController,
                    // keyboardType: TextInputType.,
                    decoration: InputDecoration(
                        hintText: "ເມືອງ:...........",
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.person,
                          color: primaryColorBlack,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "ກະລຸນາປ້ອນເມືອງ";
                      }
                      // return "ເບີໂທຕ້ອງເປັນ 10 ຕົວເລກ";
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300),
                  child: TextFormField(
                    controller: provinceController,
                    // keyboardType: TextInputType.,
                    decoration: InputDecoration(
                        hintText: "ແຂວງ:...........",
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.route,
                          color: primaryColorBlack,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "ກະລຸນາປ້ອນແຂວງ";
                      }
                      // return "ເບີໂທຕ້ອງເປັນ 10 ຕົວເລກ";
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    print(
                        "totalNetPrice.toString()" + totalNetPrice.toString());
                    if (_formKey.currentState!.validate()) {
                      final isSuccess = await providerService.saveOrder(
                        id.toString(),
                        providerService.cartNetTotal.toString(),
                        nameController.text.trim(),
                        telController.text.trim(),
                        addressController.text.trim(),
                        districtController.text.trim(),
                        provinceController.text.trim(),
                      );

                      if (isSuccess == true) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'ສຳເລັດ',
                          desc: 'ສັ່ງຊື້ສຳເລັດ',
                          // autoHide: Duration(seconds: 2),
                          btnCancelOnPress: () {},
                          btnOkOnPress: () async {
                            await storage.delete(key: "id_sale").toString();
                            // print("==========> bill clear" + id.toString());
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                'home', (Route<dynamic> route) => false);
                            // providerService.getCartList();
                          },
                        )..show();
                        // id.toString();
                        nameController.text = "";
                        telController.text = "";
                        addressController.text = "";
                        districtController.text = "";
                        provinceController.text = "";
                        // await storage.deleteAll();
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          autoHide: Duration(seconds: 2),
                          title: 'ແຈ້ງເຕືອນ',
                          desc: 'ເກີດຂໍ້ຜິດພາດໃນການສັ່ງຊື້',
                          // btnCancelOnPress: () {},
                          // btnOkOnPress: () {},
                        )..show();
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: primaryColorBlack,
                    ),
                    height: 60,
                    child: Center(
                      child: Text(
                        "ສັ່ງຊື້",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColorWhite,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
