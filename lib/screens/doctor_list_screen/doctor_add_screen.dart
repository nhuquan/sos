import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../services/doctor_service.dart';
import 'package:sos_server_client/src/protocol/doctor.dart';

class DoctorAddScreen extends StatefulWidget {
  const DoctorAddScreen({super.key});

  @override
  State<DoctorAddScreen> createState() => _DoctorAddScreenState();
}

class _DoctorAddScreenState extends State<DoctorAddScreen> {
  LatLng? _selectedLocation;
  final _nameController = TextEditingController();
  final _specialtyController = TextEditingController();
  final DoctorService _doctorService = DoctorService();

  Future<void> _saveDoctor() async {
    if (_selectedLocation == null ||
        _nameController.text.isEmpty ||
        _specialtyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đủ thông tin')),
      );
      return;
    }

    final doctor = Doctor(
      name: _nameController.text,
      specialty: _specialtyController.text,
      latitude: _selectedLocation!.latitude,
      longitude: _selectedLocation!.longitude,
    );

    await _doctorService.addDoctor(doctor);
    Navigator.pop(context, true); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm bác sĩ')),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(20.577480, 105.869538), 
                initialZoom: 13,
                onTap: (tapPos, latlng) {
                  setState(() {
                    _selectedLocation = latlng;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.sos',
                ),
                if (_selectedLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 40,
                        height: 40,
                        point: _selectedLocation!,
                        child: const Icon(Icons.location_on, color: Colors.red),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Tên bác sĩ'),
                ),
                TextField(
                  controller: _specialtyController,
                  decoration: const InputDecoration(labelText: 'Chuyên ngành'),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _saveDoctor,
                  icon: const Icon(Icons.save),
                  label: const Text('Lưu'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
