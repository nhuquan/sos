import 'package:flutter/material.dart';

import '../doctor_list_screen.dart';
import '../doctor_map_screen.dart';
import '../settings_screen.dart';

class HomeWeb extends StatelessWidget {
  const HomeWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text("SOS App", style: TextStyle(color: Colors.white)),
        ),
        actions: [
          TextButton(
            onPressed: () => navigate(context, const DoctorMapScreen()),
            child: const Text(
              "Doctor Map",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => navigate(context, const DoctorListScreen()),
            child: const Text(
              "List Doctor",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => navigate(context, const SettingsScreen()),
            child: const Text(
              "Settings",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: const Center(child: Text("Trang Home (Web)")),
    );
  }

  void navigate(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}
