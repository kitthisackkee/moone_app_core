import 'package:flutter/material.dart';
import 'package:moone_app/pages/home/home.dart';
import 'package:moone_app/pages/order/order.dart';
import 'package:moone_app/pages/product/productDetail.dart';
import 'package:moone_app/provider/providerService.dart';
import 'package:moone_app/router/router.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderService()),
        // ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: Consumer<ProviderService>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'MOONE',
            theme: ThemeData(
                brightness: Brightness.light, fontFamily: 'NotoSansLao'),
            darkTheme: ThemeData(
                brightness: Brightness.dark, fontFamily: 'NotoSansLao'),
            initialRoute: 'home',
            debugShowCheckedModeBanner: false,
            routes: {
              // 'login': (_) => const LoginPage(),
              'home': (_) => const HomePage(),
              'product-detail': (_) => ProductDetailPage(),
              'order': (_) => OrderPage(),
              // 'product-add': (_) => const ProductAddPage(),
            },
          );
        },
      ),
    );
  }
}
