import 'package:latlong2/latlong.dart';

import '../models/doctor.dart';

final List<Doctor> doctors = [
  Doctor(
    id: '1',
    name: 'Dr. Trương Thị Thanh',
    specialty: 'Ostetrics', // Sản
    location: LatLng(20.586353, 105.863989),
  ),
  Doctor(
    id: '2',
    name: 'Dr. Trịnh Quốc Lực',
    specialty: 'Traditional Vietnamese Medicine',
    location: LatLng(20.578294, 105.870417),
  ),
  Doctor(
    id: '3',
    name: 'Dr. Vũ Duy Phong',
    specialty: 'Dermatology', // da liễu
    location: LatLng(20.571361, 105.885989),
  ),
  Doctor(
    id: '4',
    name: 'Dr. Nguyễn Văn Hùng',
    specialty: 'Pediatrics', // Nhi
    location: LatLng(20.553778, 105.929821),
  ),
];