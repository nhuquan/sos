/*  

LOGIN PAGE UI

On this page, a user can login with there:
- email
- password

------------------

Once successfully logged in, the user is navigated to the HomePage

If user does not have an account, they can navigate to the RegisterPage to create one

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sos/features/auth/presentation/components/my_button.dart';
import 'package:sos/features/auth/presentation/components/my_textfield.dart';
import 'package:sos/features/auth/presentation/cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;

  const LoginPage({super.key, required this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // auth cubit
  late final authCubit = context.read<AuthCubit>();

  // login button pressed
  void login() {
    // prepare email & password
    final String email = emailController.text.trim();
    final String password = passwordController.text;

    // ensure fields are not empty
    if (email.isNotEmpty && password.isNotEmpty) {
      // trigger login
      authCubit.login(email, password);
    } else {
      // show error - fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all fields!")),
      );
    }
  }

  // forgot password box
  void openForgotPassword() {
    // open forgot password dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Forgot Password?"),
          content: MyTextfield(
            controller: emailController,
            hintText: "Enter email..",
            obscureText: false,
          ),
          actions: [
            // cancel button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),

            // reset button
            TextButton(
              onPressed: () async {
                String message = await authCubit.forgotPassword(emailController.text.trim());
                if(message == "Password reset email! Check your inbox.") {
                  Navigator.pop(context);
                  emailController.clear();
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              },
              child: const Text("Reset"),
            ),
          ],
        );
      },
    );
  }

  // build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.lock_open,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 20),

              // name of app
              Text(
                "Build, Launch & Monetize",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 25),

              // email text field
              MyTextfield(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              const SizedBox(height: 10),

              // password text field
              MyTextfield(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 10),

              // forgot password?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => openForgotPassword(),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // login button
              MyButton(onTap: login, text: "LOGIN"),
              const SizedBox(height: 25),

              // oath sign in later.. (google & apple)

              // don't have an account? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      // go to register page
                      Navigator.pushNamed(context, '/register');
                    },
                    child: GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        "Register now",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
