import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sos/features/auth/data/firebase_auth_repo.dart';
import 'package:sos/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:sos/firebase_options.dart';
import 'package:sos/screens/home/home_screen.dart';
import 'package:sos/themes/dark_mode.dart';
import 'package:sos/themes/light_mode.dart';

void main() async {
  // firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // auth repo
  final firebaseAuthRepo = FirebaseAuthRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // provide cubits to app
      providers: [
        // Auth cubit
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepo: firebaseAuthRepo)..checkAuth(),
        ),
      ],
      child: MaterialApp(
        title: 'SOS Doctor Map',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(primarySwatch: Colors.teal),
        home: HomeScreen(),
        theme: lightModeTheme,
        darkTheme: darkModeTheme,
      ),
    );
  }
}
