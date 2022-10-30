import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mytenera/config/constants.dart';
import 'package:mytenera/config/size_config.dart';
import 'package:mytenera/screen/auction_page/auction_page.dart';
import 'package:mytenera/screen/home_page/home_page.dart';
import 'package:mytenera/screen/profile_page/profile_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});
  static String routeName = "/navigation";

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  List<Widget> body = [
    const HomePage(),
    const AuctionPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = 2;
              });
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "${FirebaseAuth.instance.currentUser!.photoURL}"),
            ),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: SafeArea(child: body[_currentIndex]),
      bottomNavigationBar: Container(
        color: kPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: GNav(
              selectedIndex: _currentIndex,
              gap: 8,
              backgroundColor: kPrimaryColor,
              color: kBackgroundColor,
              activeColor: kBackgroundColor,
              tabBackgroundColor: kPrimaryLightColor.withOpacity(0.3),
              padding: const EdgeInsets.all(16),
              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              duration: kAnimationDuration,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.gavel,
                  text: "Auction",
                ),
                GButton(
                  icon: Icons.person,
                  text: "Profile",
                ),
              ]),
        ),
      ),
    );
  }
}
