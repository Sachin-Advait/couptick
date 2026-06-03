import 'package:flutter/material.dart';
import 'package:consumer_app/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import '../utils/responsive.dart';

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

  // Mock data
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

  // Document upload states
  String? _panDocument;
  String? _aadhaarDocument;
  String? _addressProof;

  void _handleSubmit() {
    if (!_skipKyc && !_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed(Routes.ticketsAwarded);  // ← ADD THIS LINE
    });
  }

  void _handleSkip() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Skip KYC?',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'You can complete your profile later, but some features may be limited until KYC is verified.',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            color: const Color(0xFF6B7280),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: const Color(0xFF6B7280),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.goNamed(Routes.home);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Skip for Now',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleDocumentPick(String docType) {
    // Simulate file picker
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
          style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
        ),
        backgroundColor: const Color(0xFF10B981),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(Responsive.spacing(context, 20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complete Your Profile',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 24),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                      SizedBox(height: Responsive.spacing(context, 4)),
                      Text(
                        'Step 2 of 2',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _handleSkip,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                        color: const Color(0xFFFF6B35),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Personal Information Section
                      _buildSectionHeader('Personal Information'),
                      SizedBox(height: Responsive.spacing(context, 16)),

                      _buildTextField(
                        controller: _nameController,
                        label: 'Full Name *',
                        hint: 'Enter your full name',
                        icon: Icons.person_outline,
                      ),
                      SizedBox(height: Responsive.spacing(context, 16)),

                      _buildTextField(
                        controller: _emailController,
                        label: 'Email Address *',
                        hint: 'Enter your email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: Responsive.spacing(context, 24)),

                      // Address Section
                      _buildSectionHeader('Address Details'),
                      SizedBox(height: Responsive.spacing(context, 16)),

                      _buildTextField(
                        controller: _addressController,
                        label: 'Address *',
                        hint: 'Enter your address',
                        icon: Icons.home_outlined,
                        maxLines: 2,
                      ),
                      SizedBox(height: Responsive.spacing(context, 16)),

                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdown(
                              label: 'State *',
                              value: _selectedState,
                              items: _states,
                              onChanged: (value) {
                                setState(() {
                                  _selectedState = value;
                                  _selectedCity = null;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: Responsive.spacing(context, 8)),  // ← Reduced from 12 to 8
                          Expanded(
                            child: _buildDropdown(
                              label: 'City *',
                              value: _selectedCity,
                              items: _selectedState != null
                                  ? _cities[_selectedState!]!
                                  : [],
                              onChanged: (value) {
                                setState(() {
                                  _selectedCity = value;
                                });
                              },
                              enabled: _selectedState != null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.spacing(context, 16)),

                      _buildTextField(
                        controller: _pincodeController,
                        label: 'Pincode *',
                        hint: 'Enter 6-digit pincode',
                        icon: Icons.location_on_outlined,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                      ),
                      SizedBox(height: Responsive.spacing(context, 24)),

                      // KYC Section
                      _buildSectionHeader('KYC Documents (Optional)'),
                      SizedBox(height: Responsive.spacing(context, 8)),
                      Text(
                        'Complete KYC to unlock all features',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 13),
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                      SizedBox(height: Responsive.spacing(context, 16)),

                      _buildTextField(
                        controller: _panController,
                        label: 'PAN Number',
                        hint: 'Enter PAN (e.g., ABCDE1234F)',
                        icon: Icons.credit_card,
                        maxLength: 10,
                        textCapitalization: TextCapitalization.characters,
                      ),
                      SizedBox(height: Responsive.spacing(context, 12)),

                      _buildDocumentUpload(
                        'Upload PAN Card',
                        _panDocument,
                            () => _handleDocumentPick('pan'),
                      ),
                      SizedBox(height: Responsive.spacing(context, 16)),

                      _buildTextField(
                        controller: _aadhaarController,
                        label: 'Aadhaar Number',
                        hint: 'Enter 12-digit Aadhaar',
                        icon: Icons.badge_outlined,
                        keyboardType: TextInputType.number,
                        maxLength: 12,
                      ),
                      SizedBox(height: Responsive.spacing(context, 12)),

                      _buildDocumentUpload(
                        'Upload Aadhaar Card',
                        _aadhaarDocument,
                            () => _handleDocumentPick('aadhaar'),
                      ),
                      SizedBox(height: Responsive.spacing(context, 16)),

                      _buildDocumentUpload(
                        'Upload Address Proof',
                        _addressProof,
                            () => _handleDocumentPick('address'),
                      ),
                      SizedBox(height: Responsive.spacing(context, 32)),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: Responsive.dimension(context, 52),
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF6B35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            disabledBackgroundColor:
                            const Color(0xFFFF6B35).withOpacity(0.5),
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
                            'Complete Setup',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 16),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.spacing(context, 20)),
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
      style: TextStyle(
        fontSize: Responsive.fontSize(context, 18),
        fontWeight: FontWeight.w700,
        color: const Color(0xFF1A1A2E),
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
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A2E),
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 8)),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          maxLength: maxLength,
          textCapitalization: textCapitalization,
          validator: label.contains('*')
              ? (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          }
              : null,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: const Color(0xFFFF6B35)),
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
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A2E),
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 8)),
        DropdownButtonFormField<String>(
          initialValue: value,
          items: items
              .map((item) => DropdownMenuItem(
            value: item,
            child: Text(item),
          ))
              .toList(),
          onChanged: enabled ? onChanged : null,
          decoration: InputDecoration(
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
      ],
    );
  }

  Widget _buildDocumentUpload(
      String label,
      String? fileName,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Responsive.spacing(context, 16)),
        decoration: BoxDecoration(
          color: fileName != null
              ? const Color(0xFF10B981).withOpacity(0.05)
              : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: fileName != null
                ? const Color(0xFF10B981)
                : const Color(0xFFE5E7EB),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(Responsive.spacing(context, 8)),
              decoration: BoxDecoration(
                color: fileName != null
                    ? const Color(0xFF10B981).withOpacity(0.1)
                    : const Color(0xFFFF6B35).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                fileName != null ? Icons.check_circle : Icons.upload_file,
                color:
                fileName != null ? const Color(0xFF10B981) : const Color(0xFFFF6B35),
                size: Responsive.iconSize(context, 24),
              ),
            ),
            SizedBox(width: Responsive.spacing(context, 12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 2)),
                  Text(
                    fileName ?? 'Tap to upload (JPG, PNG, PDF)',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: fileName != null
                          ? const Color(0xFF10B981)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Responsive.iconSize(context, 16),
              color: const Color(0xFF6B7280),
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