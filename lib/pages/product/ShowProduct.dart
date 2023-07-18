import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moone_app/components/colors.dart';
import 'package:moone_app/pages/product/productDetail.dart';
import 'package:moone_app/provider/providerService.dart';
import 'package:moone_app/shared/myData.dart';
import 'package:provider/provider.dart';

class ShowProductPage extends StatefulWidget {
  const ShowProductPage({super.key});

  @override
  State<ShowProductPage> createState() => _ShowProductPageState();
}

class _ShowProductPageState extends State<ShowProductPage> {
  final SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
    final producttypes = providerService.producttypes;
    final products = providerService.products;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          primary: false,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.4,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: SearchController,
                          decoration: InputDecoration(
                            hintText: "ຄົ້ນຫາ...",
                            border: InputBorder.none,
                            // suffixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      // final id = SearchController.text;
                      int selectProductType = 0;
                      setState(() {
                        providerService.getProductListByType(
                            int.parse(selectProductType.toString()),
                            SearchController.text);
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: primaryColorBlack,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "ໝວດໝູ່",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ListView.builder(
                  itemCount: producttypes.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, int index) {
                    final item = producttypes[index];
                    return GestureDetector(
                      onTap: () {
                        providerService.getProductListByType(
                            int.parse(item.idType.toString()),
                            item.nameType.toString());
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color:
                                providerService.selectProductType != item.idType
                                    ? Colors.grey
                                    : primaryColorBlack,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        child: Center(
                            child: Text(
                          '${item.nameType}',
                          style: TextStyle(
                              color: providerService.selectProductType !=
                                      item.idType
                                  ? Colors.black
                                  : Colors.white),
                        )),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "ສິນຄ້າ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 210,
                child: products.length > 0
                    ? RefreshIndicator(
                        onRefresh: () async {
                          await Future.delayed(Duration(seconds: 2));
                          providerService.refreshData();
                        },
                        // child: MasonryGridView.builder(
                        //   mainAxisSpacing: 4,
                        //   crossAxisSpacing: 4,
                        //   gridDelegate:
                        //       SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 2,
                        //   ),
                        //   physics: AlwaysScrollableScrollPhysics(),
                        //   scrollDirection: Axis.vertical,
                        //   shrinkWrap: true,
                        //   itemCount: products.length,
                        //   itemBuilder: (context, index) {
                        //     final item = products[index];
                        //     return GestureDetector(
                        //       onTap: () {
                        //         providerService.resetQty();
                        //         Navigator.pushNamed(context, 'product-detail',
                        //             arguments: item.idPro);
                        //       },
                        //       child: Column(
                        //         children: [
                        //           SizedBox(
                        //             height: 250,
                        //             child: Column(
                        //               children: [
                        //                 Container(
                        //                   margin: EdgeInsets.only(right: 10),
                        //                   child: ClipRRect(
                        //                     borderRadius:
                        //                         BorderRadius.circular(8),
                        //                     child: FadeInImage(
                        //                       width: 100,
                        //                       placeholder: AssetImage(
                        //                           "assets/images/loading_plaholder.gif"),
                        //                       image: NetworkImage(
                        //                           // item.picture.toString()
                        //                           "https://image.uniqlo.com/UQ/ST3/WesternCommon/imagesgoods/422992/sub/goods_422992_sub14.jpg?width=494"),
                        //                       fit: BoxFit.cover,
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Expanded(
                        //                     child: Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   children: [
                        //                     Container(
                        //                         margin:
                        //                             EdgeInsets.only(bottom: 10),
                        //                         child: Text(
                        //                             item.namePro.toString(),
                        //                             style: TextStyle(
                        //                                 fontSize: 14,
                        //                                 fontWeight:
                        //                                     FontWeight.bold))),
                        //                     Expanded(
                        //                         child: Text(
                        //                       item.detail.toString(),
                        //                       maxLines: 4,
                        //                       overflow: TextOverflow.ellipsis,
                        //                       style: TextStyle(height: 1),
                        //                     )),
                        //                     Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment
                        //                               .spaceBetween,
                        //                       children: [
                        //                         // Flexible(
                        //                         //     child: Text(
                        //                         //         "ຜູ້ຂຽນ: ${item.author.toString()}")),
                        //                         Text(MyData.formatNumber(
                        //                             item.price))
                        //                       ],
                        //                     )
                        //                   ],
                        //                 ))
                        //               ],
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // ),
                        child: MasonryGridView.builder(
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          gridDelegate:
                              SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final data = products[index];
                            return InkWell(
                              onTap: () {
                                providerService.resetQty();
                                Navigator.pushNamed(context, 'product-detail',
                                    arguments: data.idPro);
                              },
                              child: Card(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          "${data.picture}",
                                          // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTR_5N9A7v2mELkWWDP1MYIrNy4kz8pzoFDBg&usqp=CAU",
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                        SizedBox(height: 10),
                                        Text("${data.namePro}"),
                                        SizedBox(height: 10),
                                        Text("${data.detail}"),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${MyData.formatNumber(data.price)} ກີບ",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Icon(
                                              Icons.shopping_cart_checkout,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_outlined,
                                  color: Colors.grey,
                                ),
                                Text(
                                  "ບໍ່ມີລາຍການສິນຄ້າ",
                                  style: TextStyle(color: Colors.grey),
                                )
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
    );
  }
}
