import 'dart:math' as math;

import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({super.key});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen>
    with TickerProviderStateMixin {
  bool _scratched = false;
  bool _isRevealing = false;

  late AnimationController _pulseController;
  late AnimationController _revealController;
  late AnimationController _confettiController;
  late AnimationController _timerController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _revealScaleAnimation;
  late Animation<double> _revealOpacityAnimation;
  late Animation<double> _confettiAnimation;
  late Animation<double> _timerAnimation;

  static const int _totalSeconds = 45;
  int _secondsRemaining = _totalSeconds;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _revealScaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _revealController, curve: Curves.elasticOut),
    );

    _revealOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _revealController, curve: Curves.easeOut),
    );

    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _confettiAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _confettiController, curve: Curves.easeOut),
    );

    _timerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: _totalSeconds),
    );

    _timerAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _timerController, curve: Curves.linear));

    _timerController.addListener(() {
      final remaining = (_totalSeconds * (1 - _timerController.value)).ceil();
      if (remaining != _secondsRemaining && mounted) {
        setState(() => _secondsRemaining = remaining);
      }
    });

    _timerController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _revealController.dispose();
    _confettiController.dispose();
    _timerController.dispose();
    super.dispose();
  }

  void _handleScratch() {
    if (_scratched || _isRevealing) return;
    setState(() => _isRevealing = true);

    Future.delayed(const Duration(milliseconds: 80), () {
      if (!mounted) return;
      setState(() {
        _scratched = true;
        _isRevealing = false;
      });
      _pulseController.stop();
      _revealController.forward();
      _confettiController.forward();
    });
  }

  String get _timerLabel {
    final m = _secondsRemaining ~/ 60;
    final s = _secondsRemaining % 60;
    return '${m.toString().padLeft(1, '0')}:${s.toString().padLeft(2, '0')}';
  }

  Color get _timerColor {
    if (_secondsRemaining > 20) return AppColors.success;
    if (_secondsRemaining > 10) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.widthMultiplier),
                  child: Column(
                    children: [
                      SizedBox(height: 24.heightMultiplier),
                      _buildPrizeBanner(context),
                      SizedBox(height: 24.heightMultiplier),
                      _buildStatsRow(context),
                      SizedBox(height: 32.heightMultiplier),
                      _buildScratchCard(context),
                      SizedBox(height: 32.heightMultiplier),
                      if (_scratched) _buildActionButtons(context),
                      SizedBox(height: 32.heightMultiplier),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.widthMultiplier,
        vertical: 14.heightMultiplier,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8.widthMultiplier),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10.radiusMultipier),
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16.widthMultiplier,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(width: 12.widthMultiplier),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'iPhone 15 Pro Max',
                  style: context.bold.copyWith(
                    fontSize: 16.textMultiplier,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.heightMultiplier),
                Text(
                  'Scratch & Win',
                  style: context.regular.copyWith(
                    fontSize: 12.textMultiplier,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _timerAnimation,
            builder: (context, _) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.widthMultiplier,
                  vertical: 8.heightMultiplier,
                ),
                decoration: BoxDecoration(
                  color: _timerColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.radiusMultipier),
                  border: Border.all(color: _timerColor.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 14.widthMultiplier,
                      color: _timerColor,
                    ),
                    SizedBox(width: 4.widthMultiplier),
                    Text(
                      _timerLabel,
                      style: context.semiBold.copyWith(
                        fontSize: 13.textMultiplier,
                        color: _timerColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrizeBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.widthMultiplier),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withBlue(120)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.radiusMultipier),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -10,
            top: -10,
            child: Container(
              width: 80.widthMultiplier,
              height: 80.widthMultiplier,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: -20,
            child: Container(
              width: 60.widthMultiplier,
              height: 60.widthMultiplier,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withOpacity(0.05),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(14.widthMultiplier),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16.radiusMultipier),
                ),
                child: Text(
                  '📱',
                  style: TextStyle(fontSize: 28.textMultiplier),
                ),
              ),
              SizedBox(width: 16.widthMultiplier),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prize Pool',
                      style: context.regular.copyWith(
                        fontSize: 11.textMultiplier,
                        color: AppColors.white.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 4.heightMultiplier),
                    Text(
                      'iPhone 15 Pro Max',
                      style: context.extraBold.copyWith(
                        fontSize: 18.textMultiplier,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: 4.heightMultiplier),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.widthMultiplier,
                        vertical: 3.heightMultiplier,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(6.radiusMultipier),
                      ),
                      child: Text(
                        'Worth ₹1,34,900',
                        style: context.semiBold.copyWith(
                          fontSize: 11.textMultiplier,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.confirmation_number_outlined,
            value: '5',
            label: 'Max Tickets',
            color: AppColors.info,
          ),
        ),
        SizedBox(width: 12.widthMultiplier),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.currency_rupee_rounded,
            value: '299',
            label: 'Entry Fee',
            color: AppColors.secondary,
          ),
        ),
        SizedBox(width: 12.widthMultiplier),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.people_outline_rounded,
            value: '1.2K',
            label: 'Players',
            color: AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.widthMultiplier,
        vertical: 14.heightMultiplier,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.radiusMultipier),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.widthMultiplier),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.radiusMultipier),
            ),
            child: Icon(icon, size: 18.widthMultiplier, color: color),
          ),
          SizedBox(height: 8.heightMultiplier),
          Text(
            value,
            style: context.bold.copyWith(
              fontSize: 16.textMultiplier,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 2.heightMultiplier),
          Text(
            label,
            style: context.regular.copyWith(
              fontSize: 10.textMultiplier,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildScratchCard(BuildContext context) {
    return Column(
      children: [
        Text(
          _scratched ? 'Congratulations! 🎉' : 'Scratch to Reveal',
          style: context.extraBold.copyWith(
            fontSize: 20.textMultiplier,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 6.heightMultiplier),
        Text(
          _scratched
              ? 'You\'ve won raffle tickets for the draw!'
              : 'Tap the card below to scratch and see your prizes',
          style: context.regular.copyWith(
            fontSize: 13.textMultiplier,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24.heightMultiplier),
        GestureDetector(
          onTap: _handleScratch,
          onPanUpdate: (_) => _handleScratch(),
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _pulseAnimation,
              _revealScaleAnimation,
            ]),
            builder: (context, child) {
              return Transform.scale(
                scale: _scratched
                    ? _revealScaleAnimation.value
                    : _pulseAnimation.value,
                child: child,
              );
            },
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(maxWidth: 320.widthMultiplier),
              height: 260.heightMultiplier,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.radiusMultipier),
                boxShadow: [
                  BoxShadow(
                    color:
                        (_scratched
                                ? AppColors.primary
                                : AppColors.textDisabled)
                            .withOpacity(0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.radiusMultipier),
                child: Stack(
                  children: [
                    // Background
                    Positioned.fill(
                      child: _scratched
                          ? Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.primary.withBlue(110),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFD0D5DD),
                                    Color(0xFFE8ECF2),
                                    Color(0xFFD0D5DD),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                    ),

                    // Shimmer lines on unscratched card
                    if (!_scratched) ...[
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: CustomPaint(painter: _ScratchPatternPainter()),
                      ),
                    ],

                    // Confetti dots when revealed
                    if (_scratched)
                      AnimatedBuilder(
                        animation: _confettiAnimation,
                        builder: (context, _) {
                          return CustomPaint(
                            painter: _ConfettiPainter(
                              progress: _confettiAnimation.value,
                            ),
                            size: Size.infinite,
                          );
                        },
                      ),

                    // Content
                    Center(
                      child: _scratched
                          ? AnimatedBuilder(
                              animation: _revealOpacityAnimation,
                              builder: (context, child) => Opacity(
                                opacity: _revealOpacityAnimation.value,
                                child: child,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(16.widthMultiplier),
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withOpacity(0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '🎟️',
                                      style: TextStyle(
                                        fontSize: 44.textMultiplier,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.heightMultiplier),
                                  Text(
                                    'You Won!',
                                    style: context.extraBold.copyWith(
                                      fontSize: 22.textMultiplier,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  SizedBox(height: 6.heightMultiplier),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.widthMultiplier,
                                      vertical: 6.heightMultiplier,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(
                                        20.radiusMultipier,
                                      ),
                                    ),
                                    child: Text(
                                      '3 Raffle Tickets',
                                      style: context.semiBold.copyWith(
                                        fontSize: 14.textMultiplier,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(18.widthMultiplier),
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.touch_app_rounded,
                                    size: 36.widthMultiplier,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                SizedBox(height: 16.heightMultiplier),
                                Text(
                                  'Scratch Here',
                                  style: context.bold.copyWith(
                                    fontSize: 18.textMultiplier,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 4.heightMultiplier),
                                Text(
                                  'Tap or swipe to reveal',
                                  style: context.regular.copyWith(
                                    fontSize: 12.textMultiplier,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Progress indicator below card
        SizedBox(height: 20.heightMultiplier),
        AnimatedBuilder(
          animation: _timerAnimation,
          builder: (context, _) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: LinearProgressIndicator(
                    value: _timerAnimation.value,
                    backgroundColor: AppColors.border,
                    valueColor: AlwaysStoppedAnimation<Color>(_timerColor),
                    minHeight: 6,
                  ),
                ),
                SizedBox(height: 8.heightMultiplier),
                Text(
                  'Time remaining: $_timerLabel',
                  style: context.regular.copyWith(
                    fontSize: 12.textMultiplier,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52.heightMultiplier,
          child: ElevatedButton(
            onPressed: () => context.pushNamed(Routes.processingTickets),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.radiusMultipier),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue to Tickets',
                  style: context.bold.copyWith(
                    fontSize: 15.textMultiplier,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 8.widthMultiplier),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.white,
                  size: 18.widthMultiplier,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.heightMultiplier),
        SizedBox(
          width: double.infinity,
          height: 48.heightMultiplier,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.border, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.radiusMultipier),
              ),
            ),
            child: Text(
              'View Campaign Details',
              style: context.semiBold.copyWith(
                fontSize: 14.textMultiplier,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Draws a cross-hatch pattern on the unscratched card surface
class _ScratchPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const spacing = 18.0;

    for (double x = -size.height; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        paint,
      );
    }
    for (double x = size.width + size.height; x > 0; x -= spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x - size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Draws animated confetti dots on reveal
class _ConfettiPainter extends CustomPainter {
  final double progress;

  _ConfettiPainter({required this.progress});

  static final _rand = math.Random(42);
  static final _dots = List.generate(28, (i) {
    return _ConfettiDot(
      x: _rand.nextDouble(),
      y: _rand.nextDouble(),
      radius: 3 + _rand.nextDouble() * 5,
      color: [
        const Color(0xFFFFD23F),
        const Color(0xFFFF6B6B),
        Colors.white,
        const Color(0xFF7FFFB0),
      ][i % 4],
      speed: 0.5 + _rand.nextDouble() * 0.5,
      angle: _rand.nextDouble() * math.pi * 2,
    );
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final dot in _dots) {
      if (progress < dot.speed * 0.3) continue;
      final t = ((progress - dot.speed * 0.2) / 0.8).clamp(0.0, 1.0);
      final opacity = (1 - t * 0.7).clamp(0.0, 1.0);
      final dx = dot.x * size.width + math.cos(dot.angle) * 40 * t;
      final dy = dot.y * size.height - 60 * t * dot.speed;
      canvas.drawCircle(
        Offset(dx, dy),
        dot.radius * (1 - t * 0.3),
        Paint()..color = dot.color.withOpacity(opacity * 0.85),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter old) =>
      old.progress != progress;
}

class _ConfettiDot {
  final double x, y, radius, speed, angle;
  final Color color;

  const _ConfettiDot({
    required this.x,
    required this.y,
    required this.radius,
    required this.color,
    required this.speed,
    required this.angle,
  });
}
