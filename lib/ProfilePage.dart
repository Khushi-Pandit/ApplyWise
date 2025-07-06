import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Sample data - in real app, this would come from your backend
  Map<String, dynamic> profileData = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'phone': '+91 9876543210',
    'location': 'Mumbai, India',
    'bio': 'Passionate software developer with experience in mobile and web technologies.',
    'university': 'MIT College of Engineering',
    'degree': 'Bachelor of Technology',
    'major': 'Computer Science',
    'graduationYear': '2024',
    'gpa': '8.5',
    'skills': ['Flutter', 'React', 'Node.js', 'Python'],
    'interests': ['Technology', 'Startups', 'AI/ML'],
    'workType': 'Hybrid',
    'duration': '3-6 months',
    'preferredLocations': ['Mumbai', 'Pune', 'Bangalore'],
    'languages': ['English', 'Hindi', 'Marathi'],
    'experiences': [
      {
        'title': 'Software Development Intern',
        'company': 'Tech Solutions Inc.',
        'duration': 'Jun 2023 - Aug 2023',
        'description': 'Developed mobile applications using Flutter framework.'
      }
    ],
    'projects': [
      {
        'title': 'E-commerce Mobile App',
        'tech': 'Flutter, Firebase, Node.js',
        'description': 'Built a full-stack e-commerce application with real-time features.',
        'url': 'https://github.com/johndoe/ecommerce-app'
      }
    ],
    'availableFrom': DateTime.now().add(const Duration(days: 30)),
    'isAvailableFullTime': true,
    'linkedin': 'linkedin.com/in/johndoe',
    'github': 'github.com/johndoe',
    'portfolio': 'johndoe.dev',
    'resume': 'drive.google.com/resume-link'
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      _buildProfileHeader(),
                      const SizedBox(height: 20),
                      _buildPersonalInfoCard(),
                      const SizedBox(height: 16),
                      _buildEducationCard(),
                      const SizedBox(height: 16),
                      _buildSkillsCard(),
                      const SizedBox(height: 16),
                      _buildExperienceCard(),
                      const SizedBox(height: 16),
                      _buildProjectsCard(),
                      const SizedBox(height: 16),
                      _buildPreferencesCard(),
                      const SizedBox(height: 16),
                      _buildAvailabilityCard(),
                      const SizedBox(height: 16),
                      _buildLinksCard(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Hero(
            tag: 'profile-avatar',
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.person,
                size: 40,
                color: Color(0xFF667EEA),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileData['name'] ?? 'Your Name',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profileData['email'] ?? 'your.email@example.com',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Profile Complete: 85%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoCard() {
    return _buildEditableCard(
      title: 'Personal Information',
      icon: Icons.person_outline,
      iconColor: const Color(0xFF4F46E5),
      children: [
        _buildInfoRow('Full Name', profileData['name'] ?? 'Not provided'),
        _buildInfoRow('Email', profileData['email'] ?? 'Not provided'),
        _buildInfoRow('Phone', profileData['phone'] ?? 'Not provided'),
        _buildInfoRow('Location', profileData['location'] ?? 'Not provided'),
        _buildInfoRow('Bio', profileData['bio'] ?? 'Not provided', isLarge: true),
      ],
      onEdit: () => _editPersonalInfo(),
    );
  }

  Widget _buildEducationCard() {
    return _buildEditableCard(
      title: 'Education',
      icon: Icons.school_outlined,
      iconColor: const Color(0xFF059669),
      children: [
        _buildInfoRow('University', profileData['university'] ?? 'Not provided'),
        _buildInfoRow('Degree', profileData['degree'] ?? 'Not provided'),
        _buildInfoRow('Major', profileData['major'] ?? 'Not provided'),
        _buildInfoRow('Graduation Year', profileData['graduationYear'] ?? 'Not provided'),
        _buildInfoRow('GPA', profileData['gpa'] ?? 'Not provided'),
      ],
      onEdit: () => _editEducation(),
    );
  }

  Widget _buildSkillsCard() {
    return _buildEditableCard(
      title: 'Skills & Interests',
      icon: Icons.psychology_outlined,
      iconColor: const Color(0xFFDC2626),
      children: [
        _buildChipSection('Technical Skills', profileData['skills'] ?? []),
        const SizedBox(height: 16),
        _buildChipSection('Industry Interests', profileData['interests'] ?? []),
        const SizedBox(height: 16),
        _buildChipSection('Languages', profileData['languages'] ?? []),
      ],
      onEdit: () => _editSkills(),
    );
  }

  Widget _buildExperienceCard() {
    List<dynamic> experiences = profileData['experiences'] ?? [];
    return _buildEditableCard(
      title: 'Work Experience',
      icon: Icons.work_outline,
      iconColor: const Color(0xFF7C3AED),
      children: experiences.isEmpty
          ? [
        _buildEmptyState('No work experience added yet', Icons.work_outline),
      ]
          : experiences.map((exp) => _buildExperienceItem(exp)).toList(),
      onEdit: () => _editExperience(),
    );
  }

  Widget _buildProjectsCard() {
    List<dynamic> projects = profileData['projects'] ?? [];
    return _buildEditableCard(
      title: 'Projects',
      icon: Icons.code_outlined,
      iconColor: const Color(0xFFEA580C),
      children: projects.isEmpty
          ? [
        _buildEmptyState('No projects added yet', Icons.code_outlined),
      ]
          : projects.map((project) => _buildProjectItem(project)).toList(),
      onEdit: () => _editProjects(),
    );
  }

  Widget _buildPreferencesCard() {
    return _buildEditableCard(
      title: 'Internship Preferences',
      icon: Icons.tune_outlined,
      iconColor: const Color(0xFF0891B2),
      children: [
        _buildInfoRow('Work Type', profileData['workType'] ?? 'Not specified'),
        _buildInfoRow('Duration', profileData['duration'] ?? 'Not specified'),
        _buildChipSection('Preferred Locations', profileData['preferredLocations'] ?? []),
      ],
      onEdit: () => _editPreferences(),
    );
  }

  Widget _buildAvailabilityCard() {
    return _buildEditableCard(
      title: 'Availability',
      icon: Icons.schedule_outlined,
      iconColor: const Color(0xFF16A34A),
      children: [
        _buildInfoRow(
          'Available From',
          profileData['availableFrom'] != null
              ? '${profileData['availableFrom'].day}/${profileData['availableFrom'].month}/${profileData['availableFrom'].year}'
              : 'Not specified',
        ),
        _buildInfoRow(
          'Full-time Ready',
          profileData['isAvailableFullTime'] == true ? 'Yes' : 'No',
        ),
      ],
      onEdit: () => _editAvailability(),
    );
  }

  Widget _buildLinksCard() {
    return _buildEditableCard(
      title: 'Professional Links',
      icon: Icons.link_outlined,
      iconColor: const Color(0xFF7C2D12),
      children: [
        _buildLinkRow('LinkedIn', profileData['linkedin'], Icons.business_center),
        _buildLinkRow('GitHub', profileData['github'], Icons.code),
        _buildLinkRow('Portfolio', profileData['portfolio'], Icons.web),
        _buildLinkRow('Resume', profileData['resume'], Icons.description),
      ],
      onEdit: () => _editLinks(),
    );
  }

  Widget _buildEditableCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Widget> children,
    required VoidCallback onEdit,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: onEdit,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.edit,
                        color: iconColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isLarge = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: isLarge ? 1.4 : 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipSection(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        items.isEmpty
            ? Text(
          'None added',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
            fontStyle: FontStyle.italic,
          ),
        )
            : Wrap(
          spacing: 8,
          runSpacing: 6,
          children: items.map((item) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Text(
              item.toString(),
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildExperienceItem(Map<String, dynamic> exp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exp['title'] ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            exp['company'] ?? '',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            exp['duration'] ?? '',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          if (exp['description'] != null && exp['description'].isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              exp['description'],
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                height: 1.3,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProjectItem(Map<String, dynamic> project) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  project['title'] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (project['url'] != null && project['url'].isNotEmpty)
                Icon(Icons.launch, size: 16, color: Colors.blue[600]),
            ],
          ),
          if (project['tech'] != null && project['tech'].isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              project['tech'],
              style: TextStyle(
                fontSize: 12,
                color: Colors.orange[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          if (project['description'] != null && project['description'].isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              project['description'],
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                height: 1.3,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLinkRow(String label, String? url, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: url != null && url.isNotEmpty
                ? Text(
              url,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue[600],
                decoration: TextDecoration.underline,
              ),
            )
                : Text(
              'Not provided',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  // Edit methods (you would implement these with proper forms/dialogs)
  void _editPersonalInfo() {
    final nameController = TextEditingController(text: profileData['name']);
    final emailController = TextEditingController(text: profileData['email']);
    final phoneController = TextEditingController(text: profileData['phone']);
    final locationController = TextEditingController(text: profileData['location']);
    final bioController = TextEditingController(text: profileData['bio']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Personal Info'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('Full Name', nameController),
                _buildTextField('Email', emailController),
                _buildTextField('Phone', phoneController),
                _buildTextField('Location', locationController),
                _buildTextField('Bio', bioController, maxLines: 3),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  profileData['name'] = nameController.text;
                  profileData['email'] = emailController.text;
                  profileData['phone'] = phoneController.text;
                  profileData['location'] = locationController.text;
                  profileData['bio'] = bioController.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Personal Information updated')),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  void _editEducation() {
    final universityController = TextEditingController(text: profileData['university']);
    final degreeController = TextEditingController(text: profileData['degree']);
    final majorController = TextEditingController(text: profileData['major']);
    final graduationYearController = TextEditingController(text: profileData['graduationYear']);
    final gpaController = TextEditingController(text: profileData['gpa']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Education'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('University', universityController),
                _buildTextField('Degree', degreeController),
                _buildTextField('Major', majorController),
                _buildTextField('Graduation Year', graduationYearController),
                _buildTextField('GPA', gpaController),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  profileData['university'] = universityController.text;
                  profileData['degree'] = degreeController.text;
                  profileData['major'] = majorController.text;
                  profileData['graduationYear'] = graduationYearController.text;
                  profileData['gpa'] = gpaController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editSkills() {
    final skillsController = TextEditingController(text: (profileData['skills'] as List).join(', '));
    final interestsController = TextEditingController(text: (profileData['interests'] as List).join(', '));
    final languagesController = TextEditingController(text: (profileData['languages'] as List).join(', '));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Skills & Interests'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Skills (comma-separated)', skillsController),
                _buildTextField('Interests (comma-separated)', interestsController),
                _buildTextField('Languages (comma-separated)', languagesController),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  profileData['skills'] = skillsController.text.split(',').map((e) => e.trim()).toList();
                  profileData['interests'] = interestsController.text.split(',').map((e) => e.trim()).toList();
                  profileData['languages'] = languagesController.text.split(',').map((e) => e.trim()).toList();
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editExperience() {
    final titleController = TextEditingController(text: profileData['experiences']?[0]?['title']);
    final companyController = TextEditingController(text: profileData['experiences']?[0]?['company']);
    final durationController = TextEditingController(text: profileData['experiences']?[0]?['duration']);
    final descController = TextEditingController(text: profileData['experiences']?[0]?['description']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Experience'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Title', titleController),
                _buildTextField('Company', companyController),
                _buildTextField('Duration', durationController),
                _buildTextField('Description', descController, maxLines: 3),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  profileData['experiences'] = [
                    {
                      'title': titleController.text,
                      'company': companyController.text,
                      'duration': durationController.text,
                      'description': descController.text,
                    }
                  ];
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editProjects() {
    final titleController = TextEditingController(text: profileData['projects']?[0]?['title'] ?? '');
    final techController = TextEditingController(text: profileData['projects']?[0]?['tech'] ?? '');
    final descController = TextEditingController(text: profileData['projects']?[0]?['description'] ?? '');
    final urlController = TextEditingController(text: profileData['projects']?[0]?['url'] ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Project'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Project Title', titleController),
                _buildTextField('Technologies Used', techController),
                _buildTextField('Description', descController, maxLines: 3),
                _buildTextField('Project URL', urlController),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  profileData['projects'] = [
                    {
                      'title': titleController.text,
                      'tech': techController.text,
                      'description': descController.text,
                      'url': urlController.text,
                    }
                  ];
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Project updated')),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editPreferences() {
    final workTypeController = TextEditingController(text: profileData['workType']);
    final durationController = TextEditingController(text: profileData['duration']);
    final locationsController = TextEditingController(text: (profileData['preferredLocations'] as List).join(', '));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Preferences'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Work Type (e.g., Remote/Hybrid)', workTypeController),
                _buildTextField('Duration', durationController),
                _buildTextField('Preferred Locations (comma-separated)', locationsController),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  profileData['workType'] = workTypeController.text;
                  profileData['duration'] = durationController.text;
                  profileData['preferredLocations'] =
                      locationsController.text.split(',').map((e) => e.trim()).toList();
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editAvailability() {
    DateTime selectedDate = profileData['availableFrom'] ?? DateTime.now();
    bool isFullTime = profileData['isAvailableFullTime'] ?? false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Availability'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text("Available From: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setDialogState(() => selectedDate = picked);
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Full-time Available"),
                      Switch(
                        value: isFullTime,
                        onChanged: (val) => setDialogState(() => isFullTime = val),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      profileData['availableFrom'] = selectedDate;
                      profileData['isAvailableFullTime'] = isFullTime;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _editLinks() {
    final linkedInController = TextEditingController(text: profileData['linkedin']);
    final githubController = TextEditingController(text: profileData['github']);
    final portfolioController = TextEditingController(text: profileData['portfolio']);
    final resumeController = TextEditingController(text: profileData['resume']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Links'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('LinkedIn URL', linkedInController),
                _buildTextField('GitHub URL', githubController),
                _buildTextField('Portfolio URL', portfolioController),
                _buildTextField('Resume Link', resumeController),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  profileData['linkedin'] = linkedInController.text;
                  profileData['github'] = githubController.text;
                  profileData['portfolio'] = portfolioController.text;
                  profileData['resume'] = resumeController.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Links updated')),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$title updated successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}