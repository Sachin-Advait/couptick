import 'dart:async';
import 'dart:math';

import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/common/widgets/game_over_dialog.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/game_score.dart';
import '../../services/leaderboard_service.dart';
import '../../utils/responsive.dart';

class SuperDashScreen extends StatefulWidget {
  const SuperDashScreen({super.key});

  @override
  State<SuperDashScreen> createState() => _SuperDashScreenState();
}

class _SuperDashScreenState extends State<SuperDashScreen> {
  double playerY = 0.5;
  double playerVelocity = 0;
  bool isJumping = false;
  bool isPlaying = false;
  bool isGameOver = false;

  List<Obstacle> obstacles = [];
  List<Coin> coins = [];
  int score = 0;
  int coinsCollected = 0;
  double gameSpeed = 4;
  Timer? gameTimer;

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      playerY = 0.5;
      playerVelocity = 0;
      isJumping = false;
      isPlaying = true;
      isGameOver = false;
      score = 0;
      coinsCollected = 0;
      gameSpeed = 4;
      obstacles.clear();
      coins.clear();
    });

    gameTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!isPlaying) return;
      _updateGame();
    });
  }

  void _updateGame() {
    setState(() {
      // Gravity
      if (isJumping || playerY < 0.5) {
        playerVelocity += 0.03;
        playerY += playerVelocity;

        if (playerY >= 0.5) {
          playerY = 0.5;
          playerVelocity = 0;
          isJumping = false;
        }
      }

      // Move obstacles
      for (var obstacle in obstacles) {
        obstacle.x -= gameSpeed / 100;
      }
      obstacles.removeWhere((o) => o.x < -1.2);

      // Move coins
      for (var coin in coins) {
        coin.x -= gameSpeed / 100;
      }
      coins.removeWhere((c) => c.x < -1.2);

      // Spawn obstacles
      if (obstacles.isEmpty || obstacles.last.x < 0.5) {
        if (Random().nextDouble() < 0.03) {
          obstacles.add(
            Obstacle(x: 1.2, height: Random().nextDouble() * 0.2 + 0.1),
          );
        }
      }

      // Spawn coins
      if (coins.isEmpty || coins.last.x < 0.3) {
        if (Random().nextDouble() < 0.05) {
          coins.add(Coin(x: 1.2, y: Random().nextDouble() * 0.4 - 0.2));
        }
      }

      // Check obstacle collision
      for (var obstacle in obstacles) {
        if (obstacle.x < 0.1 && obstacle.x > -0.1) {
          if (playerY + 0.05 > 0.5 - obstacle.height) {
            _gameOver();
            return;
          }
        }
      }

      // Check coin collision
      for (int i = coins.length - 1; i >= 0; i--) {
        Coin coin = coins[i];
        if (coin.x < 0.1 && coin.x > -0.1) {
          if ((playerY - coin.y).abs() < 0.1) {
            coins.removeAt(i);
            coinsCollected++;
            score += 50;
          }
        }
      }

      // Increase score
      score++;

      // Increase speed
      if (score % 500 == 0 && gameSpeed < 8) {
        gameSpeed += 0.5;
      }
    });
  }

  void _jump() {
    if (!isPlaying) {
      _startGame();
      return;
    }

    if (!isJumping && playerY >= 0.5) {
      setState(() {
        isJumping = true;
        playerVelocity = -0.6;
      });
    }
  }

  void _gameOver() async {
    gameTimer?.cancel();
    setState(() {
      isPlaying = false;
      isGameOver = true;
    });

    try {
      final userId = SessionManager.userId;
      final gameScore = GameScore(
        gameCode: 'super_dash',
        userId: userId,
        score: score,
        timestamp: DateTime.now(),
      );
      await LeaderboardService().submitScore(gameScore);
    } catch (e) {
      debugPrint('Error submitting score: $e');
    }

    if (mounted) {
      GameOverDialog.show(
        context: context,
        score: score,
        gameCode: 'super_dash',
        emoji: '🏃',
        onPlayAgain: _startGame,
        coinsCollected: coinsCollected,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB),
      body: SafeArea(
        child: Column(
          children: [
            // Header — not part of the tap area
            Container(
              padding: EdgeInsets.all(Responsive.spacing(context, 16)),
              color: Colors.white.withOpacity(0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    child: Image.asset(
                      AppImages.back,
                      height: 20.heightMultiplier,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '🏃 Super Dash',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 20),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Column(
                    children: [
                      Text('Score: $score'),
                      Text('🪙 $coinsCollected'),
                    ],
                  ),
                ],
              ),
            ),

            // Game Area — tap here to jump
            Expanded(
              child: GestureDetector(
                onTap: _jump,
                child: Stack(
                  children: [
                    // Sky background
                    Container(color: const Color(0xFF87CEEB)),

                    // Ground strip
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 6,
                        color: const Color(0xFF8B4513),
                      ),
                    ),

                    // Player
                    Align(
                      alignment: Alignment(-0.7, playerY),
                      child: Container(
                        width: Responsive.dimension(context, 50),
                        height: Responsive.dimension(context, 50),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B35),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '🏃',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 30),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Obstacles
                    ...obstacles.map((obstacle) {
                      return Align(
                        alignment: Alignment(obstacle.x, 0.5),
                        child: Container(
                          width: Responsive.dimension(context, 40),
                          height:
                              MediaQuery.of(context).size.height *
                              obstacle.height,
                          color: const Color(0xFF654321),
                        ),
                      );
                    }),

                    // Coins
                    ...coins.map((coin) {
                      return Align(
                        alignment: Alignment(coin.x, coin.y),
                        child: Text(
                          '🪙',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 25),
                          ),
                        ),
                      );
                    }),

                    // Start / tap prompt
                    if (!isPlaying && !isGameOver)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tap to Start!',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 28),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: Responsive.spacing(context, 16)),
                            const Icon(Icons.touch_app, size: 60),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Obstacle {
  double x;
  double height;
  Obstacle({required this.x, required this.height});
}

class Coin {
  double x;
  double y;
  Coin({required this.x, required this.y});
}
