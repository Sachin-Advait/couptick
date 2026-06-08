import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClaimFormScreen extends StatefulWidget {
  final String prize;
  final String value;

  const ClaimFormScreen({super.key, this.prize = 'Prize', this.value = '₹0'});

  @override
  State<ClaimFormScreen> createState() => _ClaimFormScreenState();
}

class _ClaimFormScreenState extends State<ClaimFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  String? _idProof;
  String? _addressProof;
  String? _bankProof;
  bool _isLoading = false;

  void _handleDocumentPick(String docType) {
    setState(() {
      switch (docType) {
        case 'id':
          _idProof = 'id_proof_123.jpg';
          break;
        case 'address':
          _addressProof = 'address_proof_456.jpg';
          break;
        case 'bank':
          _bankProof = 'bank_proof_789.jpg';
          break;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Document uploaded successfully',
          style: context.regular.copyWith(fontSize: 13.textMultiplier),
        ),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    if (_idProof == null || _addressProof == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please upload required documents',
            style: context.regular.copyWith(fontSize: 13.textMultiplier),
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      context.go(
        '/claim-submitted',
        extra: {
          'prize': widget.prize,
          'value': widget.value,
          'referenceId': 'CLM-2026-${DateTime.now().millisecondsSinceEpoch}',
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: AppColors.white,
              padding: EdgeInsets.only(
                left: 16.widthMultiplier,
                right: 16.widthMultiplier,
                top: 12.heightMultiplier,
                bottom: 16.heightMultiplier,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => context.pop(),
                        child: Container(
                          padding: EdgeInsets.all(8.widthMultiplier),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(
                              12.radiusMultipier,
                            ),
                          ),
                          child: Image.asset(
                            AppImages.back,
                            height: 20.heightMultiplier,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.widthMultiplier),
                      Text(
                        'Claim Your Prize',
                        style: context.extraBold.copyWith(
                          fontSize: 20.textMultiplier,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.heightMultiplier),

                  // Prize banner
                  Container(
                    padding: EdgeInsets.all(16.widthMultiplier),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, Color(0xFF1A6B8A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16.radiusMultipier),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '🏆',
                          style: TextStyle(fontSize: 36.textMultiplier),
                        ),
                        SizedBox(width: 14.widthMultiplier),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.prize,
                                style: context.bold.copyWith(
                                  fontSize: 16.textMultiplier,
                                  color: AppColors.white,
                                ),
                              ),
                              SizedBox(height: 2.heightMultiplier),
                              Text(
                                'Worth ${widget.value}',
                                style: context.regular.copyWith(
                                  fontSize: 13.textMultiplier,
                                  color: AppColors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.widthMultiplier),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: context.bold.copyWith(
                          fontSize: 16.textMultiplier,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 16.heightMultiplier),

                      _buildTextField(
                        controller: _nameController,
                        label: 'Full Name *',
                        hint: 'Enter your full name',
                        icon: Icons.person_outline_rounded,
                      ),
                      SizedBox(height: 14.heightMultiplier),

                      _buildTextField(
                        controller: _emailController,
                        label: 'Email *',
                        hint: 'Enter your email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 14.heightMultiplier),

                      _buildTextField(
                        controller: _phoneController,
                        label: 'Phone Number *',
                        hint: 'Enter phone number',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 14.heightMultiplier),

                      _buildTextField(
                        controller: _addressController,
                        label: 'Delivery Address *',
                        hint: 'Enter complete address',
                        icon: Icons.home_outlined,
                        maxLines: 3,
                      ),
                      SizedBox(height: 24.heightMultiplier),

                      Text(
                        'Required Documents',
                        style: context.bold.copyWith(
                          fontSize: 16.textMultiplier,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 14.heightMultiplier),

                      _buildDocumentUpload(
                        'ID Proof (Aadhaar/PAN/Passport) *',
                        _idProof,
                        () => _handleDocumentPick('id'),
                      ),
                      SizedBox(height: 10.heightMultiplier),

                      _buildDocumentUpload(
                        'Address Proof *',
                        _addressProof,
                        () => _handleDocumentPick('address'),
                      ),
                      SizedBox(height: 10.heightMultiplier),

                      _buildDocumentUpload(
                        'Bank Details (Optional)',
                        _bankProof,
                        () => _handleDocumentPick('bank'),
                      ),
                      SizedBox(height: 32.heightMultiplier),

                      SizedBox(
                        width: double.infinity,
                        height: 52.heightMultiplier,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                14.radiusMultipier,
                              ),
                            ),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                              : Text(
                                  'Submit Claim',
                                  style: context.bold.copyWith(
                                    fontSize: 15.textMultiplier,
                                    color: AppColors.white,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 20.heightMultiplier),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.semiBold.copyWith(
            fontSize: 13.textMultiplier,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.heightMultiplier),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: context.regular.copyWith(
            fontSize: 14.textMultiplier,
            color: AppColors.textPrimary,
          ),
          validator: label.contains('*')
              ? (v) =>
                    (v == null || v.isEmpty) ? 'This field is required' : null
              : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: context.regular.copyWith(
              fontSize: 13.textMultiplier,
              color: AppColors.textDisabled,
            ),
            prefixIcon: Icon(
              icon,
              color: AppColors.primary,
              size: 20.widthMultiplier,
            ),
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.radiusMultipier),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.radiusMultipier),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.radiusMultipier),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.radiusMultipier),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.radiusMultipier),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.widthMultiplier,
              vertical: 14.heightMultiplier,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentUpload(
    String label,
    String? fileName,
    VoidCallback onTap,
  ) {
    final uploaded = fileName != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.widthMultiplier),
        decoration: BoxDecoration(
          color: uploaded ? AppColors.successSurface : AppColors.white,
          borderRadius: BorderRadius.circular(14.radiusMultipier),
          border: Border.all(
            color: uploaded ? AppColors.success : AppColors.border,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              uploaded ? Icons.check_circle_rounded : Icons.upload_file_rounded,
              color: uploaded ? AppColors.success : AppColors.primary,
              size: 22.widthMultiplier,
            ),
            SizedBox(width: 12.widthMultiplier),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.semiBold.copyWith(
                      fontSize: 13.textMultiplier,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.heightMultiplier),
                  Text(
                    fileName ?? 'Tap to upload',
                    style: context.regular.copyWith(
                      fontSize: 11.textMultiplier,
                      color: uploaded
                          ? AppColors.success
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.widthMultiplier,
              color: AppColors.textDisabled,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
