import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  TextEditingController controller;
  CustomTextField({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          label: Text(label),
          labelStyle: TextStyle(color: Colors.blueGrey.shade900),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey))),
    );
  }
}
