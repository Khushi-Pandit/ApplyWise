import 'package:flutter/material.dart';
import 'package:caproj/Googlelist.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Internship 1 Card
            Card(
              elevation: 6,
              margin: EdgeInsets.only(bottom: screenSize.height * 0.03),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.business_center,
                    size: 40,
                    color: Color(0xFF3B82F6),
                  ),
                ),
                title: Text(
                  'Software Developer Intern',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenSize.width * 0.045,
                  ),
                ),
                subtitle: Text(
                  'Googlieee',
                  style: TextStyle(
                    fontSize: screenSize.width * 0.04,
                    color: Colors.grey.shade600,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GooglieList(),));
                },
              ),
            ),

            // Internship 2 Card
            Card(
              elevation: 6,
              margin: EdgeInsets.only(bottom: screenSize.height * 0.03),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.design_services,
                    size: 40,
                    color: Color(0xFF10B981),
                  ),
                ),
                title: Text(
                  'DevOps Engineer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenSize.width * 0.045,
                  ),
                ),
                subtitle: Text(
                  'Persist Venture',
                  style: TextStyle(
                    fontSize: screenSize.width * 0.04,
                    color: Colors.grey.shade600,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                  // Navigate to internship details
                },
              ),
            ),
            // Add more internship listings as needed
          ],
        ),
      ),
    );
  }
}
