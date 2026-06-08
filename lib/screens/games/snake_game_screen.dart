import 'dart:async';
import 'dart:math';

import 'package:couptick/routes/app_pages.dart';
import 'package:couptick/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/game_score.dart';
import '../../services/leaderboard_service.dart';
import '../../utils/responsive.dart';

class SnakeGameScreen extends StatefulWidget {
  const SnakeGameScreen({super.key});

  @override
  State<SnakeGameScreen> createState() => _SnakeGameScreenState();
}

class _SnakeGameScreenState extends State<SnakeGameScreen> {
  static const int gridSize = 20;
  static const int initialSpeed = 300;

  List<Point<int>> snake = [const Point(10, 10)];
  Point<int> food = const Point(15, 15);
  String direction = 'right';
  String nextDirection = 'right';
  bool isPlaying = false;
  bool isGameOver = false;
  int score = 0;
  Timer? gameTimer;

  @override
  void initState() {
    super.initState();
    _generateFood();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      snake = [const Point(10, 10)];
      direction = 'right';
      nextDirection = 'right';
      score = 0;
      isGameOver = false;
      isPlaying = true;
    });
    _generateFood();
    _runGame();
  }

  void _runGame() {
    gameTimer?.cancel();
    gameTimer = Timer.periodic(
      Duration(milliseconds: max(100, initialSpeed - score * 5)),
      (timer) {
        if (!isPlaying) return;

        setState(() {
          direction = nextDirection;
          Point<int> newHead = _getNewHead();

          // Check collision with walls or self
          if (newHead.x < 0 ||
              newHead.x >= gridSize ||
              newHead.y < 0 ||
              newHead.y >= gridSize ||
              snake.contains(newHead)) {
            _gameOver();
            return;
          }

          snake.insert(0, newHead);

          // Check if food is eaten
          if (newHead == food) {
            score += 10;
            _generateFood();
            // Restart timer with new speed
            timer.cancel();
            _runGame();
          } else {
            snake.removeLast();
          }
        });
      },
    );
  }

  Point<int> _getNewHead() {
    Point<int> head = snake.first;
    switch (direction) {
      case 'up':
        return Point(head.x, head.y - 1);
      case 'down':
        return Point(head.x, head.y + 1);
      case 'left':
        return Point(head.x - 1, head.y);
      case 'right':
        return Point(head.x + 1, head.y);
      default:
        return head;
    }
  }

  void _generateFood() {
    Random random = Random();
    Point<int> newFood;
    do {
      newFood = Point(random.nextInt(gridSize), random.nextInt(gridSize));
    } while (snake.contains(newFood));

    setState(() {
      food = newFood;
    });
  }

  void _changeDirection(String newDirection) {
    // Prevent 180-degree turns
    if ((direction == 'up' && newDirection == 'down') ||
        (direction == 'down' && newDirection == 'up') ||
        (direction == 'left' && newDirection == 'right') ||
        (direction == 'right' && newDirection == 'left')) {
      return;
    }
    nextDirection = newDirection;
  }

  void _gameOver() async {
    gameTimer?.cancel();
    setState(() {
      isPlaying = false;
      isGameOver = true;
    });

    // Submit score to leaderboard
    try {
      final userId = SessionManager.userId;
      final gameScore = GameScore(
        gameCode: 'snake',
        userId: userId,
        score: score,
        timestamp: DateTime.now(),
      );
      await LeaderboardService().submitScore(gameScore);
    } catch (e) {
      print('Error submitting score: $e');
    }

    // Show game over dialog
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
        title: const Text('🎮 Game Over!', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: $score',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 24),
                fontWeight: FontWeight.w800,
                color: const Color(0xFFFF6B35),
              ),
            ),
            SizedBox(height: Responsive.spacing(context, 8)),
            Text(
              'Snake Length: ${snake.length}',
              style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
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
              context.pushNamed(
                Routes.leaderboard,
                extra: {'gameCode': 'snake'},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(Responsive.spacing(context, 16)),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.05)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Text(
                    '🐍 Snake',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 20),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Score: $score',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 18),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFD23F),
                    ),
                  ),
                ],
              ),
            ),

            // Game Board
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      border: Border.all(
                        color: const Color(0xFFFF6B35),
                        width: 2,
                      ),
                    ),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: gridSize,
                          ),
                      itemCount: gridSize * gridSize,
                      itemBuilder: (context, index) {
                        int x = index % gridSize;
                        int y = index ~/ gridSize;
                        Point<int> currentPoint = Point(x, y);

                        bool isSnake = snake.contains(currentPoint);
                        bool isHead = snake.first == currentPoint;
                        bool isFood = food == currentPoint;

                        return Container(
                          margin: const EdgeInsets.all(0.5),
                          decoration: BoxDecoration(
                            color: isHead
                                ? const Color(0xFFFF6B35)
                                : isSnake
                                ? const Color(0xFF43e97b)
                                : isFood
                                ? const Color(0xFFFFD23F)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(isFood ? 4 : 2),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Controls
            Container(
              padding: EdgeInsets.all(Responsive.spacing(context, 20)),
              child: !isPlaying && !isGameOver
                  ? SizedBox(
                      width: double.infinity,
                      height: Responsive.dimension(context, 56),
                      child: ElevatedButton(
                        onPressed: _startGame,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          '▶️ START GAME',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 16),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        // Up
                        IconButton(
                          onPressed: () => _changeDirection('up'),
                          icon: Container(
                            padding: EdgeInsets.all(
                              Responsive.spacing(context, 12),
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6B35),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                            ),
                          ),
                          iconSize: Responsive.iconSize(context, 40),
                        ),
                        SizedBox(height: Responsive.spacing(context, 8)),
                        // Left, Pause, Right
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => _changeDirection('left'),
                              icon: Container(
                                padding: EdgeInsets.all(
                                  Responsive.spacing(context, 12),
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF6B35),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                              iconSize: Responsive.iconSize(context, 40),
                            ),
                            SizedBox(width: Responsive.spacing(context, 20)),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (isPlaying) {
                                    gameTimer?.cancel();
                                    isPlaying = false;
                                  } else {
                                    isPlaying = true;
                                    _runGame();
                                  }
                                });
                              },
                              icon: Container(
                                padding: EdgeInsets.all(
                                  Responsive.spacing(context, 12),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                ),
                              ),
                              iconSize: Responsive.iconSize(context, 40),
                            ),
                            SizedBox(width: Responsive.spacing(context, 20)),
                            IconButton(
                              onPressed: () => _changeDirection('right'),
                              icon: Container(
                                padding: EdgeInsets.all(
                                  Responsive.spacing(context, 12),
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF6B35),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                              iconSize: Responsive.iconSize(context, 40),
                            ),
                          ],
                        ),
                        SizedBox(height: Responsive.spacing(context, 8)),
                        // Down
                        IconButton(
                          onPressed: () => _changeDirection('down'),
                          icon: Container(
                            padding: EdgeInsets.all(
                              Responsive.spacing(context, 12),
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6B35),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                          ),
                          iconSize: Responsive.iconSize(context, 40),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
