import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AutoionPage extends StatefulWidget {
  const AutoionPage({super.key});
  static String routeName = "/aution_page";

  @override
  State<AutoionPage> createState() => _AutoionPageState();
}

class _AutoionPageState extends State<AutoionPage> {
  List autionList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(15),
      child:Column(
        children: [
          Text("Aution")
        ],
      )
    ));
  }
}
