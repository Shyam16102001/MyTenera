import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytenera/components/authentication.dart';
import 'package:mytenera/components/neumorphism_button.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(
                      "${FirebaseAuth.instance.currentUser!.photoURL}"),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "${FirebaseAuth.instance.currentUser!.displayName}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 5),
              Text(
                "${FirebaseAuth.instance.currentUser!.email}",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 25),
              GestureDetector(
                  onTap: () {},
                  child: neumorphismButton(
                      context, Icons.account_circle, "Auction History")),
              const SizedBox(height: 25),
              GestureDetector(
                  onTap: () {},
                  child: neumorphismButton(
                      context, Icons.receipt_long, "Transaction History")),
              const SizedBox(height: 25),
              GestureDetector(
                  onTap: () {},
                  child:
                      neumorphismButton(context, Icons.help, "Help & Support")),
              const SizedBox(height: 25),
              GestureDetector(
                  onTap: () {
                    signOut().then(
                      (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginPage.routeName, (Route<dynamic> route) => false),
                    );
                  },
                  child: neumorphismButton(context, Icons.logout, "Log out")),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
