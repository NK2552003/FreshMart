import 'package:flutter/material.dart';

class SearchGroscery extends StatelessWidget {
  const SearchGroscery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.blueGrey.shade500,
        ),
      ),
    );
  }
}
