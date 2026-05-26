import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapio_assignment/features/auth/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  final AuthController authController =
  Get.put(AuthController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      body: Center(
        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Container(

            padding: const EdgeInsets.all(24),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(24),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [

                const CircleAvatar(
                  radius: 42,

                  child: Icon(
                    Icons.business_center,
                    size: 42,
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Welcome Back",

                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Login to continue",

                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 36),

                TextField(
                  controller: emailController,

                  decoration: InputDecoration(
                    labelText: "Email",

                    prefixIcon: const Icon(
                      Icons.email_outlined,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: passwordController,
                  obscureText: true,

                  decoration: InputDecoration(
                    labelText: "Password",

                    prefixIcon: const Icon(
                      Icons.lock_outline,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 56,

                  child: Obx(() => ElevatedButton(

                    style: ElevatedButton.styleFrom(

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    onPressed: authController.isLoading.value
                        ? null
                        : () {

                      authController.login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    },

                    child: authController.isLoading.value
                        ? const SizedBox(
                      height: 22,
                      width: 22,

                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Text(
                      "Login",

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
                ),

                const SizedBox(height: 28),

                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      const Text(
                        "Demo Accounts",

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 12),

                      ...authController.demoUsers.entries.map((entry) {

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),

                          child: Row(
                            children: [

                              const Icon(
                                Icons.person_outline,
                                size: 18,
                              ),

                              const SizedBox(width: 8),

                              Expanded(
                                child: Text(
                                  "${entry.key} (${entry.value["role"]})",
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}