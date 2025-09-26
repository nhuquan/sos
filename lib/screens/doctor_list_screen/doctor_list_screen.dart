import 'package:flutter/material.dart';
import 'package:sos/screens/doctor_list_screen/doctor_add_screen.dart';
import '../../services/doctor_service.dart';
import 'package:sos_server_client/sos_server_client.dart';
import 'package:sos_server_client/src/protocol/doctor.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final DoctorService _doctorService = DoctorService();
  List<Doctor> doctors = [];

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  Future<void> _loadDoctors() async {
    final result = await _doctorService.getDoctors();
    setState(() {
      doctors = result;
    });
  }

  Future<void> _navigateToAddDoctor() async {
    final added = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DoctorAddScreen()),
    );
    if (added == true) {
      _loadDoctors(); // reload List if a doctor was added
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Danh sách bác sĩ")),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(doctor.name),
            subtitle: Text("Chuyên khoa: ${doctor.specialty}"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddDoctor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

