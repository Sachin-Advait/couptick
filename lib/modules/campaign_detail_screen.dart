import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CampaignDetailScreen extends StatelessWidget {
  const CampaignDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildHeroSliver(context),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28.radiusMultipier),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      20.widthMultiplier,
                      24.heightMultiplier,
                      20.widthMultiplier,
                      120.heightMultiplier,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStatsRow(context),
                        SizedBox(height: 24.heightMultiplier),
                        _buildParticipantsRow(context),
                        SizedBox(height: 28.heightMultiplier),
                        _buildCampaignDetails(context),
                        SizedBox(height: 24.heightMultiplier),
                        _buildAboutSection(context),
                        SizedBox(height: 24.heightMultiplier),
                        _buildHowToPlay(context),
                        70.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          _buildBottomAction(context),
        ],
      ),
    );
  }

  Widget _buildHeroSliver(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340.heightMultiplier,
      pinned: true,
      backgroundColor: AppColors.primary,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.widthMultiplier),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.heightMultiplier),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10.radiusMultipier),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.white,
              size: 18.widthMultiplier,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.widthMultiplier),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.heightMultiplier),
              padding: EdgeInsets.all(8.widthMultiplier),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10.radiusMultipier),
              ),
              child: Icon(
                Icons.share_rounded,
                color: AppColors.white,
                size: 18.widthMultiplier,
              ),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primary.withBlue(110)],
            ),
          ),
          child: Stack(
            children: [
              // Decorative background circles
              Positioned(
                right: -30,
                top: 40,
                child: Container(
                  width: 160.widthMultiplier,
                  height: 160.widthMultiplier,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white.withOpacity(0.05),
                  ),
                ),
              ),
              Positioned(
                left: -40,
                bottom: 60,
                child: Container(
                  width: 120.widthMultiplier,
                  height: 120.widthMultiplier,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white.withOpacity(0.05),
                  ),
                ),
              ),
              // Content
              SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      20.widthMultiplier,
                      60.heightMultiplier,
                      20.widthMultiplier,
                      28.heightMultiplier,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.widthMultiplier,
                            vertical: 5.heightMultiplier,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(
                              20.radiusMultipier,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.local_fire_department_rounded,
                                color: AppColors.white,
                                size: 13.widthMultiplier,
                              ),
                              SizedBox(width: 4.widthMultiplier),
                              Text(
                                'HOT CAMPAIGN',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.textMultiplier,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.heightMultiplier),
                        Container(
                          padding: EdgeInsets.all(20.widthMultiplier),
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '📱',
                            style: TextStyle(fontSize: 54.textMultiplier),
                          ),
                        ),
                        SizedBox(height: 16.heightMultiplier),
                        Text(
                          'iPhone 15 Pro Max',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22.textMultiplier,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 6.heightMultiplier),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.widthMultiplier,
                            vertical: 4.heightMultiplier,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(
                              8.radiusMultipier,
                            ),
                          ),
                          child: Text(
                            'Prize Worth ₹1,34,900',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.textMultiplier,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white.withOpacity(0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.currency_rupee_rounded,
            value: '299',
            label: 'Per Play',
            color: AppColors.secondary,
          ),
        ),
        SizedBox(width: 10.widthMultiplier),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.people_outline_rounded,
            value: '2.4K',
            label: 'Playing',
            color: AppColors.info,
          ),
        ),
        SizedBox(width: 10.widthMultiplier),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.calendar_today_outlined,
            value: '12',
            label: 'Days Left',
            color: AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.widthMultiplier,
        vertical: 14.heightMultiplier,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.radiusMultipier),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.widthMultiplier),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.radiusMultipier),
            ),
            child: Icon(icon, size: 16.widthMultiplier, color: color),
          ),
          SizedBox(height: 8.heightMultiplier),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18.textMultiplier,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 2.heightMultiplier),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10.textMultiplier,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantsRow(BuildContext context) {
    const initials = ['A', 'R', 'S', 'M'];
    final avatarColors = [
      AppColors.primary,
      AppColors.info,
      AppColors.success,
      AppColors.secondary,
    ];

    return Container(
      padding: EdgeInsets.all(16.widthMultiplier),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.radiusMultipier),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 36.heightMultiplier,
            width: (initials.length * 26.0 + 10).widthMultiplier,
            child: Stack(
              children: List.generate(initials.length, (i) {
                return Positioned(
                  left: (i * 26.0).widthMultiplier,
                  child: Container(
                    width: 36.widthMultiplier,
                    height: 36.widthMultiplier,
                    decoration: BoxDecoration(
                      color: avatarColors[i],
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        initials[i],
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13.textMultiplier,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(width: 12.widthMultiplier),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2,456 people are playing',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.textMultiplier,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.heightMultiplier),
                Text(
                  'Join them now!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.textMultiplier,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
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
              'Active',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11.textMultiplier,
                fontWeight: FontWeight.w600,
                color: AppColors.success,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignDetails(BuildContext context) {
    return _buildSection(
      context,
      title: 'Campaign Details',
      icon: Icons.info_outline_rounded,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.radiusMultipier),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            _buildInfoRow(
              context,
              'Start Date',
              'Jan 15, 2026',
              Icons.play_circle_outline_rounded,
            ),
            Divider(height: 1, color: AppColors.divider),
            _buildInfoRow(
              context,
              'End Date',
              'Feb 20, 2026',
              Icons.stop_circle_outlined,
            ),
            Divider(height: 1, color: AppColors.divider),
            _buildInfoRow(
              context,
              'Draw Date',
              'Feb 22, 2026',
              Icons.emoji_events_outlined,
            ),
            Divider(height: 1, color: AppColors.divider),
            _buildInfoRow(
              context,
              'Max Tickets',
              '10,000',
              Icons.confirmation_number_outlined,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'About This Campaign',
      icon: Icons.article_outlined,
      child: Container(
        padding: EdgeInsets.all(16.widthMultiplier),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.radiusMultipier),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(
          'Win the latest iPhone 15 Pro Max (256GB) in Titanium Blue! Purchase any mobile phone from our partner stores and get instant raffle tickets. The more you buy, the higher your chances to win this amazing prize worth ₹1,34,900!',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.textMultiplier,
            color: AppColors.textSecondary,
            height: 1.7,
          ),
        ),
      ),
    );
  }

  Widget _buildHowToPlay(BuildContext context) {
    final steps = [
      'Buy any eligible product from our partner stores',
      'Pay ₹299 entry fee to join the campaign',
      'Play the instant game to reveal your tickets',
      'Get up to 5 raffle tickets per entry',
      'Winner announced on draw date via live stream',
    ];

    return _buildSection(
      context,
      title: 'How to Play',
      icon: Icons.help_outline_rounded,
      child: Column(
        children: steps
            .asMap()
            .entries
            .map(
              (e) => _buildStepItem(
                context,
                e.key + 1,
                e.value,
                e.key == steps.length - 1,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.widthMultiplier),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(8.radiusMultipier),
              ),
              child: Icon(
                icon,
                size: 15.widthMultiplier,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 10.widthMultiplier),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.textMultiplier,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.heightMultiplier),
        child,
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.widthMultiplier,
        vertical: 13.heightMultiplier,
      ),
      child: Row(
        children: [
          Icon(icon, size: 16.widthMultiplier, color: AppColors.textDisabled),
          SizedBox(width: 10.widthMultiplier),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.textMultiplier,
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.textMultiplier,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(
    BuildContext context,
    int step,
    String text,
    bool isLast,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 10.heightMultiplier),
      child: Container(
        padding: EdgeInsets.all(14.widthMultiplier),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14.radiusMultipier),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 26.widthMultiplier,
              height: 26.widthMultiplier,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8.radiusMultipier),
              ),
              child: Center(
                child: Text(
                  '$step',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.textMultiplier,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.widthMultiplier),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.textMultiplier,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Positioned(
      bottom: 80,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 24,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(
          20.widthMultiplier,
          16.heightMultiplier,
          20.widthMultiplier,
          28.heightMultiplier,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Entry Fee',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.textMultiplier,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 2.heightMultiplier),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹299',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24.textMultiplier,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 6.widthMultiplier),
                    Padding(
                      padding: EdgeInsets.only(bottom: 3.heightMultiplier),
                      child: Text(
                        'per play',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.textMultiplier,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 16.widthMultiplier),
            Expanded(
              child: SizedBox(
                height: 52.heightMultiplier,
                child: ElevatedButton(
                  onPressed: () => context.pushNamed(Routes.gamePlay),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.radiusMultipier),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle_filled_rounded,
                        color: AppColors.white,
                        size: 18.widthMultiplier,
                      ),
                      SizedBox(width: 8.widthMultiplier),
                      Text(
                        'Play Now & Win',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15.textMultiplier,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
