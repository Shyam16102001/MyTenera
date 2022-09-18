import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytenera/components/authentication.dart';
import 'package:mytenera/config/constants.dart';
import 'package:mytenera/screen/login_page/login_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
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
                      context, Icons.account_circle, "Account Management")),
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

  Widget neumorphismButton(BuildContext context, IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1),
            const BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1),
          ]),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 15),
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          const Icon(Icons.navigate_next),
        ],
      ),
    );
  }
}
