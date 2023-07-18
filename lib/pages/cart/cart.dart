import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moone_app/components/colors.dart';
import 'package:moone_app/pages/order/order.dart';
import 'package:moone_app/provider/providerService.dart';
import 'package:moone_app/shared/myData.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double bottomSize = 80;

  var _totalNetPrice;
  String get totalNetPrice => _totalNetPrice;

  FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void initState() {
    // print("=============" + MyData.id_sale);
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    providerService.getCartList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final String bill_id = id_sale.toString();
    final providerService =
        Provider.of<ProviderService>(context, listen: false);
    final carts = providerService.carts;

    int? totalPrice = providerService.cartNetTotal;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: primaryColorBlack,
      //   centerTitle: true,
      //   title: Text('ສິນຄ້າໃນກະຕ່າ'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    kToolbarHeight -
                    MediaQuery.of(context).padding.top -
                    kBottomNavigationBarHeight -
                    bottomSize,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: carts.length > 0
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: carts.length,
                          itemBuilder: (context, index) {
                            final item = carts[index];
                            return GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: FadeInImage(
                                              placeholder: AssetImage(
                                                  "assets/images/loading_plaholder.gif"),
                                              width: 85,
                                              image: NetworkImage(
                                                  // item.picture.toString()
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTR_5N9A7v2mELkWWDP1MYIrNy4kz8pzoFDBg&usqp=CAU"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 5),
                                                child: Text(
                                                  item.namePro.toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 5),
                                                  child: Text(
                                                      "Price: ${MyData.formatNumber(item.price)}")),
                                              Expanded(child: Container()),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      providerService
                                                          .deleteCart(
                                                              item.idSale
                                                                  .toString(),
                                                              item.idPro
                                                                  .toString());
                                                    },
                                                    child: Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.red,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (item.qty == 1) {
                                                            return;
                                                          }

                                                          providerService
                                                              .updateCart(
                                                            item.idSale
                                                                .toString(),
                                                            item.idPro
                                                                .toString(),
                                                            'decrease',
                                                          );
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .remove_circle_outline,
                                                          color: Colors.black,
                                                          size: 30,
                                                        ),
                                                      ),
                                                      Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Text(item.qty
                                                              .toString())),
                                                      GestureDetector(
                                                        onTap: () {
                                                          providerService
                                                              .updateCart(
                                                                  item.idSale
                                                                      .toString(),
                                                                  item.idPro
                                                                      .toString(),
                                                                  'increase');
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .add_circle_outline,
                                                          color: Colors.black,
                                                          size: 30,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: ((context, index) {
                            return Divider();
                          }),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.search_outlined),
                                Text("ບໍ່ມີລາຍການສິນຄ້າ")
                              ],
                            )
                          ],
                        ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        height: bottomSize,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                "ລວມທັງໝົດ: ${MyData.formatNumber(providerService.cartNetTotal)} ກີບ",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: carts.length > 0
                  ? () async {
                      
                      // Navigator.pushNamed(
                      //   context,
                      //   'order',
                      // );
                      setState(() {
                        // final providerService = Provider.of<ProviderService>(
                        //     context,
                        //     listen: false);
                        // providerService.getCartList();
                        // providerService.getCartList();
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderPage(),
                          ));
                      // _totalNetPrice = storage.write(
                      //     key: "total",
                      //     value: providerService.cartNetTotal.toString());
                    }
                  : null,
              child: Text("ສັ່ງຊື້"),
            )
          ],
        ),
      ),
    );
  }
}
