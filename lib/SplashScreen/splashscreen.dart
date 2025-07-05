import 'package:flutter/material.dart';
import 'package:caproj/LoginSignUp/Login.dart';
import 'dart:math' as math;

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _opportunityController;
  late AnimationController _progressController;
  late AnimationController _starController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _logoSlide;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _opportunityFloat;
  late Animation<double> _progressFill;
  late Animation<double> _starTwinkle;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _opportunityController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _starController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Logo animations - professional entrance
    _logoScale = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    ));

    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ));

    _logoSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutCubic,
    ));

    // Text animations
    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    ));

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutQuart,
    ));

    // Opportunity icons floating animation
    _opportunityFloat = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _opportunityController,
      curve: Curves.easeInOut,
    ));

    // Progress bar animation
    _progressFill = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOutCubic,
    ));

    // Star twinkling animation
    _starTwinkle = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _starController,
      curve: Curves.easeInOut,
    ));

    // Start animations sequence
    _startAnimations();

    // Navigate to login after delay
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    });
  }

  void _startAnimations() async {
    // Start logo animation
    _logoController.forward();

    // Start text animation after logo
    await Future.delayed(const Duration(milliseconds: 600));
    _textController.forward();

    // Start opportunity icons floating
    await Future.delayed(const Duration(milliseconds: 300));
    _opportunityController.repeat(reverse: true);

    // Start progress animation
    await Future.delayed(const Duration(milliseconds: 400));
    _progressController.forward();

    // Start star twinkling
    _starController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _opportunityController.dispose();
    _progressController.dispose();
    _starController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1E3A8A), // Professional deep blue
              Color(0xFF1E3A8A), // Bright blue
              Color(0xFF60A5FA), // Light blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Animated career ladder/steps in background
              AnimatedBuilder(
                animation: _opportunityController,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: CareerPathPainter(_opportunityFloat.value),
                  );
                },
              ),

              // Floating opportunity icons
              AnimatedBuilder(
                animation: _opportunityController,
                builder: (context, child) {
                  return Positioned.fill(
                    child: Stack(
                      children: [
                        // Briefcase icon
                        _buildFloatingIcon(
                          Icons.work_outline,
                          0.15,
                          0.25,
                          _opportunityFloat.value,
                          0.0,
                        ),
                        // Chart icon
                        _buildFloatingIcon(
                          Icons.trending_up,
                          0.85,
                          0.3,
                          _opportunityFloat.value,
                          0.5,
                        ),
                        // Target icon
                        _buildFloatingIcon(
                          Icons.track_changes,
                          0.1,
                          0.7,
                          _opportunityFloat.value,
                          0.3,
                        ),
                        // Award icon
                        _buildFloatingIcon(
                          Icons.emoji_events_outlined,
                          0.9,
                          0.75,
                          _opportunityFloat.value,
                          0.8,
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Main content
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Animated logo with professional glow
                      AnimatedBuilder(
                        animation: _logoController,
                        builder: (context, child) {
                          return SlideTransition(
                            position: _logoSlide,
                            child: FadeTransition(
                              opacity: _logoOpacity,
                              child: ScaleTransition(
                                scale: _logoScale,
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                                    maxHeight: MediaQuery.of(context).size.height * 0.35,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.2),
                                        blurRadius: 30,
                                        spreadRadius: 10,
                                      ),
                                      BoxShadow(
                                        color: const Color(0xFF3B82F6).withOpacity(0.3),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.asset(
                                      'assets/images/applywise.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 50),

                      // Animated progress indicator
                      AnimatedBuilder(
                        animation: _progressController,
                        builder: (context, child) {
                          return FadeTransition(
                            opacity: _logoOpacity,
                            child: Column(
                              children: [
                                Container(
                                  width: 200,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: _progressFill.value,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF10B981), // Success green
                                            Color(0xFF34D399),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF10B981).withOpacity(0.5),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                AnimatedBuilder(
                                  animation: _starController,
                                  builder: (context, child) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(3, (index) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 4),
                                          child: Icon(
                                            Icons.star,
                                            color: Colors.amber.withOpacity(_starTwinkle.value),
                                            size: 16,
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 40),

                      // Animated text with professional styling
                      AnimatedBuilder(
                        animation: _textController,
                        builder: (context, child) {
                          return SlideTransition(
                            position: _textSlide,
                            child: FadeTransition(
                              opacity: _textOpacity,
                              child: Column(
                                children: [
                                  ShaderMask(
                                    shaderCallback: (bounds) => const LinearGradient(
                                      colors: [Colors.white, Color(0xFFE5E7EB)],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ).createShader(bounds),
                                    child: const Text(
                                      'ApplyWise',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.5,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 8,
                                            color: Colors.black26,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Your Gateway to Success',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingIcon(IconData icon, double leftFactor, double topFactor,
      double animationValue, double delay) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final floatOffset = math.sin((animationValue + delay) * 2 * math.pi) * 10;

    return Positioned(
      left: screenWidth * leftFactor,
      top: screenHeight * topFactor + floatOffset,
      child: AnimatedBuilder(
        animation: _logoController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _logoOpacity,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white.withOpacity(0.7),
                size: 24,
              ),
            ),
          );
        },
      ),
    );
  }
}

// Custom painter for career path visualization
class CareerPathPainter extends CustomPainter {
  final double progress;

  CareerPathPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw ascending steps/ladder representing career growth
    final stepWidth = size.width * 0.15;
    const stepHeight = 20.0;
    final startX = size.width * 0.1;
    final startY = size.height * 0.8;

    for (int i = 0; i < 5; i++) {
      final x = startX + (i * stepWidth * 0.8);
      final y = startY - (i * stepHeight * 2);

      final opacity = (progress * 5 - i).clamp(0.0, 1.0);

      final stepPaint = Paint()
        ..color = Colors.white.withOpacity(0.1 * opacity)
        ..style = PaintingStyle.fill;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, stepWidth, stepHeight),
        const Radius.circular(4),
      );

      canvas.drawRRect(rect, stepPaint);
      canvas.drawRRect(rect, paint);
    }

    // Draw connecting lines
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < 4; i++) {
      final x1 = startX + (i * stepWidth * 0.8) + stepWidth;
      final y1 = startY - (i * stepHeight * 2) + stepHeight / 2;
      final x2 = startX + ((i + 1) * stepWidth * 0.8);
      final y2 = startY - ((i + 1) * stepHeight * 2) + stepHeight / 2;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}