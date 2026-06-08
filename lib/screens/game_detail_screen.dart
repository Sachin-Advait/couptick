import 'package:flutter/material.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:go_router/go_router.dart';

import '../utils/responsive.dart';

class GameDetailScreen extends StatelessWidget {
  final String gameTitle;

  const GameDetailScreen({super.key, this.gameTitle = 'Game'});

  @override
  Widget build(BuildContext context) {
    final String title = gameTitle;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(Responsive.spacing(context, 16)),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: Responsive.spacing(context, 8)),
                  Text(
                    gameTitle,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 20),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                children: [
                  // Preview
                  Container(
                    height: Responsive.dimension(context, 200),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        '🎮',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 80),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 20)),

                  // Description
                  Text(
                    'Endless runner game with stunning graphics and smooth controls. Jump, slide, and collect coins!',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      color: const Color(0xFF6B7280),
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 24)),

                  // Stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(context, '2100', 'Best Score'),
                      ),
                      SizedBox(width: Responsive.spacing(context, 12)),
                      Expanded(
                        child: _buildStatCard(context, '2-5 min', 'Avg Time'),
                      ),
                      SizedBox(width: Responsive.spacing(context, 12)),
                      Expanded(
                        child: _buildStatCard(context, 'Arcade', 'Category'),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.spacing(context, 24)),

                  // Buttons
                  SizedBox(
                    width: double.infinity,
                    height: Responsive.dimension(context, 52),
                    child: ElevatedButton(
                      onPressed: () {
                        final gameRoutes = {
                          'Snake': Routes.gameSnake,
                          'Flutter 2048': Routes.game2048,
                          'Super Dash': Routes.gameSnake,
                          'Tetris': Routes.game2048,
                        };

                        final route = gameRoutes[title] ?? Routes.gameSnake;
                        context.push(route);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        '▶️ PLAY NOW',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 16),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 12)),
                  OutlinedButton(
                    onPressed: () {
                      context.push(
                        '/leaderboard',
                        extra: {
                          'gameCode': title.toLowerCase().replaceAll(' ', '_'),
                        },
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFFF6B35),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: Responsive.spacing(context, 14),
                      ),
                    ),
                    child: Text(
                      'VIEW LEADERBOARD',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 15),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFFF6B35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label) {
    return Container(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A1A2E),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Responsive.spacing(context, 4)),
          Text(
            label,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 11),
              color: const Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
