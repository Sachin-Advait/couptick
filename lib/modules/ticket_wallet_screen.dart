import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TicketWalletScreen extends StatefulWidget {
  const TicketWalletScreen({super.key});

  @override
  State<TicketWalletScreen> createState() => _TicketWalletScreenState();
}

class _TicketWalletScreenState extends State<TicketWalletScreen> {
  String _selectedTab = 'All Tickets';

  final List<String> _tabs = ['All Tickets', 'Active', 'Expired', 'Winners'];

  final List<Map<String, dynamic>> _tickets = [
    {
      'title': 'iPhone 15 Pro Max',
      'draw': 'Draw: Feb 22, 2026 • 6:00 PM',
      'numbers': ['#2451', '#2452', '#2453'],
      'purchased': 'Feb 8, 2026',
      'code': 'TKT-2024-02-001',
      'isActive': true,
    },
    {
      'title': 'MacBook Air M3',
      'draw': 'Draw: Feb 28, 2026 • 7:00 PM',
      'numbers': ['#1089', '#1090', '#1091', '#1092', '#1093'],
      'purchased': 'Feb 7, 2026',
      'code': 'TKT-2024-02-002',
      'isActive': true,
    },
    {
      'title': 'Samsung Galaxy S24',
      'draw': 'Draw: Feb 15, 2026 • 5:00 PM',
      'numbers': ['#5678', '#5679'],
      'purchased': 'Feb 8, 2026',
      'code': 'TKT-2024-02-003',
      'isActive': false,
    },
    {
      'title': 'Apple Watch Ultra',
      'draw': 'Draw: Feb 25, 2026 • 6:30 PM',
      'numbers': ['#3401', '#3402', '#3403', '#3404'],
      'purchased': 'Feb 6, 2026',
      'code': 'TKT-2024-02-004',
      'isActive': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredTickets {
    if (_selectedTab == 'All Tickets') return _tickets;
    if (_selectedTab == 'Active') {
      return _tickets.where((t) => t['isActive'] == true).toList();
    }
    if (_selectedTab == 'Expired') {
      return _tickets.where((t) => t['isActive'] == false).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          _buildTabs(context),
          Expanded(
            child: _filteredTickets.isEmpty
                ? _buildEmptyState(context)
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.widthMultiplier,
                      vertical: 20.heightMultiplier,
                    ),
                    itemCount: _filteredTickets.length,
                    itemBuilder: (_, i) =>
                        _buildTicketCard(context, _filteredTickets[i]),
                  ),
          ),
          80.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16.widthMultiplier,
        right: 16.widthMultiplier,
        bottom: 15.heightMultiplier,
      ),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
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
              15.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Tickets',
                    style: context.extraBold.copyWith(
                      fontSize: 22.textMultiplier,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'Track your entries',
                    style: context.regular.copyWith(
                      fontSize: 13.textMultiplier,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.heightMultiplier),

          // Stats Banner
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.secondary,
                  AppColors.secondary.withValues(alpha: .8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.radiusMultipier),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20.widthMultiplier,
              vertical: 20.heightMultiplier,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(context, '24', 'Total Tickets'),
                _buildDivider(),
                _buildStatItem(context, '6', 'Active'),
                _buildDivider(),
                _buildStatItem(context, '₹1.8K', 'Invested'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 36.heightMultiplier,
      width: 1,
      color: AppColors.white.withOpacity(0.25),
    );
  }

  Widget _buildStatItem(BuildContext context, String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: context.extraBold.copyWith(
            fontSize: 26.textMultiplier,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 4.heightMultiplier),
        Text(
          label,
          style: context.regular.copyWith(
            fontSize: 11.textMultiplier,
            color: AppColors.white.withOpacity(0.85),
          ),
        ),
      ],
    );
  }

  Widget _buildTabs(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.only(
        left: 20.widthMultiplier,
        right: 20.widthMultiplier,
        bottom: 16.heightMultiplier,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _tabs.map((tab) {
            final isActive = _selectedTab == tab;
            return GestureDetector(
              onTap: () => setState(() => _selectedTab = tab),
              child: Container(
                margin: EdgeInsets.only(right: 8.widthMultiplier),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.widthMultiplier,
                  vertical: 8.heightMultiplier,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primary
                      : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12.radiusMultipier),
                ),
                child: Text(
                  tab,
                  style: context.semiBold.copyWith(
                    fontSize: 13.textMultiplier,
                    color: isActive ? AppColors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTicketCard(BuildContext context, Map<String, dynamic> ticket) {
    final isActive = ticket['isActive'] as bool;
    final numbers = ticket['numbers'] as List<String>;

    return Container(
      margin: EdgeInsets.only(bottom: 16.heightMultiplier),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.radiusMultipier),
        border: Border(
          left: BorderSide(
            color: isActive ? AppColors.primary : AppColors.textDisabled,
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
      padding: EdgeInsets.all(18.widthMultiplier),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + status badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket['title'],
                      style: context.bold.copyWith(
                        fontSize: 15.textMultiplier,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.heightMultiplier),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 12.widthMultiplier,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 4.widthMultiplier),
                        Text(
                          ticket['draw'],
                          style: context.regular.copyWith(
                            fontSize: 11.textMultiplier,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.widthMultiplier),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.widthMultiplier,
                  vertical: 5.heightMultiplier,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.successSurface
                      : AppColors.warningSurface,
                  borderRadius: BorderRadius.circular(8.radiusMultipier),
                ),
                child: Text(
                  isActive ? 'ACTIVE' : 'PENDING',
                  style: context.semiBold.copyWith(
                    fontSize: 10.textMultiplier,
                    color: isActive ? AppColors.success : AppColors.warning,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 14.heightMultiplier),

          // Ticket numbers block
          Container(
            padding: EdgeInsets.all(14.widthMultiplier),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12.radiusMultipier),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.confirmation_number_rounded,
                      size: 13.widthMultiplier,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 6.widthMultiplier),
                    Text(
                      'Your Ticket Numbers',
                      style: context.medium.copyWith(
                        fontSize: 11.textMultiplier,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.heightMultiplier),
                Wrap(
                  spacing: 8.widthMultiplier,
                  runSpacing: 8.heightMultiplier,
                  children: numbers
                      .map(
                        (n) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.widthMultiplier,
                            vertical: 7.heightMultiplier,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(
                              8.radiusMultipier,
                            ),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.4),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            n,
                            style: context.bold.copyWith(
                              fontSize: 13.textMultiplier,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.heightMultiplier),

          // Footer: purchased + code
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 11.widthMultiplier,
                    color: AppColors.textDisabled,
                  ),
                  SizedBox(width: 4.widthMultiplier),
                  Text(
                    'Purchased: ${ticket['purchased']}',
                    style: context.light.copyWith(
                      fontSize: 11.textMultiplier,
                      color: AppColors.textDisabled,
                    ),
                  ),
                ],
              ),
              Text(
                ticket['code'],
                style: context.light.copyWith(
                  fontSize: 10.textMultiplier,
                  color: AppColors.textDisabled,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.confirmation_number_outlined,
            size: 56.widthMultiplier,
            color: AppColors.textDisabled,
          ),
          SizedBox(height: 16.heightMultiplier),
          Text(
            'No tickets here',
            style: context.bold.copyWith(
              fontSize: 16.textMultiplier,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 6.heightMultiplier),
          Text(
            'Tickets in this category will appear here.',
            style: context.regular.copyWith(
              fontSize: 13.textMultiplier,
              color: AppColors.textDisabled,
            ),
          ),
        ],
      ),
    );
  }
}
