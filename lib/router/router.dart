import 'package:flutter/material.dart';
import 'package:moone_app/pages/home/home.dart';

class RouterAPI {
  static const home = "/home";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      default:
        throw const FormatException("Route not found! check routes again!");
    }
  }
}
