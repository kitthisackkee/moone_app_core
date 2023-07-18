import 'package:flutter/material.dart';

class TextFromFieldS extends StatelessWidget {
  final String hintText;
  const TextFromFieldS({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
