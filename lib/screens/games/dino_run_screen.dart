import 'dart:async';
import 'package:consumer_app/routes/app_pages.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/responsive.dart';
import '../../models/game_score.dart';
import '../../services/leaderboard_service.dart';
import '../../services/user_service.dart';

class DinoRunScreen extends StatefulWidget {
  const DinoRunScreen({super.key});

  @override
  State<DinoRunScreen> createState() => _DinoRunScreenState();
}

class _DinoRunScreenState extends State<DinoRunScreen> with SingleTickerProviderStateMixin {
  static const double gravity = 1200;
  static const double jumpVelocity = -600;
  static const double groundLevel = 0.7;
  
  double dinoY = groundLevel;
  double dinoVelocity = 0;
  bool isJumping = false;
  bool isGameStarted = false;
  bool isGameOver = false;
  
  List<Obstacle> obstacles = [];
  int score = 0;
  double gameSpeed = 300;
  Timer? gameTimer;
  DateTime? lastUpdate;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      dinoY = groundLevel;
      dinoVelocity = 0;
      isJumping = false;
      isGameStarted = true;
      isGameOver = false;
      score = 0;
      gameSpeed = 300;
      obstacles.clear();
      lastUpdate = DateTime.now();
    });

    gameTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!isGameStarted || isGameOver) return;
      _updateGame();
    });
  }

  void _updateGame() {
    final now = DateTime.now();
    final dt = lastUpdate != null 
        ? (now.millisecondsSinceEpoch - lastUpdate!.millisecondsSinceEpoch) / 1000.0
        : 0.016;
    lastUpdate = now;

    setState(() {
      // Update dino physics
      if (isJumping || dinoY < groundLevel) {
        dinoVelocity += gravity * dt;
        dinoY += dinoVelocity * dt;
        
        if (dinoY >= groundLevel) {
          dinoY = groundLevel;
          dinoVelocity = 0;
          isJumping = false;
        }
      }

      // Update obstacles
      for (var obstacle in obstacles) {
        obstacle.x -= gameSpeed * dt;
      }
      obstacles.removeWhere((o) => o.x < -0.1);

      // Add new obstacles
      if (obstacles.isEmpty || obstacles.last.x < 0.7) {
        if (Random().nextDouble() < 0.02) {
          obstacles.add(Obstacle(x: 1.1, height: Random().nextDouble() * 0.15 + 0.1));
        }
      }

      // Check collision
      for (var obstacle in obstacles) {
        if (obstacle.x < 0.15 && obstacle.x > 0.05) {
          if (dinoY + 0.1 > groundLevel - obstacle.height) {
            _gameOver();
            return;
          }
        }
      }

      // Update score
      score = (score / 10).floor() * 10 + 1;
      
      // Increase speed
      if (score % 100 == 0 && gameSpeed < 600) {
        gameSpeed += 20;
      }
    });
  }

  void _jump() {
    if (!isGameStarted) {
      _startGame();
      return;
    }
    
    if (!isJumping && dinoY >= groundLevel) {
      setState(() {
        isJumping = true;
        dinoVelocity = jumpVelocity;
      });
    }
  }

  void _gameOver() async {
    gameTimer?.cancel();
    setState(() {
      isGameOver = true;
      isGameStarted = false;
    });

    try {
      final userId = await UserService().getUserId();
      final gameScore = GameScore(
        gameCode: 'dino_run',
        userId: userId,
        score: score,
        timestamp: DateTime.now(),
      );
      await LeaderboardService().submitScore(gameScore);
    } catch (e) {
      print('Error submitting score: $e');
    }

    if (mounted) {
      _showGameOverDialog();
    }
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('🦖 Game Over!', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score',
              style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
            ),
            Text(
              '$score',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 32),
                fontWeight: FontWeight.w800,
                color: const Color(0xFFFF6B35),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _startGame();
            },
            child: const Text('Play Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pushNamed(Routes.leaderboard, extra: {'gameCode': 'dino_run'});
            },
            child: const Text('Leaderboard'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: GestureDetector(
          onTap: _jump,
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(Responsive.spacing(context, 16)),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Text(
                      '🦖 Dino Run',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 20),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Score: $score',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 18),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFFF6B35),
                      ),
                    ),
                  ],
                ),
              ),

              // Game Area
              Expanded(
                child: Stack(
                  children: [
                    // Ground
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * (1 - groundLevel),
                        color: const Color(0xFF535353),
                      ),
                    ),

                    // Dino
                    Align(
                      alignment: Alignment(
                        -0.8,
                        (dinoY - groundLevel) * 4,
                      ),
                      child: Container(
                        width: Responsive.dimension(context, 50),
                        height: Responsive.dimension(context, 50),
                        decoration: BoxDecoration(
                          color: const Color(0xFF43e97b),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '🦖',
                            style: TextStyle(fontSize: Responsive.fontSize(context, 30)),
                          ),
                        ),
                      ),
                    ),

                    // Obstacles
                    ...obstacles.map((obstacle) {
                      return Align(
                        alignment: Alignment(
                          (obstacle.x - 0.5) * 2,
                          1.0,
                        ),
                        child: Container(
                          width: Responsive.dimension(context, 30),
                          height: MediaQuery.of(context).size.height * obstacle.height,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B35),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    }),

                    // Start Message
                    if (!isGameStarted && !isGameOver)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tap to Jump!',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 28),
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF1A1A2E),
                              ),
                            ),
                            SizedBox(height: Responsive.spacing(context, 16)),
                            Icon(
                              Icons.touch_app,
                              size: Responsive.iconSize(context, 60),
                              color: const Color(0xFFFF6B35),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Instructions
              Container(
                padding: EdgeInsets.all(Responsive.spacing(context, 16)),
                color: Colors.white,
                child: Text(
                  'Tap anywhere to jump over obstacles!',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    color: const Color(0xFF6B7280),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
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