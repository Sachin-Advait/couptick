import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/responsive.dart';

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
          style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
        ),
        backgroundColor: const Color(0xFF10B981),
      ),
    );
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_idProof == null || _addressProof == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please upload required documents',
            style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
          ),
          backgroundColor: const Color(0xFFFF6B35),
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
    final prize = widget.prize;
    final value = widget.value;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(Responsive.spacing(context, 20)),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      SizedBox(width: Responsive.spacing(context, 8)),
                      Text(
                        'Claim Your Prize',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 20),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.spacing(context, 16)),
                  Container(
                    padding: EdgeInsets.all(Responsive.spacing(context, 16)),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '🏆',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 40),
                          ),
                        ),
                        SizedBox(width: Responsive.spacing(context, 16)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prize,
                                style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 18),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Worth $value',
                                style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 14),
                                  color: Colors.white.withOpacity(0.9),
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
                padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 18),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                        label: 'Email *',
                        hint: 'Enter your email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: Responsive.spacing(context, 16)),

                      _buildTextField(
                        controller: _phoneController,
                        label: 'Phone Number *',
                        hint: 'Enter phone number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: Responsive.spacing(context, 16)),

                      _buildTextField(
                        controller: _addressController,
                        label: 'Delivery Address *',
                        hint: 'Enter complete address',
                        icon: Icons.home_outlined,
                        maxLines: 3,
                      ),
                      SizedBox(height: Responsive.spacing(context, 24)),

                      Text(
                        'Required Documents',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 18),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: Responsive.spacing(context, 16)),

                      _buildDocumentUpload(
                        'ID Proof (Aadhaar/PAN/Passport) *',
                        _idProof,
                        () => _handleDocumentPick('id'),
                      ),
                      SizedBox(height: Responsive.spacing(context, 12)),

                      _buildDocumentUpload(
                        'Address Proof *',
                        _addressProof,
                        () => _handleDocumentPick('address'),
                      ),
                      SizedBox(height: Responsive.spacing(context, 12)),

                      _buildDocumentUpload(
                        'Bank Details (Optional)',
                        _bankProof,
                        () => _handleDocumentPick('bank'),
                      ),
                      SizedBox(height: Responsive.spacing(context, 32)),

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
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Submit Claim',
                                  style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 16),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
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
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 8)),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFFF6B35), width: 2),
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
            Icon(
              fileName != null ? Icons.check_circle : Icons.upload_file,
              color: fileName != null
                  ? const Color(0xFF10B981)
                  : const Color(0xFFFF6B35),
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
                    ),
                  ),
                  Text(
                    fileName ?? 'Tap to upload',
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
            const Icon(Icons.arrow_forward_ios, size: 16),
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
