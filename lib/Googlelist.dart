import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GooglieList extends StatefulWidget {
  const GooglieList({super.key});

  @override
  State<GooglieList> createState() => _GooglieListState();
}

class _GooglieListState extends State<GooglieList> {
  final List<Map<String, String>> internships = [
    {
      'title': 'Software Engineer Intern',
      'location': 'San Francisco, CA',
      'qualification': 'Pursuing B.Tech in Computer Science',
    },
    {
      'title': 'Data Analyst Intern',
      'location': 'New York, NY',
      'qualification': 'Experience with SQL and Excel',
    },
    {
      'title': 'Product Manager Intern',
      'location': 'Remote',
      'qualification': 'Strong communication and leadership skills',
    },
    {
      'title': 'UI/UX Design Intern',
      'location': 'Remote',
      'qualification': 'Knowledge of Figma and Adobe XD',
    },
  ];

  Future<void> _launchURL(String applyUrl) async {
    final Uri url = Uri.parse(applyUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $applyUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internships',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Color.fromARGB(255, 10, 70, 120),
      ),
      body: ListView.builder(
        itemCount: internships.length,
        itemBuilder: (context, index) {
          final internship = internships[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.work,
                        color: Color.fromARGB(255, 10, 70, 120),
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          internship['title'] ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        internship['location'] ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.school,
                        color: Colors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          internship['qualification'] ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _launchURL('https://flutter.dev'); // Placeholder URL
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 10, 70, 120),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward, size: 20,color: Colors.white,),
                      label: const Text('Apply',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
