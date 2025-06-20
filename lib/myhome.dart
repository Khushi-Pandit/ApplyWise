import 'package:flutter/material.dart';
import 'package:caproj/Googlelist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Stunning Header with Gradient
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF667EEA),
                          Color(0xFF764BA2),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF667EEA).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello there! 🚀',
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.04,
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Discover Amazing\nOpportunities',
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.065,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.notifications_none_rounded,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF10B981),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '2,847 New Jobs',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenSize.width * 0.032,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Enhanced Search Bar
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 15,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search_rounded,
                                  color: Colors.grey.shade400,
                                  size: 22,
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Text(
                                    'Search dream internships...',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: screenSize.width * 0.04,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF667EEA).withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.tune_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Stunning Stats Section
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildGlassCard(
                            icon: Icons.work_outline_rounded,
                            title: '2,847',
                            subtitle: 'Active Jobs',
                            gradient: const LinearGradient(
                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                            ),
                            screenSize: screenSize,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildGlassCard(
                            icon: Icons.business_outlined,
                            title: '847',
                            subtitle: 'Companies',
                            gradient: const LinearGradient(
                              colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
                            ),
                            screenSize: screenSize,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildGlassCard(
                            icon: Icons.people_outline_rounded,
                            title: '12K+',
                            subtitle: 'Hired',
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFA8BFF), Color(0xFF2BD2FF)],
                            ),
                            screenSize: screenSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Section Header with Animation
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Featured Opportunities',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.055,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Handpicked for you',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF667EEA).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'View All',
                            style: TextStyle(
                              color: const Color(0xFF667EEA),
                              fontSize: screenSize.width * 0.035,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Premium Internship Cards
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildPremiumInternshipCard(
                        context: context,
                        title: 'Software Developer Intern',
                        company: 'Google',
                        location: 'Mountain View, CA',
                        salary: '\$5,200',
                        duration: '3 months',
                        applicants: '2.1K',
                        logoGradient: const LinearGradient(
                          colors: [Color(0xFF4285F4), Color(0xFF0F9D58)],
                        ),
                        isHot: true,
                        isFeatured: true,
                        screenSize: screenSize,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GooglieList()),
                          );
                        },
                      ),

                      _buildPremiumInternshipCard(
                        context: context,
                        title: 'DevOps Engineer',
                        company: 'Amazon',
                        location: 'Seattle, WA',
                        salary: '\$4,800',
                        duration: '6 months',
                        applicants: '1.8K',
                        logoGradient: const LinearGradient(
                          colors: [Color(0xFFFF9900), Color(0xFFFF6B00)],
                        ),
                        isHot: false,
                        isFeatured: false,
                        screenSize: screenSize,
                        onTap: () {},
                      ),

                      _buildPremiumInternshipCard(
                        context: context,
                        title: 'Product Design Intern',
                        company: 'Apple',
                        location: 'Cupertino, CA',
                        salary: '\$5,500',
                        duration: '4 months',
                        applicants: '3.2K',
                        logoGradient: const LinearGradient(
                          colors: [Color(0xFF000000), Color(0xFF434343)],
                        ),
                        isHot: true,
                        isFeatured: false,
                        screenSize: screenSize,
                        onTap: () {},
                      ),

                      _buildPremiumInternshipCard(
                        context: context,
                        title: 'Machine Learning Intern',
                        company: 'Meta',
                        location: 'Menlo Park, CA',
                        salary: '\$5,000',
                        duration: '5 months',
                        applicants: '2.7K',
                        logoGradient: const LinearGradient(
                          colors: [Color(0xFF1877F2), Color(0xFF42A5F5)],
                        ),
                        isHot: false,
                        isFeatured: true,
                        screenSize: screenSize,
                        onTap: () {},
                      ),

                      const SizedBox(height: 30),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
    required Size screenSize,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: gradient.colors.first.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: screenSize.width * 0.04,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: screenSize.width * 0.028,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumInternshipCard({
    required BuildContext context,
    required String title,
    required String company,
    required String location,
    required String salary,
    required String duration,
    required String applicants,
    required Gradient logoGradient,
    required bool isHot,
    required bool isFeatured,
    required Size screenSize,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: isFeatured
                  ? Border.all(
                color: const Color(0xFF667EEA).withOpacity(0.3),
                width: 2,
              )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: isFeatured
                      ? const Color(0xFF667EEA).withOpacity(0.15)
                      : Colors.black.withOpacity(0.08),
                  blurRadius: isFeatured ? 20 : 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: logoGradient,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: logoGradient.colors.first.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          company[0],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.045,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                              ),
                              if (isHot)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '🔥 HOT',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenSize.width * 0.025,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            company,
                            style: TextStyle(
                              fontSize: screenSize.width * 0.04,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (isFeatured) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Featured',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.width * 0.03,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 20),

                Row(
                  children: [
                    _buildInfoPill(
                      icon: Icons.location_on_outlined,
                      text: location,
                      color: const Color(0xFF667EEA),
                      screenSize: screenSize,
                    ),
                    const SizedBox(width: 8),
                    _buildInfoPill(
                      icon: Icons.schedule_outlined,
                      text: duration,
                      color: const Color(0xFF10B981),
                      screenSize: screenSize,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    _buildInfoPill(
                      icon: Icons.people_outline,
                      text: '$applicants applicants',
                      color: const Color(0xFFFF6B6B),
                      screenSize: screenSize,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Salary',
                          style: TextStyle(
                            fontSize: screenSize.width * 0.032,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          '$salary/month',
                          style: TextStyle(
                            fontSize: screenSize.width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF667EEA).withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoPill({
    required IconData icon,
    required String text,
    required Color color,
    required Size screenSize,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: screenSize.width * 0.03,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:caproj/Googlelist.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             // Custom App Bar
//             SliverToBoxAdapter(
//               child: Container(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Welcome back! 👋',
//                               style: TextStyle(
//                                 fontSize: screenSize.width * 0.04,
//                                 color: Colors.grey.shade600,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               'Find Your Dream Internship',
//                               style: TextStyle(
//                                 fontSize: screenSize.width * 0.06,
//                                 fontWeight: FontWeight.bold,
//                                 color: const Color(0xFF1E293B),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.08),
//                                 blurRadius: 10,
//                                 offset: const Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: const Icon(
//                             Icons.notifications_outlined,
//                             color: Color(0xFF64748B),
//                             size: 24,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Search Bar
//             SliverToBoxAdapter(
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.search,
//                       color: Colors.grey.shade400,
//                       size: 20,
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         'Search internships, companies...',
//                         style: TextStyle(
//                           color: Colors.grey.shade500,
//                           fontSize: screenSize.width * 0.04,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF3B82F6),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: const Icon(
//                         Icons.tune,
//                         color: Colors.white,
//                         size: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Quick Stats
//             SliverToBoxAdapter(
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: _buildStatCard(
//                         icon: Icons.work_outline,
//                         title: '2,500+',
//                         subtitle: 'Active Internships',
//                         color: const Color(0xFF3B82F6),
//                         screenSize: screenSize,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: _buildStatCard(
//                         icon: Icons.business_outlined,
//                         title: '500+',
//                         subtitle: 'Top Companies',
//                         color: const Color(0xFF10B981),
//                         screenSize: screenSize,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Section Header
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Featured Opportunities',
//                       style: TextStyle(
//                         fontSize: screenSize.width * 0.05,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xFF1E293B),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {},
//                       child: Text(
//                         'See All',
//                         style: TextStyle(
//                           color: const Color(0xFF3B82F6),
//                           fontSize: screenSize.width * 0.035,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Internship Cards
//             SliverPadding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               sliver: SliverList(
//                 delegate: SliverChildListDelegate([
//                   _buildInternshipCard(
//                     context: context,
//                     title: 'Software Developer Intern',
//                     company: 'Google',
//                     location: 'Mountain View, CA',
//                     salary: '\$5,000/month',
//                     type: 'Full-time',
//                     logo: 'G',
//                     logoColor: const Color(0xFF4285F4),
//                     logoBackground: const Color(0xFFE3F2FD),
//                     isHot: true,
//                     screenSize: screenSize,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => GooglieList()),
//                       );
//                     },
//                   ),
//
//                   _buildInternshipCard(
//                     context: context,
//                     title: 'DevOps Engineer',
//                     company: 'Amazon',
//                     location: 'Seattle, WA',
//                     salary: '\$4,800/month',
//                     type: 'Full-time',
//                     logo: 'A',
//                     logoColor: const Color(0xFFFF9900),
//                     logoBackground: const Color(0xFFFFF3E0),
//                     isHot: false,
//                     screenSize: screenSize,
//                     onTap: () {
//                       // Navigate to Amazon internship details
//                     },
//                   ),
//
//                   _buildInternshipCard(
//                     context: context,
//                     title: 'Product Management Intern',
//                     company: 'Microsoft',
//                     location: 'Redmond, WA',
//                     salary: '\$4,500/month',
//                     type: 'Full-time',
//                     logo: 'M',
//                     logoColor: const Color(0xFF00BCF2),
//                     logoBackground: const Color(0xFFE1F5FE),
//                     isHot: false,
//                     screenSize: screenSize,
//                     onTap: () {
//                       // Navigate to Microsoft internship details
//                     },
//                   ),
//
//                   _buildInternshipCard(
//                     context: context,
//                     title: 'UX Design Intern',
//                     company: 'Meta',
//                     location: 'Menlo Park, CA',
//                     salary: '\$5,200/month',
//                     type: 'Full-time',
//                     logo: 'f',
//                     logoColor: const Color(0xFF1877F2),
//                     logoBackground: const Color(0xFFE3F2FD),
//                     isHot: true,
//                     screenSize: screenSize,
//                     onTap: () {
//                       // Navigate to Meta internship details
//                     },
//                   ),
//
//                   const SizedBox(height: 20),
//                 ]),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//     required Size screenSize,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(
//               icon,
//               color: color,
//               size: 20,
//             ),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: screenSize.width * 0.045,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xFF1E293B),
//             ),
//           ),
//           Text(
//             subtitle,
//             style: TextStyle(
//               fontSize: screenSize.width * 0.03,
//               color: Colors.grey.shade600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInternshipCard({
//     required BuildContext context,
//     required String title,
//     required String company,
//     required String location,
//     required String salary,
//     required String type,
//     required String logo,
//     required Color logoColor,
//     required Color logoBackground,
//     required bool isHot,
//     required Size screenSize,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(20),
//           child: Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.06),
//                   blurRadius: 15,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: logoBackground,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Center(
//                         child: Text(
//                           logo,
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: logoColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   title,
//                                   style: TextStyle(
//                                     fontSize: screenSize.width * 0.045,
//                                     fontWeight: FontWeight.bold,
//                                     color: const Color(0xFF1E293B),
//                                   ),
//                                 ),
//                               ),
//                               if (isHot)
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 8,
//                                     vertical: 4,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: const Color(0xFFEF4444),
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Text(
//                                     'HOT',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: screenSize.width * 0.025,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             company,
//                             style: TextStyle(
//                               fontSize: screenSize.width * 0.04,
//                               color: Colors.grey.shade600,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     _buildInfoChip(
//                       icon: Icons.location_on_outlined,
//                       text: location,
//                       screenSize: screenSize,
//                     ),
//                     const SizedBox(width: 12),
//                     _buildInfoChip(
//                       icon: Icons.access_time_outlined,
//                       text: type,
//                       screenSize: screenSize,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       salary,
//                       style: TextStyle(
//                         fontSize: screenSize.width * 0.04,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xFF10B981),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF3B82F6).withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: const Icon(
//                         Icons.arrow_forward_ios,
//                         color: Color(0xFF3B82F6),
//                         size: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoChip({
//     required IconData icon,
//     required String text,
//     required Size screenSize,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             size: 14,
//             color: Colors.grey.shade600,
//           ),
//           const SizedBox(width: 4),
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: screenSize.width * 0.032,
//               color: Colors.grey.shade600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }