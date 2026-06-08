import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyWinsScreen extends StatelessWidget {
  const MyWinsScreen({super.key});

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
                        height: 20.heightMultiplier,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.widthMultiplier),
                  Text(
                    '🏆 My Wins',
                    style: context.extraBold.copyWith(
                      fontSize: 22.textMultiplier,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // Stats Banner
            Container(
              margin: EdgeInsets.all(20.widthMultiplier),
              padding: EdgeInsets.symmetric(
                horizontal: 20.widthMultiplier,
                vertical: 20.heightMultiplier,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, Color(0xFF1A6B8A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.radiusMultipier),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat(context, '2', 'Total Wins'),
                  Container(
                    width: 1,
                    height: 40.heightMultiplier,
                    color: AppColors.white.withOpacity(0.3),
                  ),
                  _buildStat(context, '₹1.8L', 'Total Value'),
                  Container(
                    width: 1,
                    height: 40.heightMultiplier,
                    color: AppColors.white.withOpacity(0.3),
                  ),
                  _buildStat(context, '1', 'Claimed'),
                ],
              ),
            ),

            // Wins List
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.widthMultiplier),
                children: [
                  _buildWinCard(
                    context,
                    '📱',
                    'iPhone 15 Pro Max',
                    '₹1,20,000',
                    'Jan 15, 2026',
                    'Claimed',
                    true,
                    '#2451',
                  ),
                  _buildWinCard(
                    context,
                    '⌚',
                    'Apple Watch Ultra',
                    '₹60,000',
                    'Dec 10, 2025',
                    'Pending Claim',
                    false,
                    '#3402',
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

  Widget _buildStat(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: context.extraBold.copyWith(
            fontSize: 22.textMultiplier,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 4.heightMultiplier),
        Text(
          label,
          style: context.regular.copyWith(
            fontSize: 11.textMultiplier,
            color: AppColors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildWinCard(
    BuildContext context,
    String emoji,
    String prize,
    String value,
    String date,
    String status,
    bool claimed,
    String ticketNum,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.heightMultiplier),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.radiusMultipier),
        border: Border(
          left: BorderSide(
            color: claimed ? AppColors.success : AppColors.warning,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(18.widthMultiplier),
            child: Row(
              children: [
                Container(
                  width: 68.widthMultiplier,
                  height: 68.widthMultiplier,
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(16.radiusMultipier),
                  ),
                  child: Center(
                    child: Text(
                      emoji,
                      style: TextStyle(fontSize: 32.textMultiplier),
                    ),
                  ),
                ),
                SizedBox(width: 14.widthMultiplier),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prize,
                        style: context.bold.copyWith(
                          fontSize: 15.textMultiplier,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.heightMultiplier),
                      Text(
                        'Worth $value',
                        style: context.bold.copyWith(
                          fontSize: 14.textMultiplier,
                          color: AppColors.secondary,
                        ),
                      ),
                      SizedBox(height: 8.heightMultiplier),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 12.widthMultiplier,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 4.widthMultiplier),
                          Text(
                            date,
                            style: context.regular.copyWith(
                              fontSize: 11.textMultiplier,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(width: 10.widthMultiplier),
                          Text(
                            'Ticket: $ticketNum',
                            style: context.semiBold.copyWith(
                              fontSize: 11.textMultiplier,
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

          // Footer
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 18.widthMultiplier,
              vertical: 12.heightMultiplier,
            ),
            decoration: BoxDecoration(
              color: claimed
                  ? AppColors.successSurface
                  : AppColors.warningSurface,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.radiusMultipier),
                bottomRight: Radius.circular(20.radiusMultipier),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      claimed
                          ? Icons.check_circle_rounded
                          : Icons.pending_rounded,
                      size: 16.widthMultiplier,
                      color: claimed ? AppColors.success : AppColors.warning,
                    ),
                    SizedBox(width: 6.widthMultiplier),
                    Text(
                      status,
                      style: context.semiBold.copyWith(
                        fontSize: 13.textMultiplier,
                        color: claimed ? AppColors.success : AppColors.warning,
                      ),
                    ),
                  ],
                ),
                if (!claimed)
                  GestureDetector(
                    onTap: () => context.pushNamed(
                      Routes.claimForm,
                      extra: {
                        'prize': prize,
                        'value': value,
                        'ticketNum': ticketNum,
                      },
                    ),
                    child: Text(
                      'Claim Now →',
                      style: context.bold.copyWith(
                        fontSize: 13.textMultiplier,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
