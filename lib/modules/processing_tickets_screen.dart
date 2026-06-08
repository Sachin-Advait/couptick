import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProcessingTicketsScreen extends StatefulWidget {
  const ProcessingTicketsScreen({super.key});

  @override
  State<ProcessingTicketsScreen> createState() =>
      _ProcessingTicketsScreenState();
}

class _ProcessingTicketsScreenState extends State<ProcessingTicketsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _simulateProcessing();
  }

  void _simulateProcessing() async {
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) setState(() => _progress = i);
    }
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) context.pushNamed(Routes.ticketsAwarded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D2233),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.widthMultiplier),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated ticket icon
              RotationTransition(
                turns: _controller,
                child: Container(
                  width: 120.widthMultiplier,
                  height: 120.widthMultiplier,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, Color(0xFF1A6B8A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.35),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '🎟️',
                      style: TextStyle(fontSize: 52.textMultiplier),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 36.heightMultiplier),

              Text(
                'Processing Your Tickets',
                style: context.extraBold.copyWith(
                  fontSize: 22.textMultiplier,
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.heightMultiplier),
              Text(
                'Please wait while we generate your raffle tickets...',
                style: context.regular.copyWith(
                  fontSize: 13.textMultiplier,
                  color: AppColors.white.withOpacity(0.65),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 36.heightMultiplier),

              // Progress bar
              Container(
                height: 8.heightMultiplier,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.radiusMultipier),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.radiusMultipier),
                  child: LinearProgressIndicator(
                    value: _progress / 100,
                    backgroundColor: Colors.transparent,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.secondary,
                    ),
                    minHeight: 8,
                  ),
                ),
              ),
              SizedBox(height: 12.heightMultiplier),
              Text(
                '$_progress%',
                style: context.bold.copyWith(
                  fontSize: 16.textMultiplier,
                  color: AppColors.secondary,
                ),
              ),
              SizedBox(height: 36.heightMultiplier),

              // Steps
              _buildStep(context, '✓', 'Game completed', true),
              SizedBox(height: 10.heightMultiplier),
              _buildStep(
                context,
                _progress >= 30 ? '✓' : '⏳',
                'Calculating score',
                _progress >= 30,
              ),
              SizedBox(height: 10.heightMultiplier),
              _buildStep(
                context,
                _progress >= 60 ? '✓' : '⏳',
                'Generating tickets',
                _progress >= 60,
              ),
              SizedBox(height: 10.heightMultiplier),
              _buildStep(
                context,
                _progress >= 90 ? '✓' : '⏳',
                'Finalizing entry',
                _progress >= 90,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(
    BuildContext context,
    String icon,
    String text,
    bool completed,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.widthMultiplier,
        vertical: 14.heightMultiplier,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(completed ? 0.1 : 0.04),
        borderRadius: BorderRadius.circular(12.radiusMultipier),
        border: Border.all(
          color: AppColors.white.withOpacity(completed ? 0.2 : 0.08),
        ),
      ),
      child: Row(
        children: [
          Text(icon, style: TextStyle(fontSize: 20.textMultiplier)),
          SizedBox(width: 12.widthMultiplier),
          Text(
            text,
            style: context.semiBold.copyWith(
              fontSize: 13.textMultiplier,
              color: AppColors.white.withOpacity(completed ? 1.0 : 0.45),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
