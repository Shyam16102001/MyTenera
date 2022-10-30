import 'package:mytenera/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

notAuctionfound(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
    child: Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(50)),
        SvgPicture.asset(
          "assets/icons/not_found.svg",
          height: getProportionateScreenHeight(300),
        ),
        Text(
          "No Auctions Found",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Text("Please visit after some time")
      ],
    ),
  );
}
