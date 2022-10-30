import 'package:flutter/material.dart';
import 'package:mytenera/config/constants.dart';

class NeumorphismButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback press;

  const NeumorphismButton(
      {Key? key, required this.text, required this.icon, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(25),
      splashColor: kSecondaryColor,
      child: Ink(
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
      ),
    );
  }
}

// Widget neumorphismButton(BuildContext context, IconData icon, String text) {
//   return Ink(
//     padding: const EdgeInsets.all(15),
//     decoration: BoxDecoration(
//         color: kBackgroundColor,
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.grey.shade600,
//               offset: const Offset(4, 4),
//               blurRadius: 15,
//               spreadRadius: 1),
//           const BoxShadow(
//               color: Colors.white,
//               offset: Offset(-4, -4),
//               blurRadius: 15,
//               spreadRadius: 1),
//         ]),
//     child: Row(
//       children: [
//         Icon(icon),
//         const SizedBox(width: 15),
//         Text(
//           text,
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//         const Spacer(),
//         const Icon(Icons.navigate_next),
//       ],
//     ),
//   );
// }
