import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String _selectedTimeframe = 'Global';

  final List<String> _tabs = ['Global', 'Daily', 'Weekly'];

  final List<String> _names = [
    'Ali',
    'Sara',
    'John',
    'Emma',
    'Rahul',
    'Priya',
    'Mike',
    'Lisa',
    'Tom',
    'Nina',
  ];

  final List<int> _scores = [
    2450,
    2100,
    1980,
    1850,
    1720,
    1650,
    1580,
    1500,
    1450,
    1400,
  ];

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
              padding: EdgeInsets.only(
                left: 16.widthMultiplier,
                right: 16.widthMultiplier,
                top: 12.heightMultiplier,
                bottom: 16.heightMultiplier,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => context.pop(),
                        child: Container(
                          padding: EdgeInsets.all(8.widthMultiplier),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(
                              12.radiusMultipier,
                            ),
                          ),
                          child: Image.asset(
                            AppImages.back,
                            height: 16.heightMultiplier,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.widthMultiplier),
                      Text(
                        'Leaderboard',
                        style: context.bold.copyWith(
                          fontSize: 20.textMultiplier,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.heightMultiplier),

                  // Tabs
                  Row(
                    children: _tabs.map((tab) {
                      final isSelected = _selectedTimeframe == tab;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTimeframe = tab),
                          child: Container(
                            margin: EdgeInsets.only(
                              right: tab != _tabs.last ? 8.widthMultiplier : 0,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 10.heightMultiplier,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(
                                12.radiusMultipier,
                              ),
                            ),
                            child: Text(
                              tab,
                              textAlign: TextAlign.center,
                              style: context.semiBold.copyWith(
                                fontSize: 13.textMultiplier,
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // My Rank Card
            Container(
              color: AppColors.primarySurface,
              padding: EdgeInsets.symmetric(
                horizontal: 16.widthMultiplier,
                vertical: 14.heightMultiplier,
              ),
              child: Row(
                children: [
                  Container(
                    width: 48.widthMultiplier,
                    height: 48.widthMultiplier,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '#32',
                        style: context.bold.copyWith(
                          fontSize: 13.textMultiplier,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.widthMultiplier),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You (guest_123)',
                          style: context.semiBold.copyWith(
                            fontSize: 14.textMultiplier,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2.heightMultiplier),
                        Text(
                          'Best: 2100',
                          style: context.regular.copyWith(
                            fontSize: 12.textMultiplier,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '1250',
                    style: context.extraBold.copyWith(
                      fontSize: 20.textMultiplier,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            // List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.widthMultiplier),
                itemCount: _names.length,
                itemBuilder: (context, index) => _buildLeaderboardItem(
                  context,
                  index + 1,
                  _names[index],
                  _scores[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardItem(
    BuildContext context,
    int rank,
    String name,
    int score,
  ) {
    Color rankColor;
    String rankLabel;
    if (rank == 1) {
      rankColor = const Color(0xFFFFD700);
      rankLabel = '🥇';
    } else if (rank == 2) {
      rankColor = const Color(0xFFC0C0C0);
      rankLabel = '🥈';
    } else if (rank == 3) {
      rankColor = const Color(0xFFCD7F32);
      rankLabel = '🥉';
    } else {
      rankColor = AppColors.textDisabled;
      rankLabel = '#$rank';
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10.heightMultiplier),
      padding: EdgeInsets.symmetric(
        horizontal: 16.widthMultiplier,
        vertical: 14.heightMultiplier,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.radiusMultipier),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40.widthMultiplier,
            child: rank <= 3
                ? Text(
                    rankLabel,
                    style: TextStyle(fontSize: 22.textMultiplier),
                    textAlign: TextAlign.center,
                  )
                : Container(
                    width: 36.widthMultiplier,
                    height: 36.widthMultiplier,
                    decoration: BoxDecoration(
                      color: rankColor.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '#$rank',
                        style: context.bold.copyWith(
                          fontSize: 12.textMultiplier,
                          color: rankColor,
                        ),
                      ),
                    ),
                  ),
          ),
          SizedBox(width: 12.widthMultiplier),
          Expanded(
            child: Text(
              name,
              style: context.semiBold.copyWith(
                fontSize: 14.textMultiplier,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Text(
            score.toString(),
            style: context.extraBold.copyWith(
              fontSize: 17.textMultiplier,
              color: rank <= 3 ? AppColors.secondary : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
