import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sos/features/auth/presentation/components/loading.dart';
import 'package:sos/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:sos/features/auth/presentation/cubits/auth_states.dart';
import 'package:sos/features/auth/presentation/pages/auth_page.dart';
import '../doctor_list_screen/doctor_list_screen.dart';
import '../doctor_map_screen.dart';
import '../settings_screen.dart';

class HomeWeb extends StatelessWidget {
  const HomeWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Container(
              color: Colors.green[700],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.phone, color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Text(
                        "Hotline đặt khám: 1900 3367",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),

                  // Row(
                  //   children: [
                  //     TextButton(
                  //       onPressed: () => navigate(context, const AuthPage()),
                  //       child: const Text("Đăng ký / Đăng nhập", style: TextStyle(color: Colors.white)),
                  //     ),

                  //   ],
                  // )
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthAuthenticated) {
                        return Row(
                          children: [
                            Text(
                              "Xin chào, ${state.user.email}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 12),
                            TextButton(
                              onPressed: () {
                                context.read<AuthCubit>().logout();
                              },
                              child: const Text(
                                "Đăng xuất",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      }

                      if (state is AuthUnauthenticated) {
                        return TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AuthPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Đăng ký / Đăng nhập",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      if (state is AuthLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        );
                      }

                      // fallback
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),

            // AppBar
            Material(
              elevation: 2,
              child: Container(
                color: Colors.green[600],
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 56,
                child: Row(
                  children: [
                    const Text(
                      "SOS App",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () =>
                          navigate(context, const DoctorMapScreen()),
                      child: const Text(
                        "Doctor Map",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          navigate(context, const DoctorListScreen()),
                      child: const Text(
                        "List Doctor",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          navigate(context, const SettingsScreen()),
                      child: const Text(
                        "Settings",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content area
            const Expanded(child: Center(child: Text("Trang Home (Web)"))),
          ],
        ),
      ),
    );
  }

  void navigate(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}
