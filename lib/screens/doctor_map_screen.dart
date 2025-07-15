import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../data/mock_doctors.dart';
import '../models/doctor.dart';

class DoctorMapScreen extends StatefulWidget {
  const DoctorMapScreen({super.key});

  @override
  State<DoctorMapScreen> createState() => _DoctorMapScreenState();
}

class _DoctorMapScreenState extends State<DoctorMapScreen> {
  LatLng? userLocation;
  Doctor? selectedDoctor;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userLocation == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Tìm bác sĩ')),
      body: FlutterMap(
        options: MapOptions(initialCenter: userLocation!, initialZoom: 15),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.sosDoctorMap',
          ),

          // Vị trí người dùng
          MarkerLayer(
            markers: [
              Marker(
                width: 40,
                height: 40,
                point: userLocation!,
                child: const Icon(
                  Icons.my_location,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ],
          ),

          // Marker bác sĩ
          MarkerLayer(
            markers: doctors.map((doctor) {
              final isSelected = selectedDoctor?.id == doctor.id;
              return Marker(
                width: 50,
                height: 50,
                point: doctor.location,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDoctor = doctor;
                    });
                  },
                  child: Icon(
                    Icons.location_on_outlined,
                    color: isSelected ? Colors.orange : Colors.red,
                    size: isSelected ? 50 : 30,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),

      // Hiển thị thông tin khi chọn bác sĩ
      bottomSheet: selectedDoctor != null
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedDoctor!.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Chuyên khoa: ${selectedDoctor!.specialty}'),
                ],
              ),
            )
          : null,
    );
  }
}
