import 'package:flutter/material.dart';
import 'package:mytenera/components/navigation.dart';
import 'package:mytenera/screen/aution_page/aution_page.dart';
import 'package:mytenera/screen/home_page/home_page.dart';
import 'package:mytenera/screen/login_page/login_page.dart';
import 'package:mytenera/screen/profile_page/profile_page.dart';

final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => const HomePage(),
  LoginPage.routeName: (context) => const LoginPage(),
  Navigation.routeName: (context) => const Navigation(),
  ProfilePage.routeName: (context) => ProfilePage(),
  AutoionPage.routeName: (context) => const AutoionPage(),
};
