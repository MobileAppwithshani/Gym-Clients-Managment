import 'package:flutter/material.dart';
import 'package:local_db/Screens/home_screen.dart'; // Import your HomeScreen

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay duration (2 seconds in this example)
    const delayDuration = Duration(seconds: 2);

    // Navigates to HomeScreen after the delay
    void navigateToHome() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    }

    // Initiates navigation after delay
    Future<void> initiateNavigation() async {
      await Future.delayed(delayDuration);
      navigateToHome();
    }

    // Start navigation
    initiateNavigation();

    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.9,
          height: MediaQuery.of(context).size.height*0.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/app.png'), // Your image asset path
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: CircularProgressIndicator(), // Loading indicator
          ),
        ),
      ),
    );
  }
}
