import 'package:flutter/material.dart';
import 'package:sos/screens/home/home_mobile.dart';
import 'package:sos/screens/home/home_web.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return screenWidth < 600 ? HomeMobile() : HomeWeb();
  }
}
