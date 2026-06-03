import 'package:flutter/material.dart';
import 'package:consumer_app/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import '../utils/responsive.dart';

class GamesHubScreen extends StatefulWidget {
  const GamesHubScreen({super.key});

  @override
  State<GamesHubScreen> createState() => _GamesHubScreenState();
}

class _GamesHubScreenState extends State<GamesHubScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(Responsive.spacing(context, 16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Free Games',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 28),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.spacing(context, 8)),
                  Text(
                    'Relax & Play',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 16)),

                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('All'),
                        SizedBox(width: Responsive.spacing(context, 8)),
                        _buildFilterChip('Arcade'),
                        SizedBox(width: Responsive.spacing(context, 8)),
                        _buildFilterChip('Puzzle'),
                        SizedBox(width: Responsive.spacing(context, 8)),
                        _buildFilterChip('Classic'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Games Grid
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(Responsive.spacing(context, 16)),
                children: [
                  // Featured Section
                  Text(
                    'Featured',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 20),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 12)),
                  SizedBox(
                    height: Responsive.dimension(context, 200),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildFeaturedCard(
                          context,
                          'Super Dash',
                          'Arcade',
                          '4.8',
                          '2100',
                          const LinearGradient(
                            colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                          ),
                          route: '/game-dash',
                        ),
                        _buildFeaturedCard(
                          context,
                          'Tetris',
                          'Puzzle',
                          '4.9',
                          '1540',
                          const LinearGradient(
                            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                          ),
                          route: '/game-tetris',
                        ),
                        _buildFeaturedCard(
                          context,
                          'Brick Breaker',
                          'Arcade',
                          '4.7',
                          '890',
                          const LinearGradient(
                            colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
                          ),
                          route: '/game-brick',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 24)),

                  // All Games
                  Text(
                    'All Games',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 20),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 12)),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: Responsive.spacing(context, 12),
                    mainAxisSpacing: Responsive.spacing(context, 12),
                    childAspectRatio: 0.85,
                    children: [
                      _buildGameCard(
                        '🏃',
                        'Super Dash',
                        'Arcade',
                        '4.8',
                        '2100',
                        route: '/game-dash',
                      ),
                      _buildGameCard(
                        '2️⃣',
                        'Flutter 2048',
                        'Puzzle',
                        '4.9',
                        '1540',
                        route: '/game-2048',
                      ),
                      _buildGameCard(
                        '🐍',
                        'Snake',
                        'Classic',
                        '4.7',
                        '890',
                        route: '/game-snake',
                      ),
                      _buildGameCard(
                        '🧱',
                        'Brick Breaker',
                        'Arcade',
                        '4.6',
                        '1200',
                        route: '/game-brick',
                      ),
                      _buildGameCard(
                        '🦖',
                        'Dino Run',
                        'Arcade',
                        '4.5',
                        '760',
                        route: '/game-dino',
                      ),
                      _buildGameCard(
                        '🎮',
                        'Tetris',
                        'Puzzle',
                        '4.9',
                        '3240',
                        route: '/game-tetris',
                      ),
                      _buildGameCard(
                        '📦',
                        'Sokoban',
                        'Puzzle',
                        '4.8',
                        '980',
                        route: '/game-sokoban',
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

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.spacing(context, 16),
          vertical: Responsive.spacing(context, 8),
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF6B35) : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCard(
    BuildContext context,
    String title,
    String category,
    String rating,
    String bestScore,
    Gradient gradient, {
    String? route,
  }) {
    return GestureDetector(
      onTap: () {
      if (route != null) {
        context.push(route);
      } else {
        context.pushNamed(Routes.gameDetail, extra: {'title': title});
      }
    },
      child: Container(
        width: Responsive.dimension(context, 280),
        margin: EdgeInsets.only(right: Responsive.spacing(context, 12)),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(Responsive.spacing(context, 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 24),
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            SizedBox(height: Responsive.spacing(context, 8)),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.spacing(context, 8),
                    vertical: Responsive.spacing(context, 4),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: Responsive.spacing(context, 8)),
                Text(
                  '⭐ $rating',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  'Best: $bestScore',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 13),
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
            SizedBox(height: Responsive.spacing(context, 12)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.pushNamed(Routes.gameDetail, extra: {'title': title},
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFFF6B35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'PLAY NOW',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(
    String emoji,
    String title,
    String category,
    String rating,
    String bestScore, {
    String? route,
  }) {
    return GestureDetector(
      onTap: () => context.pushNamed(Routes.gameDetail, extra: {'title': title},
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Responsive.dimension(context, 100),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  emoji,
                  style: TextStyle(fontSize: Responsive.fontSize(context, 50)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Responsive.spacing(context, 12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 16),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Responsive.spacing(context, 4)),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 8)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '⭐ $rating',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 12),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Best: $bestScore',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 11),
                          color: const Color(0xFF6B7280),
                        ),
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
