import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GooglieList extends StatefulWidget {
  const GooglieList({super.key});

  @override
  State<GooglieList> createState() => _GooglieListState();
}

class _GooglieListState extends State<GooglieList> {
  // final String applyUrl = "https://www.youtube.com/"; // Replace with your target URL

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internship Notifications'),
      ),
      body: ListView.builder(
        itemCount: internships.length,
        itemBuilder: (context, index) {
          final internship = internships[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    internship['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Location: ${internship['location']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Qualification: ${internship['qualification']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {;
                      _launchURL;
                      },
                      child: const Text('Apply'),
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
  void _launchURL() async {
    print("object");
    final Uri url = Uri.parse('https://flutter.dev'); // Replace with your URL
    if (await canLaunchUrl(url)) { // Check if the URL can be launched
      print("Hello");
      await launchUrl(url); // Launch the URL
    } else {
      throw 'Could not launch $url'; // Handle the error
    }
  }
}
