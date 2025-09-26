import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:sos_server_client/sos_server_client.dart';

final client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();