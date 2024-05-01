import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:freshmart/screens/home_page.dart';
import 'package:freshmart/screens/login_page.dart';
import 'package:freshmart/screens/welcome_page.dart';
import 'screens/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Groscery());
}

class Groscery extends StatelessWidget {
  const Groscery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Groscery App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey.shade800),
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUp(),
        '/home': (context) => HomePage(),
      },
      initialRoute: '/welcome',
    );
  }
}
