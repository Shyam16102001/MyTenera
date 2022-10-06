import 'package:flutter/material.dart';
import 'package:mytenera/config/constants.dart';

Widget neumorphismButton(BuildContext context, IconData icon, String text) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade600,
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
