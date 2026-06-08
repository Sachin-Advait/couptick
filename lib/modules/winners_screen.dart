import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WinnersScreen extends StatelessWidget {
  const WinnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
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
                            height: 20.heightMultiplier,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.widthMultiplier),
                      Text(
                        '🏆 Winners',
                        style: context.extraBold.copyWith(
                          fontSize: 22.textMultiplier,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.heightMultiplier),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTab(context, 'Recent Winners', true),
                      ),
                      SizedBox(width: 10.widthMultiplier),
                      Expanded(
                        child: _buildTab(
                          context,
                          'My Wins',
                          false,
                          onTap: () => context.pushNamed(Routes.myWins),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20.widthMultiplier),
                children: [
                  _buildWinnerCard(
                    context,
                    '🎉',
                    'Rahul S.',
                    '📍 Delhi, India',
                    'Won 2 days ago',
                    'iPhone 15 Pro Max',
                    '₹1,20,000',
                    '245',
                    '2,456',
                    '10%',
                  ),
                  _buildWinnerCard(
                    context,
                    '🎊',
                    'Priya M.',
                    '📍 Mumbai, India',
                    'Won 5 days ago',
                    'MacBook Air M3',
                    '₹1,00,000',
                    '892',
                    '3,124',
                    '28%',
                  ),
                  _buildWinnerCard(
                    context,
                    '🏅',
                    'Amit K.',
                    '📍 Bangalore, India',
                    'Won 1 week ago',
                    'Apple Watch Ultra',
                    '₹60,000',
                    '1,234',
                    '1,890',
                    '65%',
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

  Widget _buildTab(
    BuildContext context,
    String label,
    bool isActive, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.heightMultiplier),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12.radiusMultipier),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: context.semiBold.copyWith(
            fontSize: 13.textMultiplier,
            color: isActive ? AppColors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildWinnerCard(
    BuildContext context,
    String avatar,
    String name,
    String location,
    String date,
    String prize,
    String prizeValue,
    String ticketNum,
    String totalEntries,
    String odds,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.heightMultiplier),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.radiusMultipier),
        border: Border(left: BorderSide(color: AppColors.primary, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(18.widthMultiplier),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Winner info
          Row(
            children: [
              Container(
                width: 58.widthMultiplier,
                height: 58.widthMultiplier,
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(16.radiusMultipier),
                ),
                child: Center(
                  child: Text(
                    avatar,
                    style: TextStyle(fontSize: 26.textMultiplier),
                  ),
                ),
              ),
              SizedBox(width: 14.widthMultiplier),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: context.bold.copyWith(
                        fontSize: 15.textMultiplier,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 3.heightMultiplier),
                    Text(
                      location,
                      style: context.regular.copyWith(
                        fontSize: 12.textMultiplier,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 6.heightMultiplier),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.widthMultiplier,
                        vertical: 4.heightMultiplier,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successSurface,
                        borderRadius: BorderRadius.circular(8.radiusMultipier),
                      ),
                      child: Text(
                        date,
                        style: context.semiBold.copyWith(
                          fontSize: 11.textMultiplier,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.heightMultiplier),

          // Prize block
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.widthMultiplier),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12.radiusMultipier),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Prize Won',
                  style: context.medium.copyWith(
                    fontSize: 11.textMultiplier,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 6.heightMultiplier),
                Text(
                  prize,
                  style: context.bold.copyWith(
                    fontSize: 16.textMultiplier,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.heightMultiplier),
                Text(
                  'Worth $prizeValue',
                  style: context.bold.copyWith(
                    fontSize: 14.textMultiplier,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.heightMultiplier),

          // Stats row
          Row(
            children: [
              Expanded(child: _buildStatBox(context, ticketNum, 'Ticket #')),
              SizedBox(width: 10.widthMultiplier),
              Expanded(
                child: _buildStatBox(context, totalEntries, 'Total Entries'),
              ),
              SizedBox(width: 10.widthMultiplier),
              Expanded(child: _buildStatBox(context, odds, 'Odds')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(BuildContext context, String value, String label) {
    return Container(
      padding: EdgeInsets.all(12.widthMultiplier),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.radiusMultipier),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: context.extraBold.copyWith(
              fontSize: 16.textMultiplier,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.heightMultiplier),
          Text(
            label,
            style: context.regular.copyWith(
              fontSize: 10.textMultiplier,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
