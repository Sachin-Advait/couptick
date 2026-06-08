import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/game_score.dart';
import '../../services/leaderboard_service.dart';
import '../../services/user_service.dart';
import '../../utils/responsive.dart';

class SokobanScreen extends StatefulWidget {
  const SokobanScreen({super.key});

  @override
  State<SokobanScreen> createState() => _SokobanScreenState();
}

class _SokobanScreenState extends State<SokobanScreen> {
  int level = 1;
  int moves = 0;
  List<List<int>> grid = [];
  int playerX = 0;
  int playerY = 0;

  // 0=empty, 1=wall, 2=target, 3=box, 4=box on target, 5=player, 6=player on target
  final Map<int, List<List<int>>> levels = {
    1: [
      [1, 1, 1, 1, 1, 1],
      [1, 0, 0, 0, 0, 1],
      [1, 0, 3, 2, 0, 1],
      [1, 0, 5, 0, 0, 1],
      [1, 0, 0, 0, 0, 1],
      [1, 1, 1, 1, 1, 1],
    ],
    2: [
      [1, 1, 1, 1, 1, 1, 1],
      [1, 0, 0, 0, 0, 0, 1],
      [1, 0, 3, 0, 3, 0, 1],
      [1, 0, 2, 5, 2, 0, 1],
      [1, 0, 0, 0, 0, 0, 1],
      [1, 1, 1, 1, 1, 1, 1],
    ],
  };

  @override
  void initState() {
    super.initState();
    _loadLevel(level);
  }

  void _loadLevel(int lvl) {
    if (!levels.containsKey(lvl)) {
      _gameComplete();
      return;
    }

    grid = levels[lvl]!.map((row) => List<int>.from(row)).toList();
    moves = 0;

    // Find player
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == 5 || grid[i][j] == 6) {
          playerY = i;
          playerX = j;
        }
      }
    }

    setState(() {});
  }

  void _move(int dx, int dy) {
    int newX = playerX + dx;
    int newY = playerY + dy;

    if (newY < 0 || newY >= grid.length || newX < 0 || newX >= grid[0].length)
      return;

    int target = grid[newY][newX];

    // Wall
    if (target == 1) return;

    // Box or box on target
    if (target == 3 || target == 4) {
      int boxNewX = newX + dx;
      int boxNewY = newY + dy;

      if (boxNewY < 0 ||
          boxNewY >= grid.length ||
          boxNewX < 0 ||
          boxNewX >= grid[0].length)
        return;

      int boxTarget = grid[boxNewY][boxNewX];

      // Can't push into wall or another box
      if (boxTarget == 1 || boxTarget == 3 || boxTarget == 4) return;

      // Move box
      setState(() {
        // Remove box from current position
        grid[newY][newX] = (target == 4) ? 2 : 0;

        // Place box in new position
        grid[boxNewY][boxNewX] = (boxTarget == 2) ? 4 : 3;

        // Move player
        grid[playerY][playerX] = (grid[playerY][playerX] == 6) ? 2 : 0;
        grid[newY][newX] = (grid[newY][newX] == 2) ? 6 : 5;

        playerX = newX;
        playerY = newY;
        moves++;
      });
    } else {
      // Move player
      setState(() {
        grid[playerY][playerX] = (grid[playerY][playerX] == 6) ? 2 : 0;
        grid[newY][newX] = (target == 2) ? 6 : 5;

        playerX = newX;
        playerY = newY;
        moves++;
      });
    }

    if (_checkWin()) {
      _levelComplete();
    }
  }

  bool _checkWin() {
    for (var row in grid) {
      for (var cell in row) {
        if (cell == 3) return false; // Unplaced box
        if (cell == 2) return false; // Empty target
      }
    }
    return true;
  }

  void _levelComplete() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Level Complete!'),
        content: Text('Moves: $moves'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                level++;
                _loadLevel(level);
              });
            },
            child: const Text('Next Level'),
          ),
        ],
      ),
    );
  }

  void _gameComplete() async {
    int totalScore = level * 1000 - moves * 10;

    try {
      final userId = SessionManager.userId;
      final gameScore = GameScore(
        gameCode: 'sokoban',
        userId: userId,
        score: totalScore,
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
          title: const Text('🎮 Game Complete!'),
          content: Text('Final Score: $totalScore'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  level = 1;
                  _loadLevel(level);
                });
              },
              child: const Text('Play Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.pushNamed(
                  Routes.leaderboard,
                  extra: {'gameCode': 'sokoban'},
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

  Color _getCellColor(int value) {
    switch (value) {
      case 1:
        return const Color(0xFF654321);
      case 2:
        return const Color(0xFFFFD700).withOpacity(0.3);
      case 3:
        return const Color(0xFF8B4513);
      case 4:
        return const Color(0xFF2E8B57);
      case 5:
        return const Color(0xFFFF6B35);
      case 6:
        return const Color(0xFFFF6B35);
      default:
        return const Color(0xFFF5F5DC);
    }
  }

  String _getCellEmoji(int value) {
    switch (value) {
      case 2:
        return '⭐';
      case 3:
        return '📦';
      case 4:
        return '✅';
      case 5:
        return '🧑';
      case 6:
        return '🧑';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0E68C),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(Responsive.spacing(context, 16)),
              color: Colors.white,
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
                    '📦 Sokoban',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 20),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Column(
                    children: [Text('Level: $level'), Text('Moves: $moves')],
                  ),
                ],
              ),
            ),

            // Game Grid
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: grid.isEmpty ? 1 : grid[0].length / grid.length,
                  child: Container(
                    padding: EdgeInsets.all(Responsive.spacing(context, 16)),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: grid.isEmpty ? 1 : grid[0].length,
                      ),
                      itemCount: grid.isEmpty
                          ? 0
                          : grid.length * grid[0].length,
                      itemBuilder: (context, index) {
                        int i = index ~/ grid[0].length;
                        int j = index % grid[0].length;
                        int value = grid[i][j];

                        return Container(
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: _getCellColor(value),
                            border: Border.all(color: Colors.black26),
                          ),
                          child: Center(
                            child: Text(
                              _getCellEmoji(value),
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 20),
                              ),
                            ),
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
              child: Column(
                children: [
                  IconButton(
                    onPressed: () => _move(0, -1),
                    icon: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B35),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                      ),
                    ),
                    iconSize: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => _move(-1, 0),
                        icon: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B35),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        iconSize: 40,
                      ),
                      SizedBox(width: Responsive.spacing(context, 20)),
                      IconButton(
                        onPressed: () => _loadLevel(level),
                        icon: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.refresh),
                        ),
                        iconSize: 40,
                      ),
                      SizedBox(width: Responsive.spacing(context, 20)),
                      IconButton(
                        onPressed: () => _move(1, 0),
                        icon: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B35),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                        iconSize: 40,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => _move(0, 1),
                    icon: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B35),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_downward,
                        color: Colors.white,
                      ),
                    ),
                    iconSize: 40,
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
