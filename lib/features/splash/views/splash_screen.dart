import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';
import 'package:clientone_ess/shared/constants/png_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(
          Sessions.isLoggedIn() ? RoutesName.dashboard : RoutesName.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            PngImages.splash,
            height: size.height,
            width: size.width,
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  PngImages.logo, // update if needed
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Employee Management",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.3),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "v1.0.0",
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
                Text(
                  "Developed By",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  "www.appdevix.solution",
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
