import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'get_started_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _show() async {
    await Future.delayed(const Duration(seconds: 3));
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GetStartedScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _show();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1A1A),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/svg/backdrop.svg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SvgPicture.asset('assets/svg/logo.svg'),
          ),
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: SpinKitRing(
              color: Colors.white,
              size: 50.0,
            ),
          ),
        ]),
      ),
    );
  }
}
