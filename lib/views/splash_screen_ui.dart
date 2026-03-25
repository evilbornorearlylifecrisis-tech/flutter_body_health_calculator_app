import 'package:flutter/material.dart';
import 'home_ui.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  @override
  void initState() {
    // หน่วงเวลาหน่วงฉาย 3 วิ แล้วเปิดไปหน้า HomeUi แบบย้อนกลับไม่ได้
    Future.delayed(
      // เวลาที่จะหน่วง
      const Duration(seconds: 3),
      // พอครบเวลาที่หน่วงแล้ว จะให้ทำอะไร
      () {
        // เปิดไปหน้า HomeUi แบบย้อนกลับไม่ได้
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeUi(),
            ),
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/bmi.png',
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'Body Health Calculator',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '© 2026 All rights reserved.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const Text(
              'Created by: Namo SAU',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
