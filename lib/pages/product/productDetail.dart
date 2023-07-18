import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moone_app/components/colors.dart';
import 'package:moone_app/models/cartModel.dart';
import 'package:moone_app/models/productModel.dart';
import 'package:moone_app/provider/providerService.dart';
import 'package:moone_app/shared/myData.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  double bottomSize = 80;
  String? _id;
  get id => _id;

  FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final proID = ModalRoute.of(context)?.settings.arguments;
    final providerService = Provider.of<ProviderService>(context);
    var bill = Random().nextInt(1000000 - 100 + 1) + 100;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColorBlack,
        elevation: 0,
        title: Text(
          "ລາຍລະອຽດສິນຄ້າ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: FutureBuilder(
          future: providerService.getProductByproID(proID.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final item = snapshot.data as ProductModel;
              // final id_sale = storage.read(key: "id_sale");
              // final id_bill = storage.write(key: "id_sale");
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                // Container(
                                //   child: Text(
                                //     item.namePro.toString(),
                                //     style:
                                //         TextStyle(fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [],
                                )),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                Container(
                                  child: ClipRRect(
                                    // borderRadius: BorderRadius.circular(8),
                                    child: FadeInImage(
                                      width: MediaQuery.of(context).size.width,
                                      placeholder: AssetImage(
                                          "assets/images/loading_plaholder.gif"),
                                      image: NetworkImage(
                                          // item.picture.toString(),
                                          "https://img.freepik.com/free-psd/tote-bag_125540-368.jpg?w=900&t=st=1689174350~exp=1689174950~hmac=36ed95054c2d72271dfab9eee3fc8981d468cae12b5834dd9940a8fe79f782b8"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      item.namePro.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        "ລາຍລະອຽດ: ${item.detail.toString()}"),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${MyData.formatNumber(item.price)} ກີບ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                              fontSize: 20),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  providerService.decreaseQty();
                                                },
                                                icon: Icon(Icons
                                                    .remove_circle_outline)),
                                            Container(
                                              child: Text(providerService
                                                  .cartQty
                                                  .toString()),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  providerService.increaseQty();
                                                },
                                                icon: Icon(
                                                    Icons.add_circle_outline)),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  foregroundColor:
                                                      Colors.white),
                                              onPressed: () async {
                                                // print(MyData.customerUUID);
                                                print("===============" +
                                                    item.idPro.toString());
                                                print("===================" +
                                                    providerService.cartQty
                                                        .toString());
                                                final isSuccess =
                                                    await providerService
                                                        .addCart(
                                                  // bill.toString(),
                                                  // bill.toString(),
                                                  item.idPro.toString(),
                                                  providerService.cartQty
                                                      .toString(),
                                                  item.price.toString(),
                                                );

                                                print(isSuccess);
                                                if (isSuccess == true) {
                                                  AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.success,
                                                    animType:
                                                        AnimType.rightSlide,
                                                    title: 'ແຈ້ງເຕືອນ',
                                                    desc:
                                                        'ເພິ່ມສິນຄ້າໃສ່ກະຕ່າສຳເລັດ',
                                                    autoHide:
                                                        Duration(seconds: 2),
                                                    // btnCancelOnPress: () {},
                                                    // btnOkOnPress: () {},
                                                  )..show();
                                                } else {
                                                  AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.warning,
                                                    animType:
                                                        AnimType.rightSlide,
                                                    title: 'ແຈ້ງເຕືອນ',
                                                    desc:
                                                        'ເກີດຂໍ້ຜິດພາດໃນການເພິ່ມສິນຄ້າໃສ່ກະຕ່າ',
                                                    btnCancelOnPress: () {},
                                                    btnOkOnPress: () {},
                                                  )..show();
                                                }

                                                // final snackBar = SnackBar(
                                                //   backgroundColor: isSuccess ==
                                                //           true
                                                //       ? Colors.greenAccent[700]
                                                //       : Colors.red,
                                                //   content: Text(
                                                //     isSuccess == true
                                                //         ? "ເພິ່ມສິນຄ້າໃສ່ກະຕ່າສຳເລັດ"
                                                //         : "ເກີດຂໍ້ຜິດພາດ",
                                                //     style: TextStyle(
                                                //         fontSize: 14,
                                                //         fontFamily:
                                                //             "NotoSansLao"),
                                                //   ),
                                                //   duration:
                                                //       Duration(seconds: 2),
                                                // );

                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(snackBar);
                                              },
                                              child: Text("ເພິ່ມໃສ່ກະຕ່າ"),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                                // Text(
                                //   item.description.toString(),
                                //   maxLines: 50,
                                //   overflow: TextOverflow.ellipsis,
                                // )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              );
            }
          },
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: FutureBuilder(
      //     future: providerService.getProductByproID(proID.toString()),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         final item = snapshot.data as ProductModel;

      //         return SingleChildScrollView(
      //           child: Column(
      //             children: [
      //               Container(
      //                 height: 400,
      //                 //decoration: BoxDecoration(color: primaryColorGreen),
      //                 child: Stack(
      //                   children: [
      //                     Image.network(
      //                       item.picture!,
      //                       width: double.infinity,
      //                       fit: BoxFit.cover,
      //                     ),
      //                     Positioned(
      //                       top: 30,
      //                       left: 10,
      //                       child: InkWell(
      //                         onTap: () {
      //                           Navigator.pop(context);
      //                         },
      //                         child: Container(
      //                           height: 40,
      //                           width: 40,
      //                           decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.circular(10),
      //                               color: Colors.white,
      //                               boxShadow: [
      //                                 BoxShadow(
      //                                   color: Colors.grey.withOpacity(0.5),
      //                                   spreadRadius: 3,
      //                                   blurRadius: 7,
      //                                   offset: Offset(
      //                                       0, 3), // changes position of shadow
      //                                 ),
      //                               ]),
      //                           child: Center(
      //                             child: Icon(
      //                               Icons.arrow_back_ios,
      //                               color: Colors.black,
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     Positioned(
      //                       top: 30,
      //                       right: 10,
      //                       child: Container(
      //                         height: 40,
      //                         width: 40,
      //                         decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(10),
      //                             color: primaryColorWhite,
      //                             boxShadow: [
      //                               BoxShadow(
      //                                 color: Colors.grey.withOpacity(0.5),
      //                                 spreadRadius: 3,
      //                                 blurRadius: 7,
      //                                 offset: Offset(
      //                                     0, 3), // changes position of shadow
      //                               ),
      //                             ]),
      //                         child: Center(
      //                           child: Icon(
      //                             Icons.shopping_bag,
      //                             color: primaryColorBlack,
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Container(
      //                 height: 400,
      //                 decoration: BoxDecoration(
      //                     color: Colors.white,
      //                     borderRadius: BorderRadius.only(
      //                       topLeft: Radius.circular(10),
      //                       topRight: Radius.circular(10),
      //                     ),
      //                     boxShadow: [
      //                       BoxShadow(
      //                         color: Colors.grey.withOpacity(0.5),
      //                         spreadRadius: 6,
      //                         blurRadius: 10,
      //                         offset:
      //                             Offset(0, 3), // changes position of shadow
      //                       ),
      //                     ]),
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text(
      //                           "${item.namePro}",
      //                           style: TextStyle(
      //                             fontSize: 18,
      //                             fontWeight: FontWeight.bold,
      //                           ),
      //                         ),
      //                         Text(
      //                           item.detail!,
      //                           //"TKGirl ใหม่ล่าสุด รองเท้าแตะน้องฉลามสีเรนโบว์มีให้เลือก ถึง 3แบบ🏳️‍🌈 🐳 สีสันสดใส พาสเทลบาดจุยมากแม่ จึ้งงงง",
      //                           style:
      //                               TextStyle(fontSize: 15, color: Colors.grey),
      //                         ),
      //                         SizedBox(height: 10),
      //                         Divider(
      //                           indent: 50,
      //                           endIndent: 50,
      //                         ),
      //                         SizedBox(height: 10),
      //                         Text(
      //                           "LAK 20,000,000 /ຈຳນວນ ${item.price}",
      //                           style: TextStyle(
      //                               fontSize: 18,
      //                               fontWeight: FontWeight.bold,
      //                               color: primaryOrange),
      //                         ),
      //                         SizedBox(height: 10),
      //                         Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             InkWell(
      //                               onTap: () {
      //                                 // Navigator.push(
      //                                 //     context,
      //                                 //     MaterialPageRoute(
      //                                 //         builder: (context) => Payment(
      //                                 //               productModel: widget.productModel,
      //                                 //             )));
      //                               },
      //                               child: Center(
      //                                 child: Container(
      //                                   height: 50,
      //                                   width:
      //                                       MediaQuery.of(context).size.width /
      //                                           2.2,
      //                                   decoration: BoxDecoration(
      //                                     borderRadius:
      //                                         BorderRadius.circular(10),
      //                                     color: Colors.amber,
      //                                   ),
      //                                   child: Center(
      //                                     child: Text(
      //                                       "ສັ່ງຊື້ເລີຍ",
      //                                       style: TextStyle(
      //                                         fontSize: 18,
      //                                         color: primaryColorWhite,
      //                                         fontWeight: FontWeight.bold,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ),
      //                             ),
      //                             Center(
      //                               child: Container(
      //                                 height: 50,
      //                                 width: MediaQuery.of(context).size.width /
      //                                     2.2,
      //                                 decoration: BoxDecoration(
      //                                   borderRadius: BorderRadius.circular(10),
      //                                   color: primaryColorGreen,
      //                                 ),
      //                                 child: Center(
      //                                   child: Text(
      //                                     "ໂທສອບຖາມ",
      //                                     style: TextStyle(
      //                                       fontSize: 18,
      //                                       color: primaryColorWhite,
      //                                       fontWeight: FontWeight.bold,
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ]),
      //                 ),
      //               )
      //             ],
      //           ),
      //         );
      //       } else {
      //         return Center(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [CircularProgressIndicator()],
      //           ),
      //         );
      //       }
      //     },
      //   ),
      // ),
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.all(8),
      //   height: bottomSize,
      //   color: primaryColorBlack,
      //   child: Text(data),
      // ),
    );
  }
}
