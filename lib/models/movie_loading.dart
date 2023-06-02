import 'package:flutter/material.dart';

class MovieLoadingScreen extends StatelessWidget {
  const MovieLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Replace with your loading animation widget
      ),
    );
  }
}