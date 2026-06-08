import 'package:flutter/material.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import '../utils/responsive.dart';

class WinnersScreen extends StatelessWidget {
  const WinnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
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
                        '🏆 Winners',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 28),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.spacing(context, 20)),
                  Row(
                    children: [
                      Expanded(child: _buildTab(context, 'Recent Winners', true)),
                      SizedBox(width: Responsive.spacing(context, 12)),
                      Expanded(child: _buildTab(context, 'My Wins', false, onTap: () {
                        context.pushNamed(Routes.myWins);
                      })),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.all(Responsive.spacing(context, 20)),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, String label, bool isActive, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Responsive.spacing(context, 12)),
        decoration: BoxDecoration(
          gradient: isActive ? const LinearGradient(
            colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
          ) : null,
          color: isActive ? null : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 15),
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : const Color(0xFF6B7280),
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
            children: [
              Container(
                width: Responsive.dimension(context, 60),
                height: Responsive.dimension(context, 60),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    avatar,
                    style: TextStyle(fontSize: Responsive.fontSize(context, 28)),
                  ),
                ),
              ),
              SizedBox(width: Responsive.spacing(context, 16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 17),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                    SizedBox(height: Responsive.spacing(context, 4)),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 13),
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    SizedBox(height: Responsive.spacing(context, 8)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.spacing(context, 12),
                        vertical: Responsive.spacing(context, 4),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        date,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 12),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF10B981),
                        ),
                      ),
                    ),
                  ],
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
                  'Prize Won',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 12),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                SizedBox(height: Responsive.spacing(context, 6)),
                Text(
                  prize,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 18),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
                SizedBox(height: Responsive.spacing(context, 4)),
                Text(
                  'Worth $prizeValue',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 16),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFF6B35),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 16)),

          Row(
            children: [
              Expanded(
                child: _buildStatBox(context, ticketNum, 'Ticket #'),
              ),
              SizedBox(width: Responsive.spacing(context, 16)),
              Expanded(
                child: _buildStatBox(context, totalEntries, 'Total Entries'),
              ),
              SizedBox(width: Responsive.spacing(context, 16)),
              Expanded(
                child: _buildStatBox(context, odds, 'Odds'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(BuildContext context, String value, String label) {
    return Container(
      padding: EdgeInsets.all(Responsive.spacing(context, 12)),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A1A2E),
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 4)),
          Text(
            label,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 11),
              color: const Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}