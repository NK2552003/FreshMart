import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freshmart/screens/browse_page.dart';
import 'package:freshmart/screens/main_page.dart';
import 'package:freshmart/screens/orders_page.dart';
import 'package:freshmart/screens/profile.dart';
import 'package:freshmart/screens/settings.dart';
import 'package:freshmart/widgets/search_groscery.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> screen = [
    MainPage(),
    BrowsePage(),
    OrderPage(),
    SettingsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("FreshMart",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28)),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Badge(
              child: Icon(Icons.shopping_cart_rounded),
              label: Text("2"),
              isLabelVisible: true,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SearchGroscery(),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.blueGrey.shade900,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
              backgroundColor: Colors.blueGrey.shade900,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.blueGrey.shade600,
              tabActiveBorder:
                  Border.all(width: 1, color: Colors.deepPurple.shade900),
              padding: EdgeInsets.all(12),
              gap: 8,
              tabs: [
                GButton(
                  icon: Icons.home_rounded,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.shopping_bag,
                  text: "Browse",
                ),
                GButton(
                  icon: Icons.history,
                  text: "Orders",
                ),
                GButton(
                  icon: Icons.settings,
                  text: "Settings",
                ),
                GButton(
                  icon: Icons.person,
                  text: "Profile",
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: screen[_selectedIndex],
    );
  }
}
