import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:caproj/Homepage.dart';
import 'package:caproj/SignUp.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _isLoading = false;
  late AnimationController _animationController;
  late AnimationController _floatingController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _floatingAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _floatingController.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  Future<void> loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    const String apiUrl = "http://192.168.11.1:3000/api/v1/users/login";
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData["success"] == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        } else {
          _showSnackBar(responseData["message"], isError: true);
        }
      } else {
        _showSnackBar("Login failed. Please try again.", isError: true);
      }
    } catch (error) {
      _showSnackBar("An error occurred. Please try again.", isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError
            ? const Color(0xFFE74C3C)
            : const Color(0xFF27AE60),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    final bool isTablet = width > 600;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1E3A8A),
                Color(0xFF3B82F6),
                Color(0xFF60A5FA),
                Color(0xFFf5f7fa),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.4, 0.7, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // Floating Elements Background
              ...List.generate(6, (index) {
                return AnimatedBuilder(
                  animation: _floatingAnimation,
                  builder: (context, child) {
                    return Positioned(
                      top: height * (0.1 + (index * 0.15)),
                      left: width * (0.1 + ((index % 3) * 0.3)),
                      child: Transform.translate(
                        offset: Offset(
                          _floatingAnimation.value * (index.isEven ? 1 : -1),
                          _floatingAnimation.value * 0.5,
                        ),
                        child: Container(
                          width: 60 + (index * 10),
                          height: 60 + (index * 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),

              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: height - MediaQuery.of(context).padding.top,
                    ),
                    child: IntrinsicHeight(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Enhanced Logo Section
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.05,
                                horizontal: width * 0.1,
                              ),
                              child: AnimatedBuilder(
                                animation: _slideAnimation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(0, _slideAnimation.value),
                                    child: Column(
                                      children: [
                                        // Modern Logo Design
                                        Hero(
                                          tag: 'logo',
                                          child: Container(
                                            padding: const EdgeInsets.all(25),
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF1E3A8A).withOpacity(0.3),
                                                  blurRadius: 25,
                                                  offset: const Offset(0, 15),
                                                  spreadRadius: 5,
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.work_outline_rounded,
                                              size: isTablet ? 60 : 50,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: height * 0.03),

                                        // Brand Name
                                        ShaderMask(
                                          shaderCallback: (bounds) => const LinearGradient(
                                            colors: [Colors.white, Color(0xFF60A5FA)],
                                          ).createShader(bounds),
                                          child: Text(
                                            "ApplyWise",
                                            style: TextStyle(
                                              fontSize: isTablet ? 32 : 28,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: height * 0.01),

                                        // Tagline
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.2),
                                            ),
                                          ),
                                          child: Text(
                                            "Launch Your Career Journey",
                                            style: TextStyle(
                                              fontSize: isTablet ? 16 : 14,
                                              color: Colors.white.withOpacity(0.95),
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),

                            const Spacer(),

                            // Enhanced Form Section
                            AnimatedBuilder(
                              animation: _slideAnimation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _slideAnimation.value * 0.5),
                                  child: Container(
                                    width: double.infinity,
                                    constraints: BoxConstraints(
                                      maxWidth: isTablet ? 500 : double.infinity,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: isTablet ? 50 : 0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(isTablet ? 30 : 40),
                                        topRight: Radius.circular(isTablet ? 30 : 40),
                                        bottomLeft: isTablet ? const Radius.circular(30) : Radius.zero,
                                        bottomRight: isTablet ? const Radius.circular(30) : Radius.zero,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          blurRadius: 30,
                                          offset: const Offset(0, -10),
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: height * 0.04,
                                        horizontal: isTablet ? 40 : width * 0.08,
                                      ),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Enhanced Title Section
                                            Center(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Sign In to Your Future",
                                                    style: TextStyle(
                                                      fontSize: isTablet ? 32 : 28,
                                                      fontWeight: FontWeight.bold,
                                                      color: const Color(0xFF2C3E50),
                                                    ),
                                                  ),
                                                  SizedBox(height: height * 0.01),
                                                  Text(
                                                    "Continue building your professional network",
                                                    style: TextStyle(
                                                      fontSize: isTablet ? 16 : 14,
                                                      color: Colors.grey[600],
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: height * 0.04),

                                            // Enhanced Email Field
                                            _buildInputLabel("Email Address", Icons.email_outlined),
                                            SizedBox(height: height * 0.01),
                                            _buildTextFormField(
                                              controller: emailController,
                                              focusNode: emailFocus,
                                              hintText: "Enter your email address",
                                              prefixIcon: Icons.email_outlined,
                                              keyboardType: TextInputType.emailAddress,
                                              validator: _validateEmail,
                                              isTablet: isTablet,
                                              height: height,
                                            ),
                                            SizedBox(height: height * 0.025),

                                            // Enhanced Password Field
                                            _buildInputLabel("Password", Icons.lock_outline),
                                            SizedBox(height: height * 0.01),
                                            _buildTextFormField(
                                              controller: passwordController,
                                              focusNode: passwordFocus,
                                              hintText: "Enter your password",
                                              prefixIcon: Icons.lock_outline,
                                              obscureText: _obscurePassword,
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _obscurePassword = !_obscurePassword;
                                                  });
                                                },
                                                icon: Icon(
                                                  _obscurePassword
                                                      ? Icons.visibility_off_outlined
                                                      : Icons.visibility_outlined,
                                                  color: const Color(0xFF1E3A8A),
                                                  size: isTablet ? 24 : 20,
                                                ),
                                              ),
                                              validator: _validatePassword,
                                              isTablet: isTablet,
                                              height: height,
                                            ),

                                            // Forgot Password Link
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton(
                                                onPressed: () {
                                                  _showSnackBar("Password reset link will be sent to your email!");
                                                },
                                                child: Text(
                                                  "Forgot Password?",
                                                  style: TextStyle(
                                                    color: const Color(0xFF1E3A8A),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: isTablet ? 15 : 13,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: height * 0.02),

                                            // Enhanced Sign In Button
                                            Container(
                                              width: double.infinity,
                                              height: isTablet ? 60 : height * 0.065,
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                                borderRadius: BorderRadius.circular(15),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: const Color(0xFF1E3A8A).withOpacity(0.4),
                                                    blurRadius: 15,
                                                    offset: const Offset(0, 8),
                                                  ),
                                                ],
                                              ),
                                              child: ElevatedButton(
                                                // onPressed: _isLoading ? null : loginUser,
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => Homepage()),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.transparent,
                                                  foregroundColor: Colors.white,
                                                  shadowColor: Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                ),
                                                child: _isLoading
                                                    ? const SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2,
                                                  ),
                                                )
                                                    : Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.login_rounded,
                                                      size: isTablet ? 24 : 20,
                                                      color: Colors.white,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      "Sign In to Your Future",
                                                      style: TextStyle(
                                                        fontSize: isTablet ? 18 : 16,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: 0.5,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: height * 0.02),

                                            // Divider
                                            Row(
                                              children: [
                                                Expanded(child: Divider(color: Colors.grey[300])),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                                  child: Text(
                                                    "or continue with",
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: isTablet ? 14 : 12,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(child: Divider(color: Colors.grey[300])),
                                              ],
                                            ),

                                            SizedBox(height: height * 0.02),

                                            // Social Login Buttons
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: _buildSocialButton(
                                                    "Google",
                                                    Icons.g_mobiledata,
                                                    Colors.red,
                                                    isTablet,
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: _buildSocialButton(
                                                    "LinkedIn",
                                                    Icons.business_center,
                                                    const Color(0xFF0077B5),
                                                    isTablet,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: height * 0.03),

                                            // Enhanced Signup Link
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[50],
                                                  borderRadius: BorderRadius.circular(15),
                                                  border: Border.all(color: Colors.grey[200]!),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => const Signup(),
                                                      ),
                                                    );
                                                  },
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontSize: isTablet ? 16 : 14,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: "New to InternConnect? ",
                                                          style: TextStyle(
                                                            color: Colors.grey[600],
                                                          ),
                                                        ),
                                                        const TextSpan(
                                                          text: "Create Account",
                                                          style: TextStyle(
                                                            color: Color(0xFF1E3A8A),
                                                            fontWeight: FontWeight.w600,
                                                            decoration: TextDecoration.underline,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: height * 0.02),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF1E3A8A)),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
      ],
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    required bool isTablet,
    required double height,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E3A8A), Color(0xFF1E3A8A)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              prefixIcon,
              color: Colors.white,
              size: isTablet ? 20 : 18,
            ),
          ),
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(
            vertical: height * 0.02,
            horizontal: 20,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFF1E3A8A),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, IconData icon, Color color, bool isTablet) {
    return Container(
      height: isTablet ? 50 : 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            _showSnackBar("$text login integration coming soon!");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: isTablet ? 24 : 20),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  fontSize: isTablet ? 16 : 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}