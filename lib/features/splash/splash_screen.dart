import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapio_assignment/features/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController);

    animationController.forward();

    Timer(
      const Duration(seconds: 3),
          () {
        Get.off(() => const LoginScreen());
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.blue,

      body: Center(

        child: FadeTransition(

          opacity: fadeAnimation,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Container(
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),

                child: const Icon(
                  Icons.business_center,
                  size: 70,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "Sapio Assignment",

                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Field Force Management System",

                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 40),

              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}