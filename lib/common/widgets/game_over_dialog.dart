import 'dart:async';

import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GameOverDialog extends StatelessWidget {
  final int score;
  final String gameCode;
  final String emoji;
  final VoidCallback onPlayAgain;
  final int? coinsCollected;

  const GameOverDialog({
    super.key,
    required this.score,
    required this.gameCode,
    required this.emoji,
    required this.onPlayAgain,
    this.coinsCollected,
  });

  /// Convenience method — call this instead of showDialog directly
  static Future<void> show({
    required BuildContext context,
    required int score,
    required String gameCode,
    required String emoji,
    required VoidCallback onPlayAgain,
    int? coinsCollected,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => GameOverDialog(
        score: score,
        gameCode: gameCode,
        emoji: emoji,
        onPlayAgain: onPlayAgain,
        coinsCollected: coinsCollected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.radiusMultipier),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.widthMultiplier),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: TextStyle(fontSize: 48.textMultiplier)),
            SizedBox(height: 8.heightMultiplier),
            Text(
              'Game Over!',
              style: context.extraBold.copyWith(
                fontSize: 22.textMultiplier,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.heightMultiplier),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.heightMultiplier),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(16.radiusMultipier),
              ),
              child: Column(
                children: [
                  Text(
                    'Your Score',
                    style: context.regular.copyWith(
                      fontSize: 12.textMultiplier,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 6.heightMultiplier),
                  Text(
                    '$score',
                    style: context.extraBold.copyWith(
                      fontSize: 44.textMultiplier,
                      color: AppColors.primary,
                    ),
                  ),
                  if (coinsCollected != null) ...[
                    SizedBox(height: 4.heightMultiplier),
                    Text(
                      '🪙 $coinsCollected coins',
                      style: context.medium.copyWith(
                        fontSize: 13.textMultiplier,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 20.heightMultiplier),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.pushNamed(
                        Routes.leaderboard,
                        extra: {'gameCode': gameCode},
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.radiusMultipier),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 13.heightMultiplier,
                      ),
                    ),
                    child: Text(
                      'Scores',
                      style: context.semiBold.copyWith(
                        fontSize: 13.textMultiplier,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.widthMultiplier),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                      onPlayAgain();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.radiusMultipier),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 13.heightMultiplier,
                      ),
                    ),
                    child: Text(
                      'Play Again',
                      style: context.bold.copyWith(
                        fontSize: 13.textMultiplier,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.heightMultiplier),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (context.canPop()) {
                  context.pop();
                }
              },
              child: Text(
                'Exit Game',
                style: context.regular.copyWith(
                  fontSize: 13.textMultiplier,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
