import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../services/doctor_service.dart';
import 'package:sos_server_client/sos_server_client.dart';
import 'package:sos_server_client/src/protocol/doctor.dart'; // Add this import if Doctor is defined here

class DoctorMapScreen extends StatefulWidget {
  const DoctorMapScreen({super.key});

  @override
  State<DoctorMapScreen> createState() => _DoctorMapScreenState();
}

class _DoctorMapScreenState extends State<DoctorMapScreen> {
  final DoctorService _doctorService = DoctorService();

  LatLng? userLocation;
  Doctor? selectedDoctor;
  List<Doctor> doctors = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadDoctors();
  }

  Future<void> _getCurrentLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> _loadDoctors() async {
    final result = await _doctorService.getDoctors();
    setState(() {
      doctors = result;
    });
  }

  // Future<void> _addDoctorAtLocation(LatLng position) async {
  //   final newDoctor = Doctor(
  //     id: null, 
  //     name: "Bác sĩ mới",
  //     specialty: "Chưa rõ",
  //     latitude: position.latitude,
  //     longitude: position.longitude,
  //   );

  //   final created = await _doctorService.addDoctor(newDoctor);
  //   setState(() {
  //     doctors.add(created);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (userLocation == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Tìm bác sĩ')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: userLocation!,
          initialZoom: 15,
          // onTap: (tapPosition, latlng) async {
          //   await _addDoctorAtLocation(latlng);
          // },
        ),
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
                point: LatLng(doctor.latitude, doctor.longitude),
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
