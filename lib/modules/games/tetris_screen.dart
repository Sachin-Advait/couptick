import 'dart:async';
import 'dart:math';

import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/game_score.dart';
import '../../services/leaderboard_service.dart';
import '../../services/user_service.dart';
import '../../utils/responsive.dart';

class TetrisScreen extends StatefulWidget {
  const TetrisScreen({super.key});

  @override
  State<TetrisScreen> createState() => _TetrisScreenState();
}

class _TetrisScreenState extends State<TetrisScreen> {
  static const int rows = 20;
  static const int cols = 10;

  List<List<int>> board = List.generate(rows, (_) => List.filled(cols, 0));
  List<List<int>> currentPiece = [];
  int currentX = 0;
  int currentY = 0;
  int currentColor = 1;

  bool isPlaying = false;
  bool isGameOver = false;
  int score = 0;
  int level = 1;
  int linesCleared = 0;
  Timer? gameTimer;

  final List<List<List<int>>> pieces = [
    // I piece
    [
      [1, 1, 1, 1],
    ],
    // O piece
    [
      [1, 1],
      [1, 1],
    ],
    // T piece
    [
      [0, 1, 0],
      [1, 1, 1],
    ],
    // S piece
    [
      [0, 1, 1],
      [1, 1, 0],
    ],
    // Z piece
    [
      [1, 1, 0],
      [0, 1, 1],
    ],
    // J piece
    [
      [1, 0, 0],
      [1, 1, 1],
    ],
    // L piece
    [
      [0, 0, 1],
      [1, 1, 1],
    ],
  ];

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      board = List.generate(rows, (_) => List.filled(cols, 0));
      score = 0;
      level = 1;
      linesCleared = 0;
      isGameOver = false;
      isPlaying = true;
    });
    _spawnPiece();
    _startTimer();
  }

  void _startTimer() {
    gameTimer?.cancel();
    int speed = max(100, 500 - (level - 1) * 50);
    gameTimer = Timer.periodic(Duration(milliseconds: speed), (timer) {
      if (!isPlaying) return;
      _moveDown();
    });
  }

  void _spawnPiece() {
    Random random = Random();
    int pieceIndex = random.nextInt(pieces.length);
    currentPiece = pieces[pieceIndex]
        .map((row) => List<int>.from(row))
        .toList();
    currentColor = pieceIndex + 1;
    currentX = cols ~/ 2 - currentPiece[0].length ~/ 2;
    currentY = 0;

    if (_checkCollision(currentPiece, currentX, currentY)) {
      _gameOver();
    }
  }

  bool _checkCollision(List<List<int>> piece, int x, int y) {
    for (int i = 0; i < piece.length; i++) {
      for (int j = 0; j < piece[i].length; j++) {
        if (piece[i][j] == 1) {
          int newY = y + i;
          int newX = x + j;

          if (newY < 0) continue;
          if (newX < 0 || newX >= cols || newY >= rows) return true;
          if (board[newY][newX] != 0) return true;
        }
      }
    }
    return false;
  }

  void _mergePiece() {
    for (int i = 0; i < currentPiece.length; i++) {
      for (int j = 0; j < currentPiece[i].length; j++) {
        if (currentPiece[i][j] == 1) {
          int y = currentY + i;
          int x = currentX + j;
          if (y >= 0 && y < rows && x >= 0 && x < cols) {
            board[y][x] = currentColor;
          }
        }
      }
    }
    _clearLines();
    _spawnPiece();
  }

  void _clearLines() {
    int cleared = 0;
    for (int i = rows - 1; i >= 0; i--) {
      if (board[i].every((cell) => cell != 0)) {
        board.removeAt(i);
        board.insert(0, List.filled(cols, 0));
        cleared++;
        i++;
      }
    }

    if (cleared > 0) {
      setState(() {
        linesCleared += cleared;
        score += cleared * 100 * level;
        level = 1 + (linesCleared ~/ 10);
      });
      _startTimer();
    }
  }

  void _moveDown() {
    if (_checkCollision(currentPiece, currentX, currentY + 1)) {
      _mergePiece();
    } else {
      setState(() {
        currentY++;
      });
    }
  }

  void _moveLeft() {
    if (!_checkCollision(currentPiece, currentX - 1, currentY)) {
      setState(() {
        currentX--;
      });
    }
  }

  void _moveRight() {
    if (!_checkCollision(currentPiece, currentX + 1, currentY)) {
      setState(() {
        currentX++;
      });
    }
  }

  void _rotate() {
    List<List<int>> rotated = List.generate(
      currentPiece[0].length,
      (i) => List.generate(
        currentPiece.length,
        (j) => currentPiece[currentPiece.length - 1 - j][i],
      ),
    );

    if (!_checkCollision(rotated, currentX, currentY)) {
      setState(() {
        currentPiece = rotated;
      });
    }
  }

  void _drop() {
    while (!_checkCollision(currentPiece, currentX, currentY + 1)) {
      setState(() {
        currentY++;
      });
    }
    _mergePiece();
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
        gameCode: 'tetris',
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
              'Score: $score',
              style: TextStyle(fontSize: Responsive.fontSize(context, 20)),
            ),
            Text(
              'Level: $level',
              style: TextStyle(fontSize: Responsive.fontSize(context, 16)),
            ),
            Text(
              'Lines: $linesCleared',
              style: TextStyle(fontSize: Responsive.fontSize(context, 16)),
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
                extra: {'gameCode': 'tetris'},
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

  Color _getColorForValue(int value) {
    const colors = [
      Color(0xFF535353),
      Color(0xFF00F0F0),
      Color(0xFFF0F000),
      Color(0xFFA000F0),
      Color(0xFF00F000),
      Color(0xFFF00000),
      Color(0xFF0000F0),
      Color(0xFFF0A000),
    ];
    return colors[value % colors.length];
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
              color: Colors.white.withOpacity(0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    child: Container(
                      padding: EdgeInsets.all(8.widthMultiplier),
                      child: Image.asset(
                        AppImages.back,
                        height: 20.heightMultiplier,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Text(
                    '🎮 Tetris',
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
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Level: $level',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 12),
                          color: const Color(0xFFFFD23F),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Game Board
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: cols / rows,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFFF6B35),
                        width: 2,
                      ),
                    ),
                    child: CustomPaint(
                      painter: TetrisPainter(
                        board: board,
                        currentPiece: currentPiece,
                        currentX: currentX,
                        currentY: currentY,
                        currentColor: currentColor,
                        getColor: _getColorForValue,
                      ),
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
                        child: Text('START GAME', style: context.semiBold),
                      ),
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: _rotate,
                              icon: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF6B35),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.rotate_right,
                                  color: Colors.white,
                                ),
                              ),
                              iconSize: 40,
                            ),
                            SizedBox(width: Responsive.spacing(context, 20)),
                            IconButton(
                              onPressed: _drop,
                              icon: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFD23F),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_downward,
                                  color: Colors.black,
                                ),
                              ),
                              iconSize: 40,
                            ),
                          ],
                        ),
                        SizedBox(height: Responsive.spacing(context, 12)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: _moveLeft,
                              icon: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF6B35),
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
                              onPressed: _moveDown,
                              icon: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF6B35),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                ),
                              ),
                              iconSize: 40,
                            ),
                            SizedBox(width: Responsive.spacing(context, 20)),
                            IconButton(
                              onPressed: _moveRight,
                              icon: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF6B35),
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
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class TetrisPainter extends CustomPainter {
  final List<List<int>> board;
  final List<List<int>> currentPiece;
  final int currentX;
  final int currentY;
  final int currentColor;
  final Color Function(int) getColor;

  TetrisPainter({
    required this.board,
    required this.currentPiece,
    required this.currentX,
    required this.currentY,
    required this.currentColor,
    required this.getColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = size.width / 10;
    final cellHeight = size.height / 20;

    // Draw board
    for (int i = 0; i < 20; i++) {
      for (int j = 0; j < 10; j++) {
        final paint = Paint()
          ..color = getColor(board[i][j])
          ..style = PaintingStyle.fill;

        canvas.drawRect(
          Rect.fromLTWH(
            j * cellWidth,
            i * cellHeight,
            cellWidth - 1,
            cellHeight - 1,
          ),
          paint,
        );
      }
    }

    // Draw current piece
    for (int i = 0; i < currentPiece.length; i++) {
      for (int j = 0; j < currentPiece[i].length; j++) {
        if (currentPiece[i][j] == 1) {
          final paint = Paint()
            ..color = getColor(currentColor)
            ..style = PaintingStyle.fill;

          final x = (currentX + j) * cellWidth;
          final y = (currentY + i) * cellHeight;

          canvas.drawRect(
            Rect.fromLTWH(x, y, cellWidth - 1, cellHeight - 1),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
