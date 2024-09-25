import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sikshya/core/shared_prefences/locator.dart';
import 'package:sikshya/core/shared_prefences/shared_prefences_service.dart';
import 'package:sikshya/features/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    whereToGo(); // Determine where to navigate next
  }

  @override
  void dispose() {
    super.dispose();
  }

  // This function decides where to navigate after splash screen
  void whereToGo() async {
    String? token = locator.get<SharedPreferencesService>().token;

    Timer(const Duration(seconds: 5), () {
      // If token exists, route to another page (like dashboard), else to login
      if (token == null) {
        // Navigate to dashboard or home screen (not shown here)
        context.go('/dashboard');
      } else {
        context.goNamed(LoginScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 10,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.network(
                    'https://eshikshya.com.np/uploads/logo/logo.png', // Path to your logo asset
                    width: 300,
                    height: 300,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Powered by ',
                    style: GoogleFonts.montserrat(
                      fontSize: MediaQuery.of(context).size.width / 30,
                    ),
                    children: const [
                      TextSpan(
                        text: 'Krishi Kanti',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                    height: 20), // Added some space before the footer
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '2023',
                      style: TextStyle(),
                    ),
                    Icon(
                      Icons.copyright,
                      size: 15,
                    ),
                    Text(
                      ' Company Name. All Rights Reserved',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
