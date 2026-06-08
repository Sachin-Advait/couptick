import 'package:confetti/confetti.dart';
import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFF0D2233),
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
                AppColors.secondary,
                AppColors.warning,
                AppColors.success,
                AppColors.info,
                Color(0xFFf093fb),
              ],
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24.widthMultiplier),
                    child: Column(
                      children: [
                        SizedBox(height: 40.heightMultiplier),

                        // Success icon
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: Container(
                              width: 130.widthMultiplier,
                              height: 130.widthMultiplier,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.success,
                                    Color(0xFF059669),
                                  ],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.success.withOpacity(0.35),
                                    blurRadius: 30,
                                    spreadRadius: 8,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  '✅',
                                  style: TextStyle(fontSize: 60.textMultiplier),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 28.heightMultiplier),

                        // Heading
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                'Claim Submitted!',
                                style: context.extraBold.copyWith(
                                  fontSize: 28.textMultiplier,
                                  color: AppColors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10.heightMultiplier),
                              Text(
                                'Your claim has been received successfully',
                                style: context.regular.copyWith(
                                  fontSize: 14.textMultiplier,
                                  color: AppColors.white.withOpacity(0.75),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32.heightMultiplier),

                        // Claim details card
                        Container(
                          padding: EdgeInsets.all(22.widthMultiplier),
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(
                              24.radiusMultipier,
                            ),
                            border: Border.all(
                              color: AppColors.white.withOpacity(0.15),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '🏆',
                                    style: TextStyle(
                                      fontSize: 44.textMultiplier,
                                    ),
                                  ),
                                  SizedBox(width: 14.widthMultiplier),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Prize',
                                          style: context.regular.copyWith(
                                            fontSize: 11.textMultiplier,
                                            color: AppColors.white.withOpacity(
                                              0.55,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 2.heightMultiplier),
                                        Text(
                                          widget.prize,
                                          style: context.bold.copyWith(
                                            fontSize: 16.textMultiplier,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        Text(
                                          'Worth ${widget.value}',
                                          style: context.semiBold.copyWith(
                                            fontSize: 13.textMultiplier,
                                            color: AppColors.success,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 18.heightMultiplier),
                              Divider(color: AppColors.white.withOpacity(0.1)),
                              SizedBox(height: 18.heightMultiplier),
                              _buildInfoRow('Reference ID', widget.referenceId),
                              SizedBox(height: 10.heightMultiplier),
                              _buildInfoRow('Status', 'Under Review'),
                              SizedBox(height: 10.heightMultiplier),
                              _buildInfoRow(
                                'Submitted On',
                                _formatDate(DateTime.now()),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.heightMultiplier),

                        // Next steps
                        Container(
                          padding: EdgeInsets.all(18.widthMultiplier),
                          decoration: BoxDecoration(
                            color: AppColors.warning.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(
                              16.radiusMultipier,
                            ),
                            border: Border.all(
                              color: AppColors.warning.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: AppColors.warning,
                                    size: 18.widthMultiplier,
                                  ),
                                  SizedBox(width: 8.widthMultiplier),
                                  Text(
                                    "What's Next?",
                                    style: context.bold.copyWith(
                                      fontSize: 14.textMultiplier,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.heightMultiplier),
                              _buildStep(
                                '1',
                                'Our team will verify your documents',
                              ),
                              _buildStep(
                                '2',
                                "You'll receive a confirmation email within 48 hours",
                              ),
                              _buildStep(
                                '3',
                                'Prize delivery within 7-10 business days',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.heightMultiplier),

                        // Support
                        Container(
                          padding: EdgeInsets.all(14.widthMultiplier),
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(
                              12.radiusMultipier,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.headset_mic_rounded,
                                color: AppColors.success,
                                size: 20.widthMultiplier,
                              ),
                              SizedBox(width: 10.widthMultiplier),
                              Expanded(
                                child: Text(
                                  'Need help? Contact support@couptick.com',
                                  style: context.regular.copyWith(
                                    fontSize: 12.textMultiplier,
                                    color: AppColors.white.withOpacity(0.85),
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

                // Action buttons
                Container(
                  padding: EdgeInsets.all(20.widthMultiplier),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.05),
                    border: Border(
                      top: BorderSide(color: AppColors.white.withOpacity(0.1)),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 52.heightMultiplier,
                        child: ElevatedButton(
                          onPressed: () => context.pushNamed(Routes.myWins),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.success,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                16.radiusMultipier,
                              ),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'View My Wins',
                            style: context.bold.copyWith(
                              fontSize: 15.textMultiplier,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.heightMultiplier),
                      SizedBox(
                        width: double.infinity,
                        height: 52.heightMultiplier,
                        child: OutlinedButton(
                          onPressed: () => context.pushNamed(Routes.home),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: AppColors.white.withOpacity(0.3),
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                16.radiusMultipier,
                              ),
                            ),
                          ),
                          child: Text(
                            'Back to Home',
                            style: context.bold.copyWith(
                              fontSize: 15.textMultiplier,
                              color: AppColors.white,
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
          style: context.regular.copyWith(
            fontSize: 13.textMultiplier,
            color: AppColors.white.withOpacity(0.55),
          ),
        ),
        Text(
          value,
          style: context.semiBold.copyWith(
            fontSize: 13.textMultiplier,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildStep(String number, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.heightMultiplier),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22.widthMultiplier,
            height: 22.widthMultiplier,
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: context.bold.copyWith(
                  fontSize: 11.textMultiplier,
                  color: AppColors.warning,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.widthMultiplier),
          Expanded(
            child: Text(
              text,
              style: context.regular.copyWith(
                fontSize: 12.textMultiplier,
                color: AppColors.white.withOpacity(0.85),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
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
