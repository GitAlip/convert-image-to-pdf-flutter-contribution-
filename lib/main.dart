import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_to_pdf/core/theme/app_theme.dart';
import 'package:image_to_pdf/features/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image to PDF',
      theme: AppTheme.lightTheme,
      home: AnimatedSplashScreen(
        duration: 2500,
        splash: 'lib/assets/splashPDF.png', // Ensure this asset exists
        nextScreen: const HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
        splashIconSize: 200, // Adjust based on image size
      ),
    );
  }
}
