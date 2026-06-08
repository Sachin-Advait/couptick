import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _panController = TextEditingController();
  final _aadhaarController = TextEditingController();

  String? _selectedState;
  String? _selectedCity;
  bool _isLoading = false;
  final bool _skipKyc = false;

  String? _panDocument;
  String? _aadhaarDocument;
  String? _addressProof;

  final List<String> _states = [
    'Delhi',
    'Maharashtra',
    'Karnataka',
    'Tamil Nadu',
    'Gujarat',
  ];

  final Map<String, List<String>> _cities = {
    'Delhi': ['New Delhi', 'Dwarka', 'Rohini', 'Connaught Place'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur', 'Nashik'],
    'Karnataka': ['Bangalore', 'Mysore', 'Mangalore', 'Hubli'],
    'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai', 'Salem'],
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot'],
  };

  void _handleSubmit() {
    if (!_skipKyc && !_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      context.pushNamed(Routes.ticketsAwarded);
    });
  }

  void _handleSkip() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.radiusMultipier),
        ),
        title: Text(
          'Skip KYC?',
          style: context.bold.copyWith(
            fontSize: 18.textMultiplier,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          'You can complete your profile later, but some features may be limited until KYC is verified.',
          style: context.regular.copyWith(
            fontSize: 13.textMultiplier,
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: context.semiBold.copyWith(
                fontSize: 13.textMultiplier,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.goNamed(Routes.home);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.radiusMultipier),
              ),
            ),
            child: Text(
              'Skip for Now',
              style: context.semiBold.copyWith(
                fontSize: 13.textMultiplier,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleDocumentPick(String docType) {
    setState(() {
      switch (docType) {
        case 'pan':
          _panDocument = 'pan_card_123.jpg';
          break;
        case 'aadhaar':
          _aadhaarDocument = 'aadhaar_456.jpg';
          break;
        case 'address':
          _addressProof = 'address_proof_789.jpg';
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
        duration: const Duration(seconds: 2),
      ),
    );
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
              padding: EdgeInsets.symmetric(
                horizontal: 20.widthMultiplier,
                vertical: 16.heightMultiplier,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complete Your Profile',
                        style: context.extraBold.copyWith(
                          fontSize: 20.textMultiplier,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.heightMultiplier),
                      Text(
                        'Step 2 of 2',
                        style: context.regular.copyWith(
                          fontSize: 13.textMultiplier,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _handleSkip,
                    child: Text(
                      'Skip',
                      style: context.semiBold.copyWith(
                        fontSize: 14.textMultiplier,
                        color: AppColors.primary,
                      ),
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
                      _buildSectionHeader('Personal Information'),
                      SizedBox(height: 14.heightMultiplier),

                      _buildTextField(
                        controller: _nameController,
                        label: 'Full Name *',
                        hint: 'Enter your full name',
                        icon: Icons.person_outline_rounded,
                      ),
                      SizedBox(height: 14.heightMultiplier),

                      _buildTextField(
                        controller: _emailController,
                        label: 'Email Address *',
                        hint: 'Enter your email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 24.heightMultiplier),

                      _buildSectionHeader('Address Details'),
                      SizedBox(height: 14.heightMultiplier),

                      _buildTextField(
                        controller: _addressController,
                        label: 'Address *',
                        hint: 'Enter your address',
                        icon: Icons.home_outlined,
                        maxLines: 2,
                      ),
                      SizedBox(height: 14.heightMultiplier),

                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdown(
                              label: 'State *',
                              value: _selectedState,
                              items: _states,
                              onChanged: (v) => setState(() {
                                _selectedState = v;
                                _selectedCity = null;
                              }),
                            ),
                          ),
                          SizedBox(width: 8.widthMultiplier),
                          Expanded(
                            child: _buildDropdown(
                              label: 'City *',
                              value: _selectedCity,
                              items: _selectedState != null
                                  ? _cities[_selectedState!]!
                                  : [],
                              onChanged: (v) =>
                                  setState(() => _selectedCity = v),
                              enabled: _selectedState != null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.heightMultiplier),

                      _buildTextField(
                        controller: _pincodeController,
                        label: 'Pincode *',
                        hint: 'Enter 6-digit pincode',
                        icon: Icons.location_on_outlined,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                      ),
                      SizedBox(height: 24.heightMultiplier),

                      _buildSectionHeader('KYC Documents (Optional)'),
                      SizedBox(height: 6.heightMultiplier),
                      Text(
                        'Complete KYC to unlock all features',
                        style: context.regular.copyWith(
                          fontSize: 12.textMultiplier,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 14.heightMultiplier),

                      _buildTextField(
                        controller: _panController,
                        label: 'PAN Number',
                        hint: 'Enter PAN (e.g., ABCDE1234F)',
                        icon: Icons.credit_card_outlined,
                        maxLength: 10,
                        textCapitalization: TextCapitalization.characters,
                      ),
                      SizedBox(height: 10.heightMultiplier),

                      _buildDocumentUpload(
                        'Upload PAN Card',
                        _panDocument,
                        () => _handleDocumentPick('pan'),
                      ),
                      SizedBox(height: 14.heightMultiplier),

                      _buildTextField(
                        controller: _aadhaarController,
                        label: 'Aadhaar Number',
                        hint: 'Enter 12-digit Aadhaar',
                        icon: Icons.badge_outlined,
                        keyboardType: TextInputType.number,
                        maxLength: 12,
                      ),
                      SizedBox(height: 10.heightMultiplier),

                      _buildDocumentUpload(
                        'Upload Aadhaar Card',
                        _aadhaarDocument,
                        () => _handleDocumentPick('aadhaar'),
                      ),
                      SizedBox(height: 10.heightMultiplier),

                      _buildDocumentUpload(
                        'Upload Address Proof',
                        _addressProof,
                        () => _handleDocumentPick('address'),
                      ),
                      SizedBox(height: 32.heightMultiplier),

                      SizedBox(
                        width: double.infinity,
                        height: 52.heightMultiplier,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                14.radiusMultipier,
                              ),
                            ),
                            disabledBackgroundColor: AppColors.primary
                                .withOpacity(0.5),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  height: 22.widthMultiplier,
                                  width: 22.widthMultiplier,
                                  child: const CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Complete Setup',
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: context.bold.copyWith(
        fontSize: 16.textMultiplier,
        color: AppColors.textPrimary,
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
    int? maxLength,
    TextCapitalization textCapitalization = TextCapitalization.none,
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
          maxLength: maxLength,
          textCapitalization: textCapitalization,
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
            counterText: '',
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

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    bool enabled = true,
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
        DropdownButtonFormField<String>(
          initialValue: value,
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: enabled ? onChanged : null,
          style: context.regular.copyWith(
            fontSize: 13.textMultiplier,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
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
            Container(
              padding: EdgeInsets.all(8.widthMultiplier),
              decoration: BoxDecoration(
                color: uploaded
                    ? AppColors.success.withOpacity(0.12)
                    : AppColors.primarySurface,
                borderRadius: BorderRadius.circular(10.radiusMultipier),
              ),
              child: Icon(
                uploaded
                    ? Icons.check_circle_rounded
                    : Icons.upload_file_rounded,
                color: uploaded ? AppColors.success : AppColors.primary,
                size: 20.widthMultiplier,
              ),
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
                    fileName ?? 'Tap to upload (JPG, PNG, PDF)',
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
    _addressController.dispose();
    _pincodeController.dispose();
    _panController.dispose();
    _aadhaarController.dispose();
    super.dispose();
  }
}
