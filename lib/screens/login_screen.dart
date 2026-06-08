import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:couptick/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      SessionManager.saveSession(
        accessToken: 'sachin',
        refreshToken: 'sachin',
        userId: '12345',
        fullName: 'CoupTick',
        email: 'admin@couptick.com',
      );
      context.goNamed(Routes.home);
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
  void initState() {
    _mobileController.text = '97178392';
    _passwordController.text = '12345678';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          width: double.infinity,
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
                60.verticalSpace,
                SizedBox(height: 60.heightMultiplier),
                Image.asset(
                  AppImages.textLogo2,
                  height: 56.heightMultiplier,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 6.heightMultiplier),
                SizedBox(height: 52.heightMultiplier),

                /// Title
                Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 26.textMultiplier,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 6.heightMultiplier),
                Text(
                  'Enter Mobile number and Password',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.textMultiplier,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 40.heightMultiplier),

                /// Form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Mobile Field
                      _buildInputField(
                        controller: _mobileController,
                        hint: 'Mobile Number',
                        iconAsset: AppImages.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          if (value.length != 8) {
                            return 'Enter a valid 10-digit number';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16.heightMultiplier),

                      /// Password Field
                      _buildInputField(
                        controller: _passwordController,
                        hint: 'Password',
                        iconAsset: AppImages.password,
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
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
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

                      SizedBox(height: 10.heightMultiplier),

                      /// Forgot Password
                      Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Forgot Password !',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.textMultiplier,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 40.heightMultiplier),

                      /// Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 56.heightMultiplier,
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                30.radiusMultipier,
                              ),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 16.textMultiplier,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 16.heightMultiplier),

                      /// Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 56.heightMultiplier,
                        child: OutlinedButton(
                          onPressed: () {
                            context.pushNamed(Routes.register);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                30.radiusMultipier,
                              ),
                            ),
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 16.textMultiplier,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 32.heightMultiplier),
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
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
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
            Image.asset(
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
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
