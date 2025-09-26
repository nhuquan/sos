
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../doctor_list_screen/doctor_list_screen.dart';
import '../doctor_map_screen.dart';
import '../settings_screen.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  void navigate(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Center(child: Text("Chọn một chức năng")),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: GNav(
          gap: 8,
          iconSize: 24,
          tabBorderRadius: 30,
          haptic: true,
          duration: const Duration(milliseconds: 400),
          rippleColor: Colors.grey.shade300,
          hoverColor: Colors.grey.shade100,
          tabBackgroundGradient: const LinearGradient(
            colors: [Color(0xFF6DD5FA), Color(0xFF2980B9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          activeColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          tabs: [
            GButton(
              icon: LineIcons.map,
              text: 'Doctor Map',
              onPressed: () => navigate(context, const DoctorMapScreen()),
            ),
            GButton(
              icon: LineIcons.list,
              text: 'List Doctor',
              onPressed: () => navigate(context, const DoctorListScreen()),
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
              onPressed: () => navigate(context, const SettingsScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
