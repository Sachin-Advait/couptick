import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Campaigns', 'Products', 'Refunds'];

  final List<Map<String, dynamic>> _transactions = [
    {
      'emoji': '📱',
      'title': 'iPhone 15 Campaign Entry',
      'datetime': 'Feb 10, 2026 • 2:30 PM',
      'amount': '₹299',
      'status': 'Completed',
      'invoiceId': 'INV-2026-0210-001',
      'isCompleted': true,
    },
    {
      'emoji': '⌚',
      'title': 'Apple Watch Campaign Entry',
      'datetime': 'Feb 8, 2026 • 5:45 PM',
      'amount': '₹149',
      'status': 'Completed',
      'invoiceId': 'INV-2026-0208-002',
      'isCompleted': true,
    },
    {
      'emoji': '💻',
      'title': 'MacBook Campaign Entry',
      'datetime': 'Feb 5, 2026 • 11:20 AM',
      'amount': '₹349',
      'status': 'Completed',
      'invoiceId': 'INV-2026-0205-003',
      'isCompleted': true,
    },
    {
      'emoji': '🎧',
      'title': 'AirPods Campaign Entry',
      'datetime': 'Feb 2, 2026 • 3:15 PM',
      'amount': '₹99',
      'status': 'Refunded',
      'invoiceId': 'INV-2026-0202-004',
      'isCompleted': false,
    },
    {
      'emoji': '📱',
      'title': 'Samsung S24 Campaign Entry',
      'datetime': 'Jan 28, 2026 • 6:50 PM',
      'amount': '₹199',
      'status': 'Completed',
      'invoiceId': 'INV-2026-0128-005',
      'isCompleted': true,
    },
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
                            height: 20.heightMultiplier,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.widthMultiplier),
                      Text(
                        'Transactions',
                        style: context.extraBold.copyWith(
                          fontSize: 22.textMultiplier,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.heightMultiplier),

                  // Stats banner
                  Container(
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
                        _buildStat(context, '₹2,847', 'Total Spent'),
                        Container(
                          width: 1,
                          height: 40.heightMultiplier,
                          color: AppColors.white.withOpacity(0.3),
                        ),
                        _buildStat(context, '12', 'Transactions'),
                        Container(
                          width: 1,
                          height: 40.heightMultiplier,
                          color: AppColors.white.withOpacity(0.3),
                        ),
                        _buildStat(context, 'Feb', 'This Month'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Filter tabs
            Container(
              color: AppColors.white,
              padding: EdgeInsets.only(
                left: 20.widthMultiplier,
                right: 20.widthMultiplier,
                bottom: 14.heightMultiplier,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters.map((f) {
                    final isSelected = _selectedFilter == f;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedFilter = f),
                      child: Container(
                        margin: EdgeInsets.only(right: 8.widthMultiplier),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.widthMultiplier,
                          vertical: 8.heightMultiplier,
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
                          f,
                          style: context.semiBold.copyWith(
                            fontSize: 13.textMultiplier,
                            color: isSelected
                                ? AppColors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(20.widthMultiplier),
                itemCount: _transactions.length,
                itemBuilder: (_, i) =>
                    _buildTransactionCard(context, _transactions[i]),
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
            fontSize: 18.textMultiplier,
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

  Widget _buildTransactionCard(BuildContext context, Map<String, dynamic> tx) {
    final isCompleted = tx['isCompleted'] as bool;

    return Container(
      margin: EdgeInsets.only(bottom: 12.heightMultiplier),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.radiusMultipier),
        border: Border(
          left: BorderSide(
            color: isCompleted ? AppColors.success : AppColors.warning,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(14.widthMultiplier),
            child: Row(
              children: [
                Container(
                  width: 48.widthMultiplier,
                  height: 48.widthMultiplier,
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(12.radiusMultipier),
                  ),
                  child: Center(
                    child: Text(
                      tx['emoji'],
                      style: TextStyle(fontSize: 22.textMultiplier),
                    ),
                  ),
                ),
                SizedBox(width: 12.widthMultiplier),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx['title'],
                        style: context.semiBold.copyWith(
                          fontSize: 13.textMultiplier,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.heightMultiplier),
                      Text(
                        tx['datetime'],
                        style: context.regular.copyWith(
                          fontSize: 11.textMultiplier,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      tx['amount'],
                      style: context.extraBold.copyWith(
                        fontSize: 16.textMultiplier,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.heightMultiplier),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.widthMultiplier,
                        vertical: 3.heightMultiplier,
                      ),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppColors.successSurface
                            : AppColors.warningSurface,
                        borderRadius: BorderRadius.circular(6.radiusMultipier),
                      ),
                      child: Text(
                        tx['status'],
                        style: context.semiBold.copyWith(
                          fontSize: 10.textMultiplier,
                          color: isCompleted
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Invoice footer
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 14.widthMultiplier,
              vertical: 10.heightMultiplier,
            ),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.radiusMultipier),
                bottomRight: Radius.circular(16.radiusMultipier),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.receipt_rounded,
                      size: 14.widthMultiplier,
                      color: AppColors.textDisabled,
                    ),
                    SizedBox(width: 6.widthMultiplier),
                    Text(
                      tx['invoiceId'],
                      style: context.light.copyWith(
                        fontSize: 11.textMultiplier,
                        color: AppColors.textDisabled,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Invoice downloaded: ${tx['invoiceId']}.pdf',
                          style: context.regular.copyWith(
                            fontSize: 13.textMultiplier,
                          ),
                        ),
                        backgroundColor: AppColors.success,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.download_rounded,
                        size: 14.widthMultiplier,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 4.widthMultiplier),
                      Text(
                        'Download',
                        style: context.semiBold.copyWith(
                          fontSize: 12.textMultiplier,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
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
