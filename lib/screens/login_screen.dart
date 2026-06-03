import 'package:flutter/material.dart';
import 'package:consumer_app/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import '../utils/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.goNamed(Routes.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all required fields',
            style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
          ),
          backgroundColor: const Color(0xFFFF6B35),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                /// Hero Section
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Responsive.spacing(context, 24),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '🎉',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 90),
                        ),
                      ),
                      SizedBox(height: Responsive.spacing(context, 12)),
                      Text(
                        'CoupTick',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 42),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: Responsive.spacing(context, 6)),
                      Text(
                        'Win Big with Every Purchase!',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 16),
                          color: Colors.white.withOpacity(0.95),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Form Section
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Responsive.spacing(context, 28)),
                    child: _buildForm(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 26),
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A1A2E),
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 8)),
          Text(
            'Login to start playing & winning',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              color: const Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 28)),

          /// Mobile Field
          Text(
            'Mobile Number *',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 8)),
          TextFormField(
            controller: _mobileController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your mobile number';
              }
              if (value.length != 10) {
                return 'Enter a valid 10-digit number';
              }
              return null;
            },
            decoration: _inputDecoration(
              context,
              hint: 'Enter your mobile number',
              icon: Icons.phone_android,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 18)),

          /// Password Field
          Text(
            'Password *',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 8)),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Minimum 6 characters required';
              }
              return null;
            },
            decoration: _inputDecoration(
              context,
              hint: 'Enter your password',
              icon: Icons.lock,
              suffix: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 14)),

          /// Remember + Forgot
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                    activeColor: const Color(0xFFFF6B35),
                  ),
                  const Text('Remember me'),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot?',
                  style: TextStyle(color: Color(0xFFFF6B35)),
                ),
              ),
            ],
          ),

          SizedBox(height: Responsive.spacing(context, 20)),

          /// Login Button
          SizedBox(
            width: double.infinity,
            height: Responsive.dimension(context, 52),
            child: ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Login to Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: Responsive.spacing(context, 16)),

// Register Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  color: const Color(0xFF6B7280),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pushNamed(Routes.register);
                },
                child: Text(
                  'Register Now',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFF6B35),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  InputDecoration _inputDecoration(BuildContext context,
      {required String hint,
        required IconData icon,
        Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFFFF6B35)),
      suffixIcon: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFFF6B35), width: 2),
      ),
    );
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
