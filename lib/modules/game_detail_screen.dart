import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GameDetailScreen extends StatelessWidget {
  final String gameTitle;
  final String gameRoute;

  const GameDetailScreen({
    super.key,
    this.gameTitle = 'Game',
    this.gameRoute = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: AppColors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 16.widthMultiplier,
                vertical: 12.heightMultiplier,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    child: Container(
                      padding: EdgeInsets.all(8.widthMultiplier),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12.radiusMultipier),
                      ),
                      child: Image.asset(
                        AppImages.back,
                        height: 18.heightMultiplier,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.widthMultiplier),
                  Text(
                    gameTitle,
                    style: context.bold.copyWith(
                      fontSize: 20.textMultiplier,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20.widthMultiplier),
                children: [
                  // Preview
                  Container(
                    height: 200.heightMultiplier,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, Color(0xFF1A6B8A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20.radiusMultipier),
                    ),
                    child: Center(
                      child: Text(
                        '🎮',
                        style: TextStyle(fontSize: 72.textMultiplier),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.heightMultiplier),

                  // Description
                  Text(
                    'Endless runner game with stunning graphics and smooth controls. Jump, slide, and collect coins!',
                    style: context.regular.copyWith(
                      fontSize: 14.textMultiplier,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 24.heightMultiplier),

                  // Stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(context, '2100', 'Best Score'),
                      ),
                      SizedBox(width: 12.widthMultiplier),
                      Expanded(
                        child: _buildStatCard(context, '2-5 min', 'Avg Time'),
                      ),
                      SizedBox(width: 12.widthMultiplier),
                      Expanded(
                        child: _buildStatCard(context, 'Arcade', 'Category'),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.heightMultiplier),

                  // Play button
                  SizedBox(
                    width: double.infinity,
                    height: 52.heightMultiplier,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pushNamed(gameRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            16.radiusMultipier,
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        '▶️  PLAY NOW',
                        style: context.bold.copyWith(
                          fontSize: 15.textMultiplier,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.heightMultiplier),

                  // Leaderboard button
                  OutlinedButton(
                    onPressed: () {
                      context.pushNamed(
                        Routes.leaderboard,
                        extra: {
                          'gameCode': gameTitle.toLowerCase().replaceAll(
                            ' ',
                            '_',
                          ),
                        },
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.radiusMultipier),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 14.heightMultiplier,
                      ),
                    ),
                    child: Text(
                      'VIEW LEADERBOARD',
                      style: context.bold.copyWith(
                        fontSize: 14.textMultiplier,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.heightMultiplier),
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
      padding: EdgeInsets.all(16.widthMultiplier),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.radiusMultipier),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: context.extraBold.copyWith(
              fontSize: 17.textMultiplier,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.heightMultiplier),
          Text(
            label,
            style: context.regular.copyWith(
              fontSize: 11.textMultiplier,
              color: AppColors.textSecondary,
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
