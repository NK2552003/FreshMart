import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freshmart/widgets/custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _UserInterFace(
        context,
      ),
    );
  }

  Widget _UserInterFace(BuildContext context) {
    return Stack(
      children: [
        _Grad(
          context,
        ),
        _WidgetTop(context),
      ],
    );
  }

  Widget _Grad(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            stops: const [0.35, 0.35],
            colors: [Colors.blueGrey.shade500, Colors.blueGrey.shade900]),
      ),
    );
  }

  Widget _WidgetTop(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _avatarImage(context),
          SizedBox(
            height: 40,
          ),
          _Container(context),
        ],
      ),
    ));
  }

  Widget _avatarImage(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.75,
      height: MediaQuery.sizeOf(context).height * 0.35,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Image.asset(
              'lib/assets/images/p.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget _Container(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.40,
      width: MediaQuery.sizeOf(context).width * 0.90,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(color: Colors.deepPurple),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Heading(context),
          CustomButton(
            height: MediaQuery.sizeOf(context).height * 0.06,
            width: MediaQuery.sizeOf(context).width * 0.70,
            isPrimary: true,
            onTap: () {
              Navigator.pushNamed(context, "/login");
            },
            text: "LOGIN",
          ),
          CustomButton(
            height: MediaQuery.sizeOf(context).height * 0.06,
            width: MediaQuery.sizeOf(context).width * 0.70,
            isPrimary: false,
            onTap: () {
              Navigator.pushNamed(context, "/signup");
            },
            text: "SIGN UP",
          ),
        ],
      ),
    );
  }

  Widget _Heading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 30),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
                text: "Welcome to",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
            TextSpan(
                text: " FreshMart ",
                style: TextStyle(
                    color: Colors.blueGrey.shade500,
                    fontWeight: FontWeight.w900,
                    fontSize: 34,
                    shadows: [
                      Shadow(
                        color: Colors.blueGrey.shade900,
                        offset: Offset(1, 2),
                        blurRadius: 5,
                      ),
                    ])),
            TextSpan(
              text:
                  "\nYour one-stop shop for fresh groceries delivered to your doorstep!",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
