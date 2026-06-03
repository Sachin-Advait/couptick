import 'package:flutter/material.dart';
import 'package:consumer_app/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import '../utils/responsive.dart';

class MyWinsScreen extends StatelessWidget {
  const MyWinsScreen({super.key});

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
              child: Row(
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
                    '🏆 My Wins',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 24),
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
            ),

            // Stats Banner
            Container(
              margin: EdgeInsets.all(Responsive.spacing(context, 20)),
              padding: EdgeInsets.all(Responsive.spacing(context, 24)),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat(context, '2', 'Total Wins'),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  _buildStat(context, '₹1.8L', 'Total Value'),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  _buildStat(context, '1', 'Claimed'),
                ],
              ),
            ),

            // Wins List
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.spacing(context, 20),
                ),
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
            fontSize: Responsive.fontSize(context, 24),
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 4)),
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 12),
            color: Colors.white.withOpacity(0.9),
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
      margin: EdgeInsets.only(bottom: Responsive.spacing(context, 16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border(
          left: BorderSide(
            color: claimed ? const Color(0xFF10B981) : const Color(0xFFFFD23F),
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Responsive.spacing(context, 20)),
            child: Row(
              children: [
                Container(
                  width: Responsive.dimension(context, 70),
                  height: Responsive.dimension(context, 70),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      emoji,
                      style: TextStyle(fontSize: Responsive.fontSize(context, 36)),
                    ),
                  ),
                ),
                SizedBox(width: Responsive.spacing(context, 16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prize,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 16),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                      SizedBox(height: Responsive.spacing(context, 4)),
                      Text(
                        'Worth $value',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 15),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFF6B35),
                        ),
                      ),
                      SizedBox(height: Responsive.spacing(context, 8)),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: Responsive.iconSize(context, 14),
                            color: const Color(0xFF6B7280),
                          ),
                          SizedBox(width: Responsive.spacing(context, 4)),
                          Text(
                            date,
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 12),
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                          SizedBox(width: Responsive.spacing(context, 12)),
                          Text(
                            'Ticket: $ticketNum',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 12),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF6B7280),
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
          Container(
            padding: EdgeInsets.all(Responsive.spacing(context, 16)),
            decoration: BoxDecoration(
              color: claimed
                  ? const Color(0xFF10B981).withOpacity(0.1)
                  : const Color(0xFFFFD23F).withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      claimed ? Icons.check_circle : Icons.pending,
                      size: Responsive.iconSize(context, 18),
                      color: claimed
                          ? const Color(0xFF10B981)
                          : const Color(0xFFD97706),
                    ),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                        fontWeight: FontWeight.w600,
                        color: claimed
                            ? const Color(0xFF10B981)
                            : const Color(0xFFD97706),
                      ),
                    ),
                  ],
                ),
                if (!claimed)
                  TextButton(
                    onPressed: () {
                      context.pushNamed(Routes.claimForm, extra: {
                          'prize': prize,
                          'value': value,
                          'ticketNum': ticketNum,
                        },
                      );
                    },
                    child: Text(
                      'Claim Now →',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFFF6B35),
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