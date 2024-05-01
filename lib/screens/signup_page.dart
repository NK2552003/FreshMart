import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:freshmart/widgets/custom_button.dart';
import 'package:freshmart/widgets/custom_textfield.dart';
import 'package:social_login_buttons/social_login_buttons.dart'; // Added this import

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buildUI(context),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar();
  }

  Widget _buildUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context),
            _signupContainer(context),
            SizedBox(height: 30),
            _socialContainer(context),
            SizedBox(height: 20),
            _registerYs(context),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "Join FreshMart Today!",
          style: TextStyle(
              color: Colors.blueGrey.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              shadows: [
                Shadow(
                  color: Colors.blueGrey.shade200,
                  offset: Offset(1, 2),
                  blurRadius: 4,
                ),
              ])),
      TextSpan(
          text:
              "\nUnlock a world of fresh groceries delivered straight to your doorstep.",
          style: TextStyle(fontSize: 16)),
    ]));
  }

  Widget _signupContainer(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.45,
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          CustomTextField(
            label: "User Name",
            controller: userNameController,
          ),
          SizedBox(height: 20),
          CustomTextField(
            label: "Enter Email here ",
            controller: emailController,
          ),
          SizedBox(height: 20),
          CustomTextField(
            label: "Enter Password Here",
            controller: passwordController,
          ),
          SizedBox(height: 20),
          CustomTextField(
            label: "Phone Number",
            controller: phoneNumberController,
          ),
          SizedBox(height: 20),
          CustomButton(
            height: MediaQuery.sizeOf(context).height * 0.06,
            width: MediaQuery.sizeOf(context).width,
            isPrimary: true,
            onTap: () {
              String userName = userNameController.text;
              String email = emailController.text;
              String password = passwordController.text;
              String phoneNumber = phoneNumberController.text;

              _signUpWithEmailAndPassword(
                  email, password, userName, phoneNumber, context);
            },
            text: "SIGN UP",
          ),
        ],
      ),
    );
  }

  Widget _socialContainer(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.10,
      width: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("or Signup with", style: TextStyle(fontSize: 12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SocialLoginButton(
                text: "Google",
                height: MediaQuery.sizeOf(context).height * 0.05,
                width: MediaQuery.sizeOf(context).width * 0.40,
                borderRadius: 12,
                fontSize: 16,
                imageWidth: 24,
                buttonType: SocialLoginButtonType.google,
                onPressed: () {
                  _signInWithGoogle(context);
                },
              ),
              SocialLoginButton(
                text: "Facebook",
                height: MediaQuery.sizeOf(context).height * 0.05,
                width: MediaQuery.sizeOf(context).width * 0.40,
                fontSize: 16,
                borderRadius: 12,
                imageWidth: 24,
                buttonType: SocialLoginButtonType.facebook,
                onPressed: () {
                  _signInWithFacebook(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _registerYs(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text.rich(
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              TextSpan(
                children: [
                  TextSpan(text: "Already a user?"),
                  TextSpan(
                      text: "Login", style: TextStyle(color: Colors.blueGrey))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signUpWithEmailAndPassword(String email, String password,
      String userName, String phoneNumber, BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Update user's display name and phone number
      await user!.updateDisplayName(userName);

      // Navigate to the next screen
      Navigator.pushNamed(context, "/login");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      // Navigate to the next screen
      Navigator.pushNamed(context, "/home");
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred. Please try again later.';
      });
      print(e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      User? user = userCredential.user;

      // Navigate to the next screen
      Navigator.pushNamed(context, "/login");
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred. Please try again later.';
      });
      print(e);
    }
  }
}
