import 'dart:async';
import 'dart:math';

import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../models/game_score.dart';
import '../../services/leaderboard_service.dart';
import '../../services/user_service.dart';

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------
const double _gravity = 2600.0; // px/s²
const double _jumpVelocity = -860.0; // px/s (negative = up)
const double _dinoSize = 44.0; // logical px — matches emoji visual size
const double _dinoFontSize = 32.0; // emoji font size, kept close to _dinoSize
const double _obstacleWidth = 32.0; // px
const double _dinoXOffset = 72.0; // px from left edge
const double _hitboxPadding = 8.0; // px shaved off each side for fairness

class DinoRunScreen extends StatefulWidget {
  const DinoRunScreen({super.key});

  @override
  State<DinoRunScreen> createState() => _DinoRunScreenState();
}

class _DinoRunScreenState extends State<DinoRunScreen>
    with SingleTickerProviderStateMixin {
  // ── game state ─────────────────────────────────────────────────────────────
  bool _started = false;
  bool _gameOver = false;

  // ── physics (logical pixels from top of game area) ─────────────────────────
  double _dinoTop = 0;
  double _velocity = 0;
  bool _onGround = true;

  // FIX: pending jump flag — set immediately on tap, consumed at start of tick
  // This ensures a tap is NEVER dropped even if it arrives mid-frame.
  bool _jumpPending = false;

  // ── obstacles ──────────────────────────────────────────────────────────────
  final List<_Obstacle> _obstacles = [];
  double _nextObstacleIn = 0;
  final Random _rng = Random();

  // ── score / speed ──────────────────────────────────────────────────────────
  int _score = 0;
  double _gameSpeed = 280; // px/s

  // ── timing ─────────────────────────────────────────────────────────────────
  Timer? _timer;
  DateTime? _lastTick;

  // ── layout — set once by LayoutBuilder ────────────────────────────────────
  double _gameAreaHeight = 0;
  double _gameAreaWidth = 0; // FIX: store width for correct obstacle spawn x
  double _groundY = 0;
  double _groundHeight = 0;

  // ── lifecycle ──────────────────────────────────────────────────────────────
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // ── game control ───────────────────────────────────────────────────────────
  void _initLayout(double w, double h) {
    _gameAreaWidth = w;
    _gameAreaHeight = h;
    _groundHeight = h * 0.20;
    _groundY = h - _groundHeight;
    _dinoTop = _groundY - _dinoSize;
  }

  void _resetGame() {
    _dinoTop = _groundY - _dinoSize;
    _velocity = 0;
    _onGround = true;
    _jumpPending = false;
    _obstacles.clear();
    _score = 0;
    _gameSpeed = 280;
    _nextObstacleIn = _randomInterval();
    _started = true;
    _gameOver = false;
    _lastTick = DateTime.now();
  }

  void _startGame() {
    _timer?.cancel();
    setState(_resetGame);

    _timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!_started || _gameOver) return;
      _tick();
    });
  }

  // FIX: tap sets _jumpPending immediately — never lost, never tested inside tick race
  void _onTap() {
    if (_gameOver) return;
    if (!_started) {
      _startGame();
      return;
    }
    // Allow jump only when on ground OR very early in jump arc (coyote frames)
    if (_onGround || _dinoTop > (_groundY - _dinoSize) - 12) {
      _jumpPending = true;
      HapticFeedback.lightImpact();
    }
  }

  double _randomInterval() => 1.4 + _rng.nextDouble() * 1.2; // 1.4 – 2.6 s

  // ── game loop ──────────────────────────────────────────────────────────────
  void _tick() {
    final now = DateTime.now();
    final dt =
        (_lastTick != null
                ? now.millisecondsSinceEpoch - _lastTick!.millisecondsSinceEpoch
                : 16)
            .clamp(4, 48) /
        1000.0;
    _lastTick = now;

    setState(() {
      // FIX: consume pending jump at the very START of the tick
      // before any physics runs — guarantees it's never skipped
      if (_jumpPending) {
        _jumpPending = false;
        if (_onGround || _dinoTop > (_groundY - _dinoSize) - 12) {
          _onGround = false;
          _velocity = _jumpVelocity;
        }
      }

      // ── dino physics ──────────────────────────────────────────────────────
      if (!_onGround) {
        _velocity += _gravity * dt;
        _dinoTop += _velocity * dt;

        final groundEdge = _groundY - _dinoSize;
        if (_dinoTop >= groundEdge) {
          _dinoTop = groundEdge;
          _velocity = 0;
          _onGround = true;
        }
      }

      // ── obstacle spawning ─────────────────────────────────────────────────
      _nextObstacleIn -= dt;
      if (_nextObstacleIn <= 0) {
        // FIX: spawn at _gameAreaWidth (screen width), not height
        final obsHeight = (_groundHeight * (0.4 + _rng.nextDouble() * 0.5))
            .clamp(24.0, _groundHeight * 0.88);
        _obstacles.add(
          _Obstacle(
            x: _gameAreaWidth + 10, // just off the right edge
            height: obsHeight,
          ),
        );
        _nextObstacleIn = _randomInterval();
      }

      for (final obs in _obstacles) {
        obs.x -= _gameSpeed * dt;
      }
      _obstacles.removeWhere((o) => o.x + _obstacleWidth < 0);

      // ── collision (AABB with padded hitbox) ───────────────────────────────
      final dinoLeft = _dinoXOffset + _hitboxPadding;
      final dinoRight = _dinoXOffset + _dinoSize - _hitboxPadding;
      final dinoBottom = _dinoTop + _dinoSize - _hitboxPadding;
      final dinoTopPx = _dinoTop + _hitboxPadding;

      for (final obs in _obstacles) {
        final obsLeft = obs.x + _hitboxPadding;
        final obsRight = obs.x + _obstacleWidth - _hitboxPadding;
        final obsTop = _groundY - obs.height + _hitboxPadding;

        final hitsX = dinoRight > obsLeft && dinoLeft < obsRight;
        final hitsY = dinoBottom > obsTop && dinoTopPx < _groundY;

        if (hitsX && hitsY) {
          _doGameOver();
          return;
        }
      }

      // ── score & speed ramp ────────────────────────────────────────────────
      _score++;
      if (_score % 300 == 0 && _gameSpeed < 680) {
        _gameSpeed += 25;
      }
    });
  }

  // ── game over ──────────────────────────────────────────────────────────────
  void _doGameOver() async {
    _timer?.cancel();
    HapticFeedback.heavyImpact();
    setState(() {
      _gameOver = true;
      _started = false;
    });

    try {
      final gameScore = GameScore(
        gameCode: 'dino_run',
        userId: SessionManager.userId,
        score: _score,
        timestamp: DateTime.now(),
      );
      await LeaderboardService().submitScore(gameScore);
    } catch (e) {
      debugPrint('Score submit error: $e');
    }

    if (mounted) _showGameOverDialog();
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.radiusMultipier),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.widthMultiplier),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.diagonal3Values(-1, 1, 1),
                child: Text(
                  '🦖',
                  style: TextStyle(fontSize: 48.textMultiplier),
                ),
              ),
              SizedBox(height: 8.heightMultiplier),
              Text(
                'Game Over!',
                style: ctx.extraBold.copyWith(
                  fontSize: 22.textMultiplier,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16.heightMultiplier),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.heightMultiplier),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(16.radiusMultipier),
                ),
                child: Column(
                  children: [
                    Text(
                      'Your Score',
                      style: ctx.regular.copyWith(
                        fontSize: 12.textMultiplier,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 6.heightMultiplier),
                    Text(
                      '$_score',
                      style: ctx.extraBold.copyWith(
                        fontSize: 44.textMultiplier,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.heightMultiplier),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        context.pushNamed(
                          Routes.leaderboard,
                          extra: {'gameCode': 'dino_run'},
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12.radiusMultipier,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 13.heightMultiplier,
                        ),
                      ),
                      child: Text(
                        'Scores',
                        style: ctx.semiBold.copyWith(
                          fontSize: 13.textMultiplier,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.widthMultiplier),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _startGame();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12.radiusMultipier,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 13.heightMultiplier,
                        ),
                      ),
                      child: Text(
                        'Play Again',
                        style: ctx.bold.copyWith(
                          fontSize: 13.textMultiplier,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.heightMultiplier),
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                },
                child: Text(
                  'Exit Game',
                  style: ctx.regular.copyWith(
                    fontSize: 13.textMultiplier,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final w = constraints.maxWidth;
                  final h = constraints.maxHeight;

                  // Initialise layout once — never reset during gameplay
                  if (_gameAreaHeight == 0 && h > 0 && w > 0) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) setState(() => _initLayout(w, h));
                    });
                  }

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _onTap,
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      children: [
                        // Sky
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFDEEEFA), Color(0xFFF4F7FC)],
                              ),
                            ),
                          ),
                        ),

                        // Clouds
                        ..._buildClouds(w),

                        // Ground fill
                        if (_groundY > 0)
                          Positioned(
                            left: 0,
                            right: 0,
                            top: _groundY,
                            height: _groundHeight,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.07),
                                border: Border(
                                  top: BorderSide(
                                    color: AppColors.primary.withOpacity(0.22),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        // Ground dash line
                        if (_groundY > 0)
                          Positioned(
                            left: 0,
                            right: 0,
                            top: _groundY + 3,
                            child: _DashLine(
                              color: AppColors.primary.withOpacity(0.13),
                            ),
                          ),

                        // Dino
                        if (_gameAreaHeight > 0)
                          Positioned(
                            left: _dinoXOffset,
                            top: _dinoTop,
                            width: _dinoSize,
                            height: _dinoSize,
                            child: const _DinoWidget(),
                          ),

                        // Obstacles
                        for (final obs in _obstacles)
                          if (_gameAreaHeight > 0)
                            Positioned(
                              left: obs.x,
                              top: _groundY - obs.height,
                              width: _obstacleWidth,
                              height: obs.height,
                              child: _CactusWidget(height: obs.height),
                            ),

                        // Start overlay
                        if (!_started && !_gameOver)
                          _buildStartOverlay(context),
                      ],
                    ),
                  );
                },
              ),
            ),
            _buildFooter(context),
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
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: EdgeInsets.all(8.widthMultiplier),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10.radiusMultipier),
                border: Border.all(color: AppColors.border),
              ),
              child: Image.asset(
                AppImages.back,
                height: 18.heightMultiplier,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(width: 12.widthMultiplier),
          Expanded(
            child: Row(
              children: [
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.diagonal3Values(-1, 1, 1),
                  child: Text(
                    '🦖',
                    style: TextStyle(fontSize: 20.textMultiplier),
                  ),
                ),
                SizedBox(width: 8.widthMultiplier),
                Text(
                  'Dino Run',
                  style: context.bold.copyWith(
                    fontSize: 17.textMultiplier,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 14.widthMultiplier,
              vertical: 7.heightMultiplier,
            ),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(20.radiusMultipier),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star_rounded,
                  size: 14.widthMultiplier,
                  color: AppColors.secondary,
                ),
                SizedBox(width: 4.widthMultiplier),
                Text(
                  '$_score',
                  style: context.bold.copyWith(
                    fontSize: 15.textMultiplier,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.widthMultiplier,
        vertical: 12.heightMultiplier,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.touch_app_rounded,
            size: 16.widthMultiplier,
            color: AppColors.textSecondary,
          ),
          SizedBox(width: 6.widthMultiplier),
          Text(
            'Tap anywhere to jump over obstacles!',
            style: context.regular.copyWith(
              fontSize: 13.textMultiplier,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartOverlay(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.widthMultiplier),
        padding: EdgeInsets.all(28.widthMultiplier),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24.radiusMultipier),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.diagonal3Values(-1, 1, 1),
              child: Text('🦖', style: TextStyle(fontSize: 56.textMultiplier)),
            ),
            SizedBox(height: 12.heightMultiplier),
            Text(
              'Ready to Run?',
              style: context.extraBold.copyWith(
                fontSize: 20.textMultiplier,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 6.heightMultiplier),
            Text(
              'Tap anywhere to start jumping',
              style: context.regular.copyWith(
                fontSize: 13.textMultiplier,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.heightMultiplier),
            Icon(
              Icons.touch_app_rounded,
              size: 36.widthMultiplier,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildClouds(double w) {
    if (_groundY == 0) return [];
    const data = [(0.12, 0.10, 0.85), (0.44, 0.18, 0.55), (0.73, 0.08, 0.70)];
    return data
        .map(
          (c) => Positioned(
            left: c.$1 * w,
            top: c.$2 * _groundY,
            child: Opacity(
              opacity: c.$3,
              child: Text('☁️', style: TextStyle(fontSize: 22.textMultiplier)),
            ),
          ),
        )
        .toList();
  }
}

// ── Dino ─────────────────────────────────────────────────────────────────────
class _DinoWidget extends StatelessWidget {
  const _DinoWidget();

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.diagonal3Values(-1, 1, 1),
      child: Text(
        '🦖',
        style: TextStyle(fontSize: _dinoFontSize.textMultiplier),
      ),
    );
  }
}

// ── Cactus ───────────────────────────────────────────────────────────────────
class _CactusWidget extends StatelessWidget {
  final double height;

  const _CactusWidget({required this.height});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        '🌵',
        style: TextStyle(
          fontSize: (height * 0.60).clamp(20.0, 44.0).textMultiplier,
        ),
      ),
    );
  }
}

// ── Dash line ─────────────────────────────────────────────────────────────────
class _DashLine extends StatelessWidget {
  final Color color;

  const _DashLine({required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 1),
      painter: _DashPainter(color: color),
    );
  }
}

class _DashPainter extends CustomPainter {
  final Color color;

  const _DashPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + 12, 0), paint);
      x += 22;
    }
  }

  @override
  bool shouldRepaint(covariant _DashPainter old) => old.color != color;
}

// ── Obstacle model ────────────────────────────────────────────────────────────
class _Obstacle {
  double x;
  final double height;

  _Obstacle({required this.x, required this.height});
}
