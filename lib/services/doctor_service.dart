import 'package:sos_server_client/sos_server_client.dart';
import 'package:sos_server_client/src/protocol/doctor.dart'; // Add this import if Doctor is defined here

class DoctorService {
  late Client client;

  DoctorService() {
    client = Client(
      'http://localhost:8080/', // Replace with your server URL
    );
  }

  Future<List<Doctor>> getDoctors() => client.doctor.getAllDoctors();

  Future<Doctor> addDoctor(Doctor doctor) => client.doctor.addDoctor(doctor);

  Future<Doctor> updateDoctor(Doctor doctor) =>
      client.doctor.updateDoctor(doctor);

  Future<void> deleteDoctor(int id) => client.doctor.deleteDoctor(id);
}
