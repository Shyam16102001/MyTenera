import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mytenera/components/authentication.dart';
import 'package:mytenera/components/neumorphism_button.dart';
import 'package:mytenera/config/size_config.dart';
import 'package:mytenera/screen/auction_page/auction_page.dart';
import 'package:mytenera/screen/login_page/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static String routeName = "/profile";

  Future<void> signOut() async {
    await Authentication().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(16)),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: getProportionateScreenHeight(80),
                  backgroundImage: NetworkImage(
                      "${FirebaseAuth.instance.currentUser!.photoURL}"),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                "${FirebaseAuth.instance.currentUser!.displayName}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              Text(
                "${FirebaseAuth.instance.currentUser!.email}",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              NeumorphismButton(
                  text: "Auction History",
                  icon: Icons.account_circle,
                  press: () {}),
              SizedBox(height: getProportionateScreenHeight(25)),
              NeumorphismButton(
                  text: "Help & Support",
                  icon: Icons.help,
                  press: () => helpDialog(context)),
              SizedBox(height: getProportionateScreenHeight(25)),
              NeumorphismButton(
                  text: "About Us",
                  icon: Icons.info,
                  press: () => aboutUs(context)),
              SizedBox(height: getProportionateScreenHeight(25)),
              NeumorphismButton(
                text: "Log out",
                icon: Icons.logout,
                press: () {
                  signOut().then(
                    (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginPage.routeName, (Route<dynamic> route) => false),
                  );
                },
              ),
              SizedBox(height: getProportionateScreenHeight(25)),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> helpDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              icon: const Icon(Icons.help_outline, size: 50),
              title: Text(
                "Help & Support",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              content: SizedBox(
                height: 55,
                child: Column(
                  children: [
                    const Text("For you quries please contact "),
                    SelectableText(
                      "mytenera@gmail.com",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .merge(const TextStyle(color: Colors.indigo)),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"))
              ],
            ));
  }

  void aboutUs(BuildContext context) {
    return showAboutDialog(
        context: context,
        applicationIcon: SvgPicture.asset(
          'assets/icons/logo.svg',
          height: 30,
        ),
        // applicationName: "MyTenera",
        applicationVersion: "2.3.0",
        applicationLegalese:
            "An application to make the tender process easy and transparent.");
  }
}
