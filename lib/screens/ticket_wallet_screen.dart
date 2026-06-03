import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class TicketWalletScreen extends StatelessWidget {
  const TicketWalletScreen({super.key});

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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Tickets',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 24),
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF1A1A2E),
                            ),
                          ),
                          Text(
                            'Track your entries',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 14),
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.spacing(context, 20)),

                  // Stats Banner
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem(context: context, number: '24', text: 'Total Tickets'),
                        _StatItem(context: context, number: '6', text: 'Active'),
                        _StatItem(context: context, number: '₹1.8K', text: 'Invested'),
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
                    _buildTab(context, 'All Tickets', true),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    _buildTab(context, 'Active', false),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    _buildTab(context, 'Expired', false),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    _buildTab(context, 'Winners', false),
                  ],
                ),
              ),
            ),

            // Tickets List
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                children: [
                  _buildTicketCard(
                    context,
                    'iPhone 15 Pro Max',
                    'Draw: Feb 22, 2026 • 6:00 PM',
                    ['#2451', '#2452', '#2453'],
                    'Feb 8, 2026',
                    'TKT-2024-02-001',
                    true,
                  ),
                  _buildTicketCard(
                    context,
                    'MacBook Air M3',
                    'Draw: Feb 28, 2026 • 7:00 PM',
                    ['#1089', '#1090', '#1091', '#1092', '#1093'],
                    'Feb 7, 2026',
                    'TKT-2024-02-002',
                    true,
                  ),
                  _buildTicketCard(
                    context,
                    'Samsung Galaxy S24',
                    'Draw: Feb 15, 2026 • 5:00 PM',
                    ['#5678', '#5679'],
                    'Feb 8, 2026',
                    'TKT-2024-02-003',
                    false,
                  ),
                  _buildTicketCard(
                    context,
                    'Apple Watch Ultra',
                    'Draw: Feb 25, 2026 • 6:30 PM',
                    ['#3401', '#3402', '#3403', '#3404'],
                    'Feb 6, 2026',
                    'TKT-2024-02-004',
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

  Widget _buildTab(BuildContext context, String label, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.spacing(context, 16),
        vertical: Responsive.spacing(context, 8),
      ),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFF6B35) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: Responsive.fontSize(context, 14),
          fontWeight: FontWeight.w600,
          color: isActive ? Colors.white : const Color(0xFF6B7280),
        ),
      ),
    );
  }

  Widget _buildTicketCard(
      BuildContext context,
      String title,
      String meta,
      List<String> numbers,
      String date,
      String code,
      bool isActive,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.spacing(context, 16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: const Border(left: BorderSide(color: Color(0xFFFF6B35), width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(Responsive.spacing(context, 20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 16),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                    SizedBox(height: Responsive.spacing(context, 6)),
                    Text(
                      meta,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 13),
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.spacing(context, 12),
                  vertical: Responsive.spacing(context, 6),
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF10B981).withOpacity(0.1)
                      : const Color(0xFFFFD23F).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isActive ? 'ACTIVE' : 'PENDING',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 11),
                    fontWeight: FontWeight.w700,
                    color: isActive ? const Color(0xFF10B981) : const Color(0xFFD97706),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.spacing(context, 16)),

          Container(
            padding: EdgeInsets.all(Responsive.spacing(context, 16)),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Ticket Numbers',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 12),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                SizedBox(height: Responsive.spacing(context, 8)),
                Wrap(
                  spacing: Responsive.spacing(context, 8),
                  runSpacing: Responsive.spacing(context, 8),
                  children: numbers
                      .map((number) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.spacing(context, 12),
                      vertical: Responsive.spacing(context, 8),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFF6B35), width: 2),
                    ),
                    child: Text(
                      number,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFFF6B35),
                      ),
                    ),
                  ))
                      .toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 12)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Purchased: $date',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 12),
                  color: const Color(0xFF6B7280),
                ),
              ),
              Text(
                code,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 11),
                  color: const Color(0xFF6B7280),
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final BuildContext context;
  final String number;
  final String text;

  const _StatItem({
    required this.context,
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 28),
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 4)),
        Text(
          text,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 12),
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}