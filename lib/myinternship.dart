import 'package:flutter/material.dart';

class AppliedInternshipsScreen extends StatefulWidget {
  const AppliedInternshipsScreen({Key? key}) : super(key: key);

  @override
  State<AppliedInternshipsScreen> createState() => _AppliedInternshipsScreenState();
}

class _AppliedInternshipsScreenState extends State<AppliedInternshipsScreen> {
  // Sample data for applied internships
  final List<Internship> appliedInternships = [
    Internship(
      id: '1',
      title: 'Flutter Developer Intern',
      company: 'TechCorp Solutions',
      location: 'Remote',
      salary: '₹15,000/month',
      appliedDate: DateTime(2024, 6, 15),
      status: ApplicationStatus.pending,
      description: 'Develop mobile applications using Flutter framework',
      duration: '3 months',
      companyLogo: 'https://via.placeholder.com/60x60/4285F4/FFFFFF?text=TC',
    ),
    Internship(
      id: '2',
      title: 'UI/UX Design Intern',
      company: 'Design Studio Pro',
      location: 'Mumbai, India',
      salary: '₹12,000/month',
      appliedDate: DateTime(2024, 6, 10),
      status: ApplicationStatus.shortlisted,
      description: 'Create user-friendly interfaces and experiences',
      duration: '4 months',
      companyLogo: 'https://via.placeholder.com/60x60/FF6B6B/FFFFFF?text=DS',
    ),
    Internship(
      id: '3',
      title: 'Data Science Intern',
      company: 'Analytics Hub',
      location: 'Bangalore, India',
      salary: '₹18,000/month',
      appliedDate: DateTime(2024, 6, 5),
      status: ApplicationStatus.rejected,
      description: 'Work on machine learning models and data analysis',
      duration: '6 months',
      companyLogo: 'https://via.placeholder.com/60x60/4ECDC4/FFFFFF?text=AH',
    ),
    Internship(
      id: '4',
      title: 'Backend Developer Intern',
      company: 'CodeBase Inc',
      location: 'Hyderabad, India',
      salary: '₹16,000/month',
      appliedDate: DateTime(2024, 6, 1),
      status: ApplicationStatus.accepted,
      description: 'Develop server-side applications and APIs',
      duration: '5 months',
      companyLogo: 'https://via.placeholder.com/60x60/45B7D1/FFFFFF?text=CB',
    ),
    Internship(
      id: '5',
      title: 'Marketing Intern',
      company: 'Brand Builders',
      location: 'Delhi, India',
      salary: '₹10,000/month',
      appliedDate: DateTime(2024, 5, 28),
      status: ApplicationStatus.pending,
      description: 'Assist in digital marketing campaigns and content creation',
      duration: '3 months',
      companyLogo: 'https://via.placeholder.com/60x60/F39C12/FFFFFF?text=BB',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Applied Internships',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2E86AB),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Container
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2E86AB), Color(0xFF4EA5D9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Total Applied', appliedInternships.length.toString()),
                _buildStatItem('Pending', _getStatusCount(ApplicationStatus.pending).toString()),
                _buildStatItem('Shortlisted', _getStatusCount(ApplicationStatus.shortlisted).toString()),
                _buildStatItem('Accepted', _getStatusCount(ApplicationStatus.accepted).toString()),
              ],
            ),
          ),
          // Internships List
          Expanded(
            child: appliedInternships.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: appliedInternships.length,
              itemBuilder: (context, index) {
                return _buildInternshipCard(appliedInternships[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to browse internships screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigate to Browse Internships')),
          );
        },
        backgroundColor: const Color(0xFF2E86AB),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Find More',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildInternshipCard(Internship internship) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Company Logo
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          internship.companyLogo,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFF2E86AB),
                              child: Center(
                                child: Text(
                                  internship.company[0].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            internship.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            internship.company,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: Colors.grey[500]),
                              const SizedBox(width: 4),
                              Text(
                                internship.location,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _buildStatusBadge(internship.status),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  internship.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildInfoChip(Icons.payment, internship.salary),
                    const SizedBox(width: 12),
                    _buildInfoChip(Icons.schedule, internship.duration),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Applied on ${_formatDate(internship.appliedDate)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => _viewDetails(internship),
                      child: const Text(
                        'View Details',
                        style: TextStyle(
                          color: Color(0xFF2E86AB),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (internship.status == ApplicationStatus.pending ||
                        internship.status == ApplicationStatus.shortlisted)
                      IconButton(
                        onPressed: () => _withdrawApplication(internship),
                        icon: const Icon(Icons.close, size: 20),
                        color: Colors.red[400],
                        tooltip: 'Withdraw Application',
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

  Widget _buildStatusBadge(ApplicationStatus status) {
    Color color;
    String text;
    IconData icon;

    switch (status) {
      case ApplicationStatus.pending:
        color = Colors.orange;
        text = 'Pending';
        icon = Icons.hourglass_empty;
        break;
      case ApplicationStatus.shortlisted:
        color = Colors.blue;
        text = 'Shortlisted';
        icon = Icons.star;
        break;
      case ApplicationStatus.accepted:
        color = Colors.green;
        text = 'Accepted';
        icon = Icons.check_circle;
        break;
      case ApplicationStatus.rejected:
        color = Colors.red;
        text = 'Rejected';
        icon = Icons.cancel;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2E86AB).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF2E86AB)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF2E86AB),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_outline,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 24),
          Text(
            'No Applied Internships',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Start applying to internships to see them here',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  int _getStatusCount(ApplicationStatus status) {
    return appliedInternships.where((internship) => internship.status == status).length;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _viewDetails(Internship internship) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildDetailsBottomSheet(internship),
    );
  }

  Widget _buildDetailsBottomSheet(Internship internship) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            internship.companyLogo,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFF2E86AB),
                                child: Center(
                                  child: Text(
                                    internship.company[0].toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              internship.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              internship.company,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildStatusBadge(internship.status),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildDetailSection('Description', internship.description),
                  _buildDetailSection('Location', internship.location),
                  _buildDetailSection('Salary', internship.salary),
                  _buildDetailSection('Duration', internship.duration),
                  _buildDetailSection('Applied Date', _formatDate(internship.appliedDate)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E86AB),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  void _withdrawApplication(Internship internship) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Withdraw Application'),
        content: Text('Are you sure you want to withdraw your application for ${internship.title}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Application withdrawn for ${internship.title}')),
              );
            },
            child: const Text('Withdraw', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Applications'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ApplicationStatus.values.map((status) {
            return CheckboxListTile(
              title: Text(status.name.toUpperCase()),
              value: true, // You can implement actual filtering logic here
              onChanged: (value) {
                // Implement filter logic
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}

// Data Models
class Internship {
  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final DateTime appliedDate;
  final ApplicationStatus status;
  final String description;
  final String duration;
  final String companyLogo;

  Internship({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.appliedDate,
    required this.status,
    required this.description,
    required this.duration,
    required this.companyLogo,
  });
}

enum ApplicationStatus {
  pending,
  shortlisted,
  accepted,
  rejected,
}