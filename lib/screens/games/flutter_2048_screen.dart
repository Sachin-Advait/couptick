import 'dart:math';
import 'package:couptick/routes/app_pages.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/game_score.dart';
import '../../services/leaderboard_service.dart';
import '../../services/user_service.dart';
import '../../utils/responsive.dart';

class Flutter2048Screen extends StatefulWidget {
  const Flutter2048Screen({super.key});

  @override
  State<Flutter2048Screen> createState() => _Flutter2048ScreenState();
}

class _Flutter2048ScreenState extends State<Flutter2048Screen> {
  static const int gridSize = 4;
  List<List<int>> grid = [];
  int score = 0;
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  void _initGame() {
    grid = List.generate(gridSize, (_) => List.filled(gridSize, 0));
    score = 0;
    isGameOver = false;
    _addNewTile();
    _addNewTile();
    setState(() {});
  }

  void _addNewTile() {
    List<Point<int>> emptyCells = [];
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (grid[i][j] == 0) {
          emptyCells.add(Point(i, j));
        }
      }
    }

    if (emptyCells.isEmpty) return;

    Point<int> randomCell = emptyCells[Random().nextInt(emptyCells.length)];
    grid[randomCell.x][randomCell.y] = Random().nextInt(10) < 9 ? 2 : 4;
  }

  void _move(String direction) {
    if (isGameOver) return;

    bool moved = false;

    switch (direction) {
      case 'left':
        moved = _moveLeft();
        break;
      case 'right':
        moved = _moveRight();
        break;
      case 'up':
        moved = _moveUp();
        break;
      case 'down':
        moved = _moveDown();
        break;
    }

    if (moved) {
      _addNewTile();
      if (_checkGameOver()) {
        _gameOver();
      }
      setState(() {});
    }
  }

  bool _moveLeft() {
    bool moved = false;
    for (int i = 0; i < gridSize; i++) {
      List<int> row = grid[i].where((val) => val != 0).toList();
      for (int j = 0; j < row.length - 1; j++) {
        if (row[j] == row[j + 1]) {
          row[j] *= 2;
          score += row[j];
          row.removeAt(j + 1);
          moved = true;
        }
      }
      while (row.length < gridSize) {
        row.add(0);
      }
      if (grid[i].toString() != row.toString()) moved = true;
      grid[i] = row;
    }
    return moved;
  }

  bool _moveRight() {
    bool moved = false;
    for (int i = 0; i < gridSize; i++) {
      List<int> row = grid[i].where((val) => val != 0).toList();
      for (int j = row.length - 1; j > 0; j--) {
        if (row[j] == row[j - 1]) {
          row[j] *= 2;
          score += row[j];
          row.removeAt(j - 1);
          moved = true;
          j--;
        }
      }
      while (row.length < gridSize) {
        row.insert(0, 0);
      }
      if (grid[i].toString() != row.toString()) moved = true;
      grid[i] = row;
    }
    return moved;
  }

  bool _moveUp() {
    bool moved = false;
    for (int j = 0; j < gridSize; j++) {
      List<int> column = [];
      for (int i = 0; i < gridSize; i++) {
        if (grid[i][j] != 0) column.add(grid[i][j]);
      }
      for (int i = 0; i < column.length - 1; i++) {
        if (column[i] == column[i + 1]) {
          column[i] *= 2;
          score += column[i];
          column.removeAt(i + 1);
          moved = true;
        }
      }
      while (column.length < gridSize) {
        column.add(0);
      }
      for (int i = 0; i < gridSize; i++) {
        if (grid[i][j] != column[i]) moved = true;
        grid[i][j] = column[i];
      }
    }
    return moved;
  }

  bool _moveDown() {
    bool moved = false;
    for (int j = 0; j < gridSize; j++) {
      List<int> column = [];
      for (int i = 0; i < gridSize; i++) {
        if (grid[i][j] != 0) column.add(grid[i][j]);
      }
      for (int i = column.length - 1; i > 0; i--) {
        if (column[i] == column[i - 1]) {
          column[i] *= 2;
          score += column[i];
          column.removeAt(i - 1);
          moved = true;
          i--;
        }
      }
      while (column.length < gridSize) {
        column.insert(0, 0);
      }
      for (int i = 0; i < gridSize; i++) {
        if (grid[i][j] != column[i]) moved = true;
        grid[i][j] = column[i];
      }
    }
    return moved;
  }

  bool _checkGameOver() {
    // Check for empty cells
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (grid[i][j] == 0) return false;
      }
    }

    // Check for possible merges
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (j < gridSize - 1 && grid[i][j] == grid[i][j + 1]) return false;
        if (i < gridSize - 1 && grid[i][j] == grid[i + 1][j]) return false;
      }
    }

    return true;
  }

  void _gameOver() async {
    setState(() {
      isGameOver = true;
    });

    // Submit score to leaderboard
    try {
      final userId = SessionManager.userId;
      final gameScore = GameScore(
        gameCode: 'flutter_2048',
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
        title: const Text('🎮 Game Over!', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Final Score',
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
              _initGame();
            },
            child: const Text('Play Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pushNamed(Routes.leaderboard, extra: {'gameCode': 'flutter_2048'},
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

  Color _getTileColor(int value) {
    switch (value) {
      case 2:
        return const Color(0xFFEEE4DA);
      case 4:
        return const Color(0xFFEDE0C8);
      case 8:
        return const Color(0xFFF2B179);
      case 16:
        return const Color(0xFFF59563);
      case 32:
        return const Color(0xFFF67C5F);
      case 64:
        return const Color(0xFFF65E3B);
      case 128:
        return const Color(0xFFEDCF72);
      case 256:
        return const Color(0xFFEDCC61);
      case 512:
        return const Color(0xFFEDC850);
      case 1024:
        return const Color(0xFFEDC53F);
      case 2048:
        return const Color(0xFFEDC22E);
      default:
        return const Color(0xFFCDC1B4);
    }
  }

  Color _getTextColor(int value) {
    return value <= 4 ? const Color(0xFF776E65) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8EF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(Responsive.spacing(context, 16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Text(
                    '2048',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 32),
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF776E65),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'SCORE',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 12),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF776E65),
                        ),
                      ),
                      Text(
                        '$score',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 20),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFFF6B35),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // New Game Button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.spacing(context, 16),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _initGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8F7A66),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'New Game',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: Responsive.spacing(context, 20)),

            // Game Grid
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(Responsive.spacing(context, 16)),
                    child: GestureDetector(
                      onVerticalDragEnd: (details) {
                        if (details.primaryVelocity! < 0) {
                          _move('up');
                        } else if (details.primaryVelocity! > 0) {
                          _move('down');
                        }
                      },
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity! < 0) {
                          _move('left');
                        } else if (details.primaryVelocity! > 0) {
                          _move('right');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFBBADA0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(Responsive.spacing(context, 8)),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: gridSize,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                          itemCount: gridSize * gridSize,
                          itemBuilder: (context, index) {
                            int i = index ~/ gridSize;
                            int j = index % gridSize;
                            int value = grid[i][j];

                            return Container(
                              decoration: BoxDecoration(
                                color: _getTileColor(value),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: value > 0
                                    ? Text(
                                        '$value',
                                        style: TextStyle(
                                          fontSize: value < 100
                                              ? Responsive.fontSize(context, 32)
                                              : value < 1000
                                              ? Responsive.fontSize(context, 24)
                                              : Responsive.fontSize(
                                                  context,
                                                  20,
                                                ),
                                          fontWeight: FontWeight.w800,
                                          color: _getTextColor(value),
                                        ),
                                      )
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Controls
            Padding(
              padding: EdgeInsets.all(Responsive.spacing(context, 20)),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () => _move('up'),
                    icon: Container(
                      padding: EdgeInsets.all(Responsive.spacing(context, 12)),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8F7A66),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                      ),
                    ),
                    iconSize: Responsive.iconSize(context, 40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => _move('left'),
                        icon: Container(
                          padding: EdgeInsets.all(
                            Responsive.spacing(context, 12),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8F7A66),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        iconSize: Responsive.iconSize(context, 40),
                      ),
                      SizedBox(width: Responsive.spacing(context, 80)),
                      IconButton(
                        onPressed: () => _move('right'),
                        icon: Container(
                          padding: EdgeInsets.all(
                            Responsive.spacing(context, 12),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8F7A66),
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
                  IconButton(
                    onPressed: () => _move('down'),
                    icon: Container(
                      padding: EdgeInsets.all(Responsive.spacing(context, 12)),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8F7A66),
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
