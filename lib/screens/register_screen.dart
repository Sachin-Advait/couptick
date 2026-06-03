import 'package:flutter/material.dart';
import 'package:consumer_app/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import '../utils/responsive.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  final _otpControllers = List.generate(6, (_) => TextEditingController());
  final _otpFocusNodes = List.generate(6, (_) => FocusNode());

  int _currentStep = 0; // 0: Mobile, 1: OTP, 2: Complete
  bool _termsAccepted = false;
  bool _isLoading = false;
  int _resendTimer = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    _canResend = false;
    _resendTimer = 30;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _resendTimer--;
          if (_resendTimer == 0) {
            _canResend = true;
          }
        });
        return _resendTimer > 0;
      }
      return false;
    });
  }

  void _handleMobileSubmit() {
    if (_formKey.currentState!.validate()) {
      if (!_termsAccepted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please accept Terms & Conditions',
              style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
            ),
            backgroundColor: const Color(0xFFFF6B35),
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
          _currentStep = 1;
        });
        _startResendTimer();
      });
      context.goNamed(Routes.profileSetup);
    }
  }

  void _handleOtpSubmit() {
    final otp = _otpControllers.map((c) => c.text).join();

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter complete OTP',
            style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
          ),
          backgroundColor: const Color(0xFFFF6B35),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate OTP verification
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _currentStep = 2;
      });

      // Navigate to home after showing success
      Future.delayed(const Duration(seconds: 2), () {
        context.goNamed(Routes.home);
      });
    });
  }

  void _handleResendOtp() {
    if (_canResend) {
      _startResendTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'OTP resent successfully',
            style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
          ),
          backgroundColor: const Color(0xFF10B981),
          duration: const Duration(seconds: 2),
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
                // Hero Section
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

                // Form Section
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
                    child: _buildCurrentStep(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildMobileStep();
      case 1:
        return _buildOtpStep();
      case 2:
        return _buildSuccessStep();
      default:
        return _buildMobileStep();
    }
  }

  Widget _buildMobileStep() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Account',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 26),
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A1A2E),
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 8)),
          Text(
            'Enter your mobile number to get started',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              color: const Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 28)),

          // Mobile Number Field
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
            maxLength: 10,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your mobile number';
              }
              if (value.length != 10) {
                return 'Enter a valid 10-digit number';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Enter your mobile number',
              prefixIcon: const Icon(
                Icons.phone_android,
                color: Color(0xFFFF6B35),
              ),
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFFF6B35),
                  width: 2,
                ),
              ),
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 20)),

          // Terms & Conditions
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: _termsAccepted,
                onChanged: (value) {
                  setState(() {
                    _termsAccepted = value ?? false;
                  });
                },
                activeColor: const Color(0xFFFF6B35),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Responsive.spacing(context, 12),
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 13),
                        color: const Color(0xFF6B7280),
                      ),
                      children: const [
                        TextSpan(text: 'I agree to the '),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                            color: Color(0xFFFF6B35),
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: Color(0xFFFF6B35),
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.spacing(context, 24)),

          // Continue Button
          SizedBox(
            width: double.infinity,
            height: Responsive.dimension(context, 52),
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleMobileSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                disabledBackgroundColor: const Color(0xFFFF6B35).withOpacity(0.5),
              ),
              child: _isLoading
                  ? SizedBox(
                height: Responsive.dimension(context, 24),
                width: Responsive.dimension(context, 24),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : Text(
                'Send OTP',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 16),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 20)),

          // Login Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  color: const Color(0xFF6B7280),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.goNamed(Routes.login);
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    color: const Color(0xFFFF6B35),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOtpStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify OTP',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 26),
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1A1A2E),
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 8)),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              color: const Color(0xFF6B7280),
            ),
            children: [
              const TextSpan(text: 'Enter the 6-digit code sent to\n'),
              TextSpan(
                text: _mobileController.text,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 32)),

        // OTP Input Fields
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) {
            return SizedBox(
              width: Responsive.dimension(context, 48),
              height: Responsive.dimension(context, 56),
              child: TextFormField(
                controller: _otpControllers[index],
                focusNode: _otpFocusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 20),
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFE5E7EB),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFFF6B35),
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value.length == 1 && index < 5) {
                    _otpFocusNodes[index + 1].requestFocus();
                  } else if (value.isEmpty && index > 0) {
                    _otpFocusNodes[index - 1].requestFocus();
                  }
                },
              ),
            );
          }),
        ),
        SizedBox(height: Responsive.spacing(context, 24)),

        // Resend OTP
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _canResend
                  ? 'Didn\'t receive code? '
                  : 'Resend code in $_resendTimer seconds',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: const Color(0xFF6B7280),
              ),
            ),
            if (_canResend)
              GestureDetector(
                onTap: _handleResendOtp,
                child: Text(
                  'Resend',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    color: const Color(0xFFFF6B35),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: Responsive.spacing(context, 32)),

        // Verify Button
        SizedBox(
          width: double.infinity,
          height: Responsive.dimension(context, 52),
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleOtpSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              disabledBackgroundColor: const Color(0xFFFF6B35).withOpacity(0.5),
            ),
            child: _isLoading
                ? SizedBox(
              height: Responsive.dimension(context, 24),
              width: Responsive.dimension(context, 24),
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
                : Text(
              'Verify & Continue',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 16),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 16)),

        // Change Number
        Center(
          child: TextButton(
            onPressed: () {
              setState(() {
                _currentStep = 0;
                for (var controller in _otpControllers) {
                  controller.clear();
                }
              });
            },
            child: Text(
              'Change Mobile Number',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: const Color(0xFF6B7280),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessStep() {
    return Column(
      children: [
        SizedBox(height: Responsive.spacing(context, 40)),
        Container(
          width: Responsive.dimension(context, 120),
          height: Responsive.dimension(context, 120),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '✅',
              style: TextStyle(fontSize: Responsive.fontSize(context, 60)),
            ),
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 32)),
        Text(
          'Account Created!',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 28),
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1A1A2E),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Responsive.spacing(context, 12)),
        Text(
          'Your account has been created successfully.\nRedirecting you to home...',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            color: const Color(0xFF6B7280),
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Responsive.spacing(context, 40)),
        SizedBox(
          height: Responsive.dimension(context, 48),
          width: Responsive.dimension(context, 48),
          child: const CircularProgressIndicator(
            color: Color(0xFFFF6B35),
            strokeWidth: 3,
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 40)),
      ],
    );
  }

  @override
  void dispose() {
    _mobileController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}