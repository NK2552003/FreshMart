import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final width, height;
  final bool isPrimary;
  final Function onTap;
  final String text;
  const CustomButton(
      {super.key,
      required this.height,
      this.width,
      required this.isPrimary,
      required this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: isPrimary ? Colors.blueGrey.shade900 : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: isPrimary ? null : Border.all(color: Colors.blueGrey.shade900),
        boxShadow: isPrimary
            ? const [
                BoxShadow(
                  color: Color.fromARGB(255, 26, 34, 38),
                  offset: Offset(2, 3),
                  blurRadius: 4,
                ),
              ]
            : [],
      ),
      child: MaterialButton(
        onPressed: () => onTap(),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isPrimary ? Colors.white : Colors.blueGrey.shade900),
        ),
      ),
    );
  }
}
