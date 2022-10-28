import 'package:flutter/material.dart';
import 'package:mytenera/config/constants.dart';

Widget button(BuildContext context, String text, IconData icon, bool dark) {
  return Ink(
    padding: const EdgeInsets.all(10),
    width: 175,
    decoration: BoxDecoration(
      color: dark ? kPrimaryColor : kBackgroundColor,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        const BoxShadow(
            color: Colors.black,
            offset: Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 1),
        BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: dark ? kBackgroundColor : kPrimaryColor,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: dark
              ? Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .merge(const TextStyle(color: kBackgroundColor))
              : Theme.of(context).textTheme.titleLarge!,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
