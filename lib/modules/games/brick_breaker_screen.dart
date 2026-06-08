import 'dart:async';

import 'package:couptick/routes/app_pages.dart';
import 'package:couptick/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/game_score.dart';
import '../../services/leaderboard_service.dart';
import '../../utils/responsive.dart';

class BrickBreakerScreen extends StatefulWidget {
  const BrickBreakerScreen({super.key});

  @override
  State<BrickBreakerScreen> createState() => _BrickBreakerScreenState();
}

class _BrickBreakerScreenState extends State<BrickBreakerScreen> {
  double ballX = 0;
  double ballY = 0;
  double ballVX = 0;
  double ballVY = 0;
  double paddleX = 0;

  List<Brick> bricks = [];
  bool isPlaying = false;
  bool isGameOver = false;
  int score = 0;
  int lives = 3;
  Timer? gameTimer;

  @override
  void initState() {
    super.initState();
    _resetBall();
    _createBricks();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  void _createBricks() {
    bricks.clear();
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 8; j++) {
        bricks.add(
          Brick(
            x: -0.9 + j * 0.225,
            y: -0.9 + i * 0.1,
            color: Color.fromARGB(255, 50 + i * 40, 100 + j * 20, 200 - i * 30),
          ),
        );
      }
    }
  }

  void _resetBall() {
    ballX = 0;
    ballY = 0.5;
    ballVX = 0.01;
    ballVY = -0.02;
  }

  void _startGame() {
    setState(() {
      isPlaying = true;
      isGameOver = false;
      score = 0;
      lives = 3;
      _createBricks();
      _resetBall();
    });

    gameTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!isPlaying) return;
      _updateGame();
    });
  }

  void _updateGame() {
    setState(() {
      ballX += ballVX;
      ballY += ballVY;

      // Wall collision
      if (ballX <= -1 || ballX >= 1) {
        ballVX = -ballVX;
      }
      if (ballY <= -1) {
        ballVY = -ballVY;
      }

      // Paddle collision
      if (ballY >= 0.8 && ballY <= 0.85) {
        if (ballX >= paddleX - 0.15 && ballX <= paddleX + 0.15) {
          ballVY = -ballVY;
          double hitPos = (ballX - paddleX) / 0.15;
          ballVX = hitPos * 0.02;
        }
      }

      // Brick collision
      for (int i = bricks.length - 1; i >= 0; i--) {
        Brick brick = bricks[i];
        if (ballX >= brick.x - 0.1 &&
            ballX <= brick.x + 0.1 &&
            ballY >= brick.y - 0.045 &&
            ballY <= brick.y + 0.045) {
          bricks.removeAt(i);
          ballVY = -ballVY;
          score += 10;

          if (bricks.isEmpty) {
            _levelComplete();
          }
          break;
        }
      }

      // Ball out of bounds
      if (ballY > 1) {
        lives--;
        if (lives <= 0) {
          _gameOver();
        } else {
          _resetBall();
        }
      }
    });
  }

  void _levelComplete() {
    gameTimer?.cancel();
    setState(() {
      isPlaying = false;
      score += 100;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Level Complete!'),
        content: Text('Score: $score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _createBricks();
              _resetBall();
              _startGame();
            },
            child: const Text('Next Level'),
          ),
        ],
      ),
    );
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
        gameCode: 'brick_breaker',
        userId: userId,
        score: score,
        timestamp: DateTime.now(),
      );
      await LeaderboardService().submitScore(gameScore);
    } catch (e) {
      print('Error submitting score: $e');
    }

    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('🎮 Game Over!'),
          content: Text('Final Score: $score'),
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
                context.pushNamed(
                  Routes.leaderboard,
                  extra: {'gameCode': 'brick_breaker'},
                );
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            setState(() {
              paddleX +=
                  details.delta.dx / (MediaQuery.of(context).size.width / 2);
              paddleX = paddleX.clamp(-0.85, 0.85);
            });
          },
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(Responsive.spacing(context, 16)),
                color: Colors.white.withOpacity(0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Text(
                      '🧱 Brick Breaker',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 20),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          'Score: $score',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Lives: $lives',
                          style: const TextStyle(color: Color(0xFFFFD23F)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Game Area
              Expanded(
                child: Stack(
                  children: [
                    // Bricks
                    ...bricks.map((brick) {
                      return Align(
                        alignment: Alignment(brick.x, brick.y),
                        child: Container(
                          width: Responsive.dimension(context, 40),
                          height: Responsive.dimension(context, 20),
                          decoration: BoxDecoration(
                            color: brick.color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    }),

                    // Ball
                    Align(
                      alignment: Alignment(ballX, ballY),
                      child: Container(
                        width: Responsive.dimension(context, 15),
                        height: Responsive.dimension(context, 15),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF6B35),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    // Paddle
                    Align(
                      alignment: Alignment(paddleX, 0.9),
                      child: Container(
                        width: Responsive.dimension(context, 80),
                        height: Responsive.dimension(context, 15),
                        decoration: BoxDecoration(
                          color: const Color(0xFF43e97b),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    // Start Message
                    if (!isPlaying && !isGameOver)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Slide to Move Paddle',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 20),
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: Responsive.spacing(context, 20)),
                            ElevatedButton(
                              onPressed: _startGame,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF6B35),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 16,
                                ),
                              ),
                              child: const Text(
                                'START GAME',
                                style: TextStyle(fontSize: 16),
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
      ),
    );
  }
}

class Brick {
  double x;
  double y;
  Color color;

  Brick({required this.x, required this.y, required this.color});
}
