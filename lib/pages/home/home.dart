import 'package:flutter/material.dart';
import 'package:moone_app/components/colors.dart';
import 'package:moone_app/pages/cart/cart.dart';
import 'package:moone_app/pages/product/ShowProduct.dart';
import 'package:moone_app/pages/product/productDetail.dart';
import 'package:moone_app/provider/providerService.dart';
import 'package:provider/provider.dart';

import '../../components/styple.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColorBlack,
        centerTitle: true,
        title: Text(
          "MOONE",
          style: textStyle(
            fontSize: 24,
            color: primaryColorWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: PageView(
          controller: Provider.of<ProviderService>(context, listen: true)
              .pageController,
          children: [
            ShowProductPage(),
            CartPage(),
          ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            Provider.of<ProviderService>(context, listen: false).pageSelected,
        onTap: (index) {
          Provider.of<ProviderService>(context, listen: false).pageSelected =
              index;
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt, color: primaryColorBlack),
              label: 'ໜ້າຫຼັກ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag, color: primaryColorBlack),
              label: 'ກະຕ່າ'),
        ],
      ),
    );
  }
}
