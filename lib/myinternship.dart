import 'package:flutter/material.dart';

class MyInternshipsScreen extends StatelessWidget {
  const MyInternshipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Haven't applied for any internships yet!!",
        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
      ),
    );
  }
}