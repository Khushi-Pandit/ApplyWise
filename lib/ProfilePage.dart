import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Text controllers to handle the updated values
  final TextEditingController _nameController = TextEditingController(text: 'Khushi Pandit');
  final TextEditingController _placeController = TextEditingController(text: 'Raichur, India');
  final TextEditingController _professionController = TextEditingController(text: 'Software Development');
  final TextEditingController _degreeController = TextEditingController(text: 'B.Tech in Computer Science');
  final TextEditingController _degreeTypeController = TextEditingController(text: 'Undergraduate');
  final TextEditingController _hobbiesController = TextEditingController(text: 'Coding, Reading, Travelling');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Add functionality to update profile picture
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blueGrey.shade100,
                        backgroundImage: const NetworkImage('https://example.com/your-profile-image.png'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Khushi Pandit',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 10, 70, 120),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Software Developer Intern',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ProfileCard(
                title: 'Name',
                description: _nameController.text,
                icon: Icons.person,
                onEditPressed: () => _editField(context, 'Name', _nameController),
              ),
              ProfileCard(
                title: 'Location',
                description: _placeController.text,
                icon: Icons.location_on,
                onEditPressed: () => _editField(context, 'Location', _placeController),
              ),
              ProfileCard(
                title: 'Profession',
                description: _professionController.text,
                icon: Icons.work,
                onEditPressed: () => _editField(context, 'Profession', _professionController),
              ),
              ProfileCard(
                title: 'Degree',
                description: _degreeController.text,
                icon: Icons.school,
                onEditPressed: () => _editField(context, 'Degree', _degreeController),
              ),
              ProfileCard(
                title: 'Degree Type',
                description: _degreeTypeController.text,
                icon: Icons.book,
                onEditPressed: () => _editField(context, 'Degree Type', _degreeTypeController),
              ),
              ProfileCard(
                title: 'Hobbies',
                description: _hobbiesController.text,
                icon: Icons.favorite,
                onEditPressed: () => _editField(context, 'Hobbies', _hobbiesController),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle editing of fields
  void _editField(BuildContext context, String field, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Enter new $field'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  // Trigger rebuild with updated value
                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onEditPressed;

  const ProfileCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color.fromARGB(255, 10, 70, 120), size: 30),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.blueGrey),
          onPressed: onEditPressed,
        ),
      ),
    );
  }
}
