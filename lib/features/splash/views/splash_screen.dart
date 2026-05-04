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

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
    _animate();
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(
          Sessions.isLoggedIn() ? RoutesName.dashboard : RoutesName.login);
    });
  }

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  void _animate() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.1), // slight bottom to center
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                PngImages.splash,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
