import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:freshmart/widgets/custom_button.dart';
import 'package:freshmart/widgets/custom_textfield.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  String? errorMessage;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
            if (errorMessage != null) ...[
              SizedBox(height: 10),
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ],
            _header(context),
            _loginContainer(context),
            SizedBox(height: 30),
            _socialContainer(context),
            SizedBox(height: 30),
            _registerYs(context),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "Welcome Back !",
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
          text: "\nLogin to access you cart and your shipment details",
          style: TextStyle(fontSize: 16)),
    ]));
  }

  Widget _loginContainer(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.30,
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          CustomTextField(
            label: "Email",
            controller: emailController,
          ),
          SizedBox(height: 20),
          CustomTextField(
            label: "Password",
            controller: passwordController,
          ),
          SizedBox(height: 20),
          CustomButton(
            height: MediaQuery.sizeOf(context).height * 0.06,
            width: MediaQuery.sizeOf(context).width,
            isPrimary: true,
            onTap: () {
              String email = emailController.text;
              String password = passwordController.text;

              _signInWithEmailAndPassword(email, password, context);
            },
            text: "LOGIN",
          ),
          SizedBox(height: 10),
          Text(
            "Forgot Password?",
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
          Text("or Login with", style: TextStyle(fontSize: 12)),
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
                  TextSpan(text: "Don't Have an Account?"),
                  TextSpan(
                      text: "Sign Up",
                      style: TextStyle(color: Colors.blueGrey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    setState(() {
      errorMessage = null;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Navigate to the next screen
      Navigator.pushNamed(context, "/home");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          errorMessage = 'No user found for that email.';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          errorMessage = 'Wrong password provided for that user.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred. Please try again later.';
      });
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
      Navigator.pushNamed(context, "/home");
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred. Please try again later.';
      });
      print(e);
    }
  }
}
