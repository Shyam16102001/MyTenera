import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String routeName = "/home_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Trending",
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(width: 10),
                  SvgPicture.asset("assets/icons/fire.svg", height: 30),
                ],
              ),
              SizedBox(height: 25),
              Container(
                color: Colors.amber,
                height: 400,
              ),
              SizedBox(height: 15),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recent Activity",
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
            ],
          )),
    );
  }
}
