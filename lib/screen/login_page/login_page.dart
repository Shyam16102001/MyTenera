import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mytenera/components/authentication.dart';
import 'package:mytenera/components/navigation.dart';
import 'package:mytenera/config/constants.dart';
import 'package:mytenera/config/size_config.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String routeName = "/login_page";

  Future<User?> signInWithGoogle() async {
    User? user = await Authentication().signInWithGoogle();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(10)),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "Welcome to",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "MYTENERA!!",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
              SvgPicture.asset("assets/images/splashScreen.svg"),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(getProportionateScreenHeight(15)),
                child: SizedBox(
                  width: double.infinity,
                  height: getProportionateScreenHeight(60),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 10),
                    onPressed: () {
                      signInWithGoogle().then((user) {
                        if (user != null) {
                          Navigator.of(context)
                              .popAndPushNamed(Navigation.routeName);
                        } else {
                          Navigator.of(context)
                              .popAndPushNamed(LoginPage.routeName);
                        }
                      });
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/google.svg",
                            height: getProportionateScreenHeight(35),
                          ),
                          SizedBox(width: getProportionateScreenWidth(10)),
                          Text("Sign In With Google",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .merge(const TextStyle(color: Colors.white)))
                        ]),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(50)),
            ],
          ),
        ));
  }
}
