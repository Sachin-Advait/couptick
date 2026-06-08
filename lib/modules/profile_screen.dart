import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:couptick/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 16.widthMultiplier,
                vertical: 20.heightMultiplier,
              ),
              children: [
                _buildProfileCard(context),
                SizedBox(height: 16.heightMultiplier),
                _buildStatsCard(context),
                SizedBox(height: 20.heightMultiplier),
                _buildSectionLabel(context, 'Account'),
                SizedBox(height: 10.heightMultiplier),
                _buildMenuItem(
                  context,
                  icon: Icons.emoji_events_rounded,
                  label: 'My Wins',
                  subtitle: 'View your winning history',
                  onTap: () => context.pushNamed(Routes.myWins),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.account_balance_wallet_rounded,
                  label: 'Wallet',
                  subtitle: 'Manage your balance',
                  onTap: () {},
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.receipt_long_rounded,
                  label: 'Transactions',
                  subtitle: 'Payment history',
                  onTap: () => context.pushNamed(Routes.transactions),
                ),
                SizedBox(height: 20.heightMultiplier),
                _buildSectionLabel(context, 'Preferences'),
                SizedBox(height: 10.heightMultiplier),
                _buildMenuItem(
                  context,
                  icon: Icons.settings_rounded,
                  label: 'Settings',
                  subtitle: 'App preferences',
                  onTap: () {},
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.help_outline_rounded,
                  label: 'Help & Support',
                  subtitle: 'Get assistance',
                  onTap: () {},
                ),
                SizedBox(height: 20.heightMultiplier),
                _buildLogoutButton(context),
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
        top: MediaQuery.of(context).padding.top + 12.heightMultiplier,
        left: 20.widthMultiplier,
        right: 20.widthMultiplier,
        bottom: 16.heightMultiplier,
      ),
      child: Row(
        children: [
          Text(
            'My Profile',
            style: context.extraBold.copyWith(
              fontSize: 22.textMultiplier,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          Container(
            width: 40.widthMultiplier,
            height: 40.widthMultiplier,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12.radiusMultipier),
            ),
            child: Icon(
              Icons.edit_outlined,
              size: 18.widthMultiplier,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.widthMultiplier),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20.radiusMultipier),
      ),
      child: Row(
        children: [
          Container(
            width: 64.widthMultiplier,
            height: 64.widthMultiplier,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.person_rounded,
              size: 32.widthMultiplier,
              color: AppColors.white,
            ),
          ),
          SizedBox(width: 16.widthMultiplier),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Guest User',
                  style: context.bold.copyWith(
                    fontSize: 18.textMultiplier,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 4.heightMultiplier),
                Text(
                  'guest_123@temp.com',
                  style: context.regular.copyWith(
                    fontSize: 12.textMultiplier,
                    color: AppColors.white.withOpacity(0.75),
                  ),
                ),
                SizedBox(height: 8.heightMultiplier),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.widthMultiplier,
                    vertical: 4.heightMultiplier,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(20.radiusMultipier),
                  ),
                  child: Text(
                    'Active Member',
                    style: context.medium.copyWith(
                      fontSize: 10.textMultiplier,
                      color: AppColors.white,
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

  Widget _buildStatsCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.widthMultiplier),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.radiusMultipier),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Stats',
            style: context.semiBold.copyWith(
              fontSize: 15.textMultiplier,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16.heightMultiplier),
          Row(
            children: [
              _buildStatItem(context, '24', 'Total\nTickets'),
              _buildStatDivider(),
              _buildStatItem(context, '6', 'Active\nDraws'),
              _buildStatDivider(),
              _buildStatItem(context, '₹1.8K', 'Total\nInvested'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: context.extraBold.copyWith(
              fontSize: 22.textMultiplier,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 4.heightMultiplier),
          Text(
            label,
            style: context.regular.copyWith(
              fontSize: 11.textMultiplier,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(width: 1, height: 40, color: AppColors.divider);
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Text(
      label.toUpperCase(),
      style: context.medium.copyWith(
        fontSize: 11.textMultiplier,
        color: AppColors.textSecondary,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Container(
              width: 40.widthMultiplier,
              height: 40.widthMultiplier,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(12.radiusMultipier),
              ),
              child: Icon(
                icon,
                size: 20.widthMultiplier,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 14.widthMultiplier),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.semiBold.copyWith(
                      fontSize: 14.textMultiplier,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.heightMultiplier),
                  Text(
                    subtitle,
                    style: context.regular.copyWith(
                      fontSize: 11.textMultiplier,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20.widthMultiplier,
              color: AppColors.textDisabled,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SessionManager.clearSession();
        context.goNamed(Routes.login);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.heightMultiplier),
        decoration: BoxDecoration(
          color: AppColors.errorSurface,
          borderRadius: BorderRadius.circular(16.radiusMultipier),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_rounded,
              size: 18.widthMultiplier,
              color: AppColors.error,
            ),
            SizedBox(width: 8.widthMultiplier),
            Text(
              'Logout',
              style: context.semiBold.copyWith(
                fontSize: 14.textMultiplier,
                color: AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
