import 'package:flutter/material.dart';
import 'package:logmax/core/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/sign_up_screen.dart';
import 'bottombar.dart';
import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final userType = prefs.getString('userType');

    // Wait for 3 seconds before checking login status to simulate splash screen duration
    await Future.delayed(const Duration(seconds: 3));

    if (userId != null && userType != null) {
      // User is logged in, navigate to BottomBar
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomBar(tabIndex: 0)),
      );
    } else {
      // User is not logged in, navigate to LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/images/Logmax-PNG.png'), height: 145, width: 255),
              SizedBox(height: 40),
              CircularProgressIndicator(
                color: appColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
