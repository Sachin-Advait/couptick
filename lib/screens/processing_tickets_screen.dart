import 'package:flutter/material.dart';
import 'package:consumer_app/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import '../utils/responsive.dart';

class ProcessingTicketsScreen extends StatefulWidget {
  const ProcessingTicketsScreen({super.key});

  @override
  State<ProcessingTicketsScreen> createState() => _ProcessingTicketsScreenState();
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
      if (mounted) {
        setState(() => _progress = i);
      }
    }

    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      context.goNamed(Routes.ticketsAwarded);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Responsive.spacing(context, 24)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Icon
              RotationTransition(
                turns: _controller,
                child: Container(
                  width: Responsive.dimension(context, 120),
                  height: Responsive.dimension(context, 120),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF6B35).withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '🎟️',
                      style: TextStyle(fontSize: Responsive.fontSize(context, 60)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Responsive.spacing(context, 40)),

              Text(
                'Processing Your Tickets',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 24),
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Responsive.spacing(context, 12)),
              Text(
                'Please wait while we generate your raffle tickets...',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  color: Colors.white.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Responsive.spacing(context, 40)),

              // Progress Bar
              Container(
                height: Responsive.dimension(context, 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: _progress / 100,
                    backgroundColor: Colors.transparent,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFFF6B35),
                    ),
                    minHeight: Responsive.dimension(context, 8),
                  ),
                ),
              ),
              SizedBox(height: Responsive.spacing(context, 16)),
              Text(
                '$_progress%',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 18),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFF6B35),
                ),
              ),
              SizedBox(height: Responsive.spacing(context, 40)),

              // Processing Steps
              _buildStep('✓', 'Game completed', true),
              SizedBox(height: Responsive.spacing(context, 12)),
              _buildStep(
                _progress >= 30 ? '✓' : '⏳',
                'Calculating score',
                _progress >= 30,
              ),
              SizedBox(height: Responsive.spacing(context, 12)),
              _buildStep(
                _progress >= 60 ? '✓' : '⏳',
                'Generating tickets',
                _progress >= 60,
              ),
              SizedBox(height: Responsive.spacing(context, 12)),
              _buildStep(
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

  Widget _buildStep(String icon, String text, bool completed) {
    return Container(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(completed ? 0.1 : 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(completed ? 0.2 : 0.1),
        ),
      ),
      child: Row(
        children: [
          Text(
            icon,
            style: TextStyle(fontSize: Responsive.fontSize(context, 24)),
          ),
          SizedBox(width: Responsive.spacing(context, 12)),
          Text(
            text,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(completed ? 1.0 : 0.5),
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