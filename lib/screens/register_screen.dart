import 'package:consumer_app/common/utils/app_screen_util.dart';
import 'package:consumer_app/configs/assets/app_images.dart';
import 'package:consumer_app/configs/theme/app_colors.dart';
import 'package:consumer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  void _handleCreateAccount() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        context.goNamed(Routes.profileSetup);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all required fields'),
          backgroundColor: AppColors.secondary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.bg1),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.widthMultiplier),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                80.verticalSpace,
                Image.asset(
                  AppImages.textLogo2,
                  height: 56.heightMultiplier,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 40.heightMultiplier),

                /// Title
                Text(
                  'Register',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 26.textMultiplier,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 6.heightMultiplier),
                Text(
                  'Create your account to get started',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.textMultiplier,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 36.heightMultiplier),

                /// Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      40.verticalSpace,

                      /// Name
                      _buildInputField(
                        controller: _nameController,
                        hint: 'Name',
                        iconAsset: AppImages
                            .phone, // swap with a person icon if available
                        usePersonIcon: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 14.heightMultiplier),

                      /// Mobile Number
                      _buildInputField(
                        controller: _mobileController,
                        hint: 'Mobile Number',
                        iconAsset: AppImages.phone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
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
                      ),

                      SizedBox(height: 14.heightMultiplier),

                      /// Email
                      _buildInputField(
                        controller: _emailController,
                        hint: 'Email ID',
                        iconAsset: AppImages.mail,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                            r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 14.heightMultiplier),

                      /// Password
                      _buildInputField(
                        controller: _passwordController,
                        hint: 'Password',
                        iconAsset: AppImages.password,
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 6) {
                            return 'Minimum 6 characters required';
                          }
                          return null;
                        },
                        suffix: GestureDetector(
                          onTap: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.radiusMultipier),
                            child: Image.asset(
                              _obscurePassword
                                  ? AppImages.eyeoff
                                  : AppImages.eyeon,
                              width: 20.widthMultiplier,
                              height: 20.widthMultiplier,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 14.heightMultiplier),

                      /// Confirm Password
                      _buildInputField(
                        controller: _confirmPasswordController,
                        hint: 'Confirm Password',
                        iconAsset: AppImages.password,
                        obscureText: _obscureConfirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        suffix: GestureDetector(
                          onTap: () => setState(
                            () => _obscureConfirmPassword =
                                !_obscureConfirmPassword,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.radiusMultipier),
                            child: Image.asset(
                              _obscureConfirmPassword
                                  ? AppImages.eyeoff
                                  : AppImages.eyeon,
                              width: 20.widthMultiplier,
                              height: 20.widthMultiplier,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 40.heightMultiplier),

                      /// Create Account Button
                      SizedBox(
                        width: double.infinity,
                        height: 56.heightMultiplier,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleCreateAccount,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            disabledBackgroundColor: AppColors.secondary
                                .withOpacity(0.5),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                30.radiusMultipier,
                              ),
                            ),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  width: 22.widthMultiplier,
                                  height: 22.widthMultiplier,
                                  child: const CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.textMultiplier,
                                    color: AppColors.white,
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(height: 20.heightMultiplier),

                      /// Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.textMultiplier,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.goNamed(Routes.login),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13.textMultiplier,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.heightMultiplier),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required String iconAsset,
    bool usePersonIcon = false,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.textMultiplier,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.textMultiplier,
          color: AppColors.textSecondary,
        ),
        filled: true,
        fillColor: AppColors.surfaceVariant,
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 16.widthMultiplier),
            usePersonIcon
                ? Icon(
                    Icons.person_outline,
                    size: 20.widthMultiplier,
                    color: AppColors.textSecondary,
                  )
                : Image.asset(
                    iconAsset,
                    width: 20.widthMultiplier,
                    height: 20.widthMultiplier,
                    color: AppColors.textSecondary,
                  ),
            SizedBox(width: 10.widthMultiplier),
            Container(
              width: 1,
              height: 20.heightMultiplier,
              color: AppColors.border,
            ),
            SizedBox(width: 4.widthMultiplier),
          ],
        ),
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.radiusMultipier),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.radiusMultipier),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.radiusMultipier),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.radiusMultipier),
          borderSide: BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.radiusMultipier),
          borderSide: BorderSide(color: AppColors.error, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.heightMultiplier,
          horizontal: 4.widthMultiplier,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
