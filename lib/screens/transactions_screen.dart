import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(Responsive.spacing(context, 20)),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Container(
                          padding: EdgeInsets.all(Responsive.spacing(context, 8)),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            size: Responsive.iconSize(context, 20),
                          ),
                        ),
                      ),
                      SizedBox(width: Responsive.spacing(context, 16)),
                      Text(
                        'Transactions',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 24),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.spacing(context, 16)),

                  // Stats Summary
                  Container(
                    padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat(context, '₹2,847', 'Total Spent'),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildStat(context, '12', 'Transactions'),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildStat(context, 'Feb', 'This Month'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Filter Tabs
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.spacing(context, 20),
                vertical: Responsive.spacing(context, 16),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterTab('All'),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    _buildFilterTab('Campaigns'),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    _buildFilterTab('Products'),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    _buildFilterTab('Refunds'),
                  ],
                ),
              ),
            ),

            // Transactions List
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                children: [
                  _buildTransactionCard(
                    context,
                    '📱',
                    'iPhone 15 Campaign Entry',
                    'Feb 10, 2026 • 2:30 PM',
                    '₹299',
                    'Completed',
                    'INV-2026-0210-001',
                    true,
                  ),
                  _buildTransactionCard(
                    context,
                    '⌚',
                    'Apple Watch Campaign Entry',
                    'Feb 8, 2026 • 5:45 PM',
                    '₹149',
                    'Completed',
                    'INV-2026-0208-002',
                    true,
                  ),
                  _buildTransactionCard(
                    context,
                    '💻',
                    'MacBook Campaign Entry',
                    'Feb 5, 2026 • 11:20 AM',
                    '₹349',
                    'Completed',
                    'INV-2026-0205-003',
                    true,
                  ),
                  _buildTransactionCard(
                    context,
                    '🎧',
                    'AirPods Campaign Entry',
                    'Feb 2, 2026 • 3:15 PM',
                    '₹99',
                    'Refunded',
                    'INV-2026-0202-004',
                    false,
                  ),
                  _buildTransactionCard(
                    context,
                    '📱',
                    'Samsung S24 Campaign Entry',
                    'Jan 28, 2026 • 6:50 PM',
                    '₹199',
                    'Completed',
                    'INV-2026-0128-005',
                    true,
                  ),
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
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 4)),
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 11),
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTab(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.spacing(context, 16),
          vertical: Responsive.spacing(context, 8),
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF6B35) : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionCard(
      BuildContext context,
      String emoji,
      String title,
      String datetime,
      String amount,
      String status,
      String invoiceId,
      bool isCompleted,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.spacing(context, 12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(
            color: isCompleted ? const Color(0xFF10B981) : const Color(0xFFFF6B35),
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
            padding: EdgeInsets.all(Responsive.spacing(context, 16)),
            child: Row(
              children: [
                Container(
                  width: Responsive.dimension(context, 50),
                  height: Responsive.dimension(context, 50),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      emoji,
                      style: TextStyle(fontSize: Responsive.fontSize(context, 24)),
                    ),
                  ),
                ),
                SizedBox(width: Responsive.spacing(context, 12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 15),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                      SizedBox(height: Responsive.spacing(context, 4)),
                      Text(
                        datetime,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 12),
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      amount,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 18),
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                    SizedBox(height: Responsive.spacing(context, 4)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.spacing(context, 8),
                        vertical: Responsive.spacing(context, 4),
                      ),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? const Color(0xFF10B981).withOpacity(0.1)
                            : const Color(0xFFFF6B35).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 10),
                          fontWeight: FontWeight.w700,
                          color: isCompleted
                              ? const Color(0xFF10B981)
                              : const Color(0xFFFF6B35),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(Responsive.spacing(context, 12)),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.receipt,
                      size: Responsive.iconSize(context, 16),
                      color: const Color(0xFF6B7280),
                    ),
                    SizedBox(width: Responsive.spacing(context, 6)),
                    Text(
                      invoiceId,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 12),
                        color: const Color(0xFF6B7280),
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
                          'Invoice downloaded: $invoiceId.pdf',
                          style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
                        ),
                        backgroundColor: const Color(0xFF10B981),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.download,
                        size: Responsive.iconSize(context, 16),
                        color: const Color(0xFFFF6B35),
                      ),
                      SizedBox(width: Responsive.spacing(context, 4)),
                      Text(
                        'Download',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 13),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFF6B35),
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