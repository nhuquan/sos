import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sos/screens/doctor_list_screen.dart';
import 'package:sos/screens/doctor_map_screen.dart';
import 'package:sos/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigate(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
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
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => navigate(context, const DoctorMapScreen()),
                icon: const Icon(LineIcons.map),
                label: const Text('Doctor Map'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  backgroundColor: const Color(0xFF6DD5FA),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 6,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => navigate(context, const DoctorListScreen()),
                icon: const Icon(LineIcons.list),
                label: const Text('List Doctor'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  backgroundColor: const Color(0xFF6DD5FA),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 6,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => navigate(context, const SettingsScreen()),
                icon: const Icon(Icons.settings),
                label: const Text('Settings'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  backgroundColor: const Color(0xFF6DD5FA),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 6,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
