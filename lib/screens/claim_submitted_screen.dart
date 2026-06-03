import 'package:confetti/confetti.dart';
import 'package:consumer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/responsive.dart';

class ClaimSubmittedScreen extends StatefulWidget {
  final String prize;
  final String value;
  final String referenceId;

  const ClaimSubmittedScreen({
    super.key,
    this.prize = 'Prize',
    this.value = '₹0',
    required this.referenceId,
  });

  @override
  State<ClaimSubmittedScreen> createState() => _ClaimSubmittedScreenState();
}

class _ClaimSubmittedScreenState extends State<ClaimSubmittedScreen>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      _confettiController.play();
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prize = widget.prize;
    final value = widget.value;
    final referenceId = widget.referenceId;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Stack(
        children: [
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.05,
              shouldLoop: false,
              colors: const [
                Color(0xFFFF6B35),
                Color(0xFFFFD23F),
                Color(0xFF10B981),
                Color(0xFF667eea),
                Color(0xFFf093fb),
              ],
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(Responsive.spacing(context, 24)),
                    child: Column(
                      children: [
                        SizedBox(height: Responsive.spacing(context, 40)),

                        // Success Animation
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: Container(
                              width: Responsive.dimension(context, 140),
                              height: Responsive.dimension(context, 140),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF10B981),
                                    Color(0xFF059669),
                                  ],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF10B981,
                                    ).withOpacity(0.3),
                                    blurRadius: 30,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  '✅',
                                  style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 70),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.spacing(context, 32)),

                        // Success Message
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                'Claim Submitted!',
                                style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 32),
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: Responsive.spacing(context, 12)),
                              Text(
                                'Your claim has been received successfully',
                                style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 16),
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Responsive.spacing(context, 40)),

                        // Claim Details Card
                        Container(
                          padding: EdgeInsets.all(
                            Responsive.spacing(context, 24),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '🏆',
                                    style: TextStyle(
                                      fontSize: Responsive.fontSize(
                                        context,
                                        50,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Responsive.spacing(context, 16),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Prize',
                                          style: TextStyle(
                                            fontSize: Responsive.fontSize(
                                              context,
                                              12,
                                            ),
                                            color: Colors.white.withOpacity(
                                              0.6,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          prize,
                                          style: TextStyle(
                                            fontSize: Responsive.fontSize(
                                              context,
                                              18,
                                            ),
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          'Worth $value',
                                          style: TextStyle(
                                            fontSize: Responsive.fontSize(
                                              context,
                                              14,
                                            ),
                                            color: const Color(0xFF10B981),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Responsive.spacing(context, 20)),

                              Divider(color: Colors.white.withOpacity(0.1)),
                              SizedBox(height: Responsive.spacing(context, 20)),

                              _buildInfoRow('Reference ID', referenceId),
                              SizedBox(height: Responsive.spacing(context, 12)),
                              _buildInfoRow('Status', 'Under Review'),
                              SizedBox(height: Responsive.spacing(context, 12)),
                              _buildInfoRow(
                                'Submitted On',
                                _formatDate(DateTime.now()),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Responsive.spacing(context, 32)),

                        // Next Steps
                        Container(
                          padding: EdgeInsets.all(
                            Responsive.spacing(context, 20),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD23F).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFFFD23F).withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: const Color(0xFFFFD23F),
                                    size: Responsive.iconSize(context, 20),
                                  ),
                                  SizedBox(
                                    width: Responsive.spacing(context, 8),
                                  ),
                                  Text(
                                    'What\'s Next?',
                                    style: TextStyle(
                                      fontSize: Responsive.fontSize(
                                        context,
                                        16,
                                      ),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Responsive.spacing(context, 12)),
                              _buildStep(
                                '1',
                                'Our team will verify your documents',
                              ),
                              _buildStep(
                                '2',
                                'You\'ll receive a confirmation email within 48 hours',
                              ),
                              _buildStep(
                                '3',
                                'Prize delivery within 7-10 business days',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Responsive.spacing(context, 32)),

                        // Contact Info
                        Container(
                          padding: EdgeInsets.all(
                            Responsive.spacing(context, 16),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.headset_mic,
                                color: const Color(0xFF10B981),
                                size: Responsive.iconSize(context, 24),
                              ),
                              SizedBox(width: Responsive.spacing(context, 12)),
                              Expanded(
                                child: Text(
                                  'Need help? Contact support@couptick.com',
                                  style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 13),
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Action Buttons
                Container(
                  padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: Responsive.dimension(context, 52),
                        child: ElevatedButton(
                          onPressed: () {
                            context.goNamed(Routes.myWins);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'View My Wins',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 16),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.spacing(context, 12)),
                      SizedBox(
                        width: double.infinity,
                        height: Responsive.dimension(context, 52),
                        child: OutlinedButton(
                          onPressed: () {
                            context.goNamed(Routes.home);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Back to Home',
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildStep(String number, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.spacing(context, 8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Responsive.dimension(context, 24),
            height: Responsive.dimension(context, 24),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD23F).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 12),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFFD23F),
                ),
              ),
            ),
          ),
          SizedBox(width: Responsive.spacing(context, 12)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 13),
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
