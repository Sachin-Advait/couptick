import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GamesHubScreen extends StatefulWidget {
  const GamesHubScreen({super.key});

  @override
  State<GamesHubScreen> createState() => _GamesHubScreenState();
}

class _GamesHubScreenState extends State<GamesHubScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Arcade', 'Puzzle', 'Classic'];

  final List<Map<String, dynamic>> _featured = [
    {
      'title': 'Super Dash',
      'category': 'Arcade',
      'rating': '4.8',
      'score': '2100',
      'color': AppColors.secondary,
      'route': Routes.gameDash,
    },
    {
      'title': 'Tetris',
      'category': 'Puzzle',
      'rating': '4.9',
      'score': '1540',
      'color': AppColors.primary,
      'route': Routes.gameTetris,
    },
    {
      'title': 'Brick Breaker',
      'category': 'Arcade',
      'rating': '4.7',
      'score': '890',
      'color': AppColors.success,
      'route': Routes.gameBrick,
    },
  ];

  final List<Map<String, dynamic>> _allGames = [
    {
      'emoji': '🏃',
      'title': 'Super Dash',
      'category': 'Arcade',
      'rating': '4.8',
      'score': '2100',
      'route': Routes.gameDash,
    },
    {
      'emoji': '2️⃣',
      'title': 'Flutter 2048',
      'category': 'Puzzle',
      'rating': '4.9',
      'score': '1540',
      'route': Routes.game2048,
    },
    {
      'emoji': '🐍',
      'title': 'Snake',
      'category': 'Classic',
      'rating': '4.7',
      'score': '890',
      'route': Routes.gameSnake,
    },
    {
      'emoji': '🧱',
      'title': 'Brick Breaker',
      'category': 'Arcade',
      'rating': '4.6',
      'score': '1200',
      'route': Routes.gameBrick,
    },
    {
      'emoji': '🦖',
      'title': 'Dino Run',
      'category': 'Arcade',
      'rating': '4.5',
      'score': '760',
      'route': Routes.gameDino,
    },
    {
      'emoji': '🎮',
      'title': 'Tetris',
      'category': 'Puzzle',
      'rating': '4.9',
      'score': '3240',
      'route': Routes.gameTetris,
    },
    {
      'emoji': '📦',
      'title': 'Sokoban',
      'category': 'Puzzle',
      'rating': '4.8',
      'score': '980',
      'route': Routes.gameSokoban,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedFilter == 'All'
        ? _allGames
        : _allGames.where((g) => g['category'] == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                20.verticalSpace,
                _buildSectionLabel(context, 'Featured'),
                10.verticalSpace,
                SizedBox(
                  height: 140.heightMultiplier,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: _featured.length,
                    separatorBuilder: (context, index) => 15.horizontalSpace,
                    itemBuilder: (_, i) =>
                        _buildFeaturedCard(context, _featured[i]),
                  ),
                ),
                20.verticalSpace,
                _buildSectionLabel(context, 'All Games'),
                10.verticalSpace,
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.widthMultiplier),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.widthMultiplier,
                    mainAxisSpacing: 12.heightMultiplier,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (_, i) => _buildGameCard(context, filtered[i]),
                ),
                100.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 20.widthMultiplier,
        right: 20.widthMultiplier,
        bottom: 16.heightMultiplier,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Games',
                style: context.extraBold.copyWith(
                  fontSize: 22.textMultiplier,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 40.widthMultiplier,
                  height: 40.widthMultiplier,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12.radiusMultipier),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.widthMultiplier),
                    child: Image.asset(
                      AppImages.search,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.heightMultiplier),
          Text(
            'Relax & Play',
            style: context.regular.copyWith(
              fontSize: 13.textMultiplier,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 16.heightMultiplier),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _filters.map((f) {
                final selected = _selectedFilter == f;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = f),
                  child: Container(
                    margin: EdgeInsets.only(right: 8.widthMultiplier),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.widthMultiplier,
                      vertical: 8.heightMultiplier,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(20.radiusMultipier),
                    ),
                    child: Text(
                      f,
                      style: context.semiBold.copyWith(
                        fontSize: 13.textMultiplier,
                        color: selected
                            ? AppColors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.widthMultiplier),
      child: Text(
        label,
        style: context.bold.copyWith(
          fontSize: 16.textMultiplier,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildFeaturedCard(BuildContext context, Map<String, dynamic> game) {
    final color = game['color'] as Color;
    return GestureDetector(
      onTap: () => context.push(game['route']),
      child: Container(
        width: 240.widthMultiplier,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.radiusMultipier),
        ),
        padding: EdgeInsets.all(15.widthMultiplier),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              game['title'],
              style: context.bold.copyWith(
                fontSize: 20.textMultiplier,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 8.heightMultiplier),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.widthMultiplier,
                    vertical: 4.heightMultiplier,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.radiusMultipier),
                  ),
                  child: Text(
                    game['category'],
                    style: context.medium.copyWith(
                      fontSize: 11.textMultiplier,
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8.widthMultiplier),
                Text(
                  '⭐ ${game['rating']}',
                  style: context.semiBold.copyWith(
                    fontSize: 12.textMultiplier,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.heightMultiplier),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.heightMultiplier),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.radiusMultipier),
              ),
              child: Center(
                child: Text(
                  'PLAY NOW',
                  style: context.bold.copyWith(
                    fontSize: 13.textMultiplier,
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(BuildContext context, Map<String, dynamic> game) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        Routes.gameDetail,
        extra: {'title': game['title'], 'route': game['route']},
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.radiusMultipier),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90.heightMultiplier,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.radiusMultipier),
                ),
              ),
              child: Center(
                child: Text(
                  game['emoji'],
                  style: TextStyle(fontSize: 44.textMultiplier),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.widthMultiplier),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game['title'],
                    style: context.semiBold.copyWith(
                      fontSize: 14.textMultiplier,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.heightMultiplier),
                  Text(
                    game['category'],
                    style: context.regular.copyWith(
                      fontSize: 11.textMultiplier,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 6.heightMultiplier),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '⭐ ${game['rating']}',
                        style: context.medium.copyWith(
                          fontSize: 11.textMultiplier,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Best: ${game['score']}',
                        style: context.regular.copyWith(
                          fontSize: 10.textMultiplier,
                          color: AppColors.textSecondary,
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
