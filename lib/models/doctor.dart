import 'package:latlong2/latlong.dart';

class Doctor {
  final String id;
  final String name;
  final String specialty;
  final LatLng location;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.location,
  });
}
