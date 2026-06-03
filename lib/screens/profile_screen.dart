import 'package:flutter/material.dart';
import 'package:consumer_app/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import '../utils/responsive.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                    'My Profile',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 24),
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                children: [
                  // Profile Card
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.all(Responsive.spacing(context, 24)),
                    child: Column(
                      children: [
                        Container(
                          width: Responsive.dimension(context, 80),
                          height: Responsive.dimension(context, 80),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '👤',
                              style: TextStyle(fontSize: Responsive.fontSize(context, 40)),
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.spacing(context, 16)),
                        Text(
                          'Guest User',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 20),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: Responsive.spacing(context, 6)),
                        Text(
                          'guest_123@temp.com',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 14),
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 24)),

                  // Stats Section
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
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
                        Text(
                          'Your Stats',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 18),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                        SizedBox(height: Responsive.spacing(context, 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStat(context, '24', 'Total Tickets'),
                            _buildStat(context, '6', 'Active'),
                            _buildStat(context, '₹1.8K', 'Invested'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 16)),

                  // Menu Items
                  _buildMenuItem(context, Icons.emoji_events, 'My Wins', () {
                    context.pushNamed(Routes.myWins);
                  }),
                  _buildMenuItem(context, Icons.account_balance_wallet, 'Wallet', () {}),
                  _buildMenuItem(context, Icons.receipt_long, 'Transactions', () {
                    context.pushNamed(Routes.transactions);
                  }),
                  _buildMenuItem(context, Icons.settings, 'Settings', () {}),
                  _buildMenuItem(context, Icons.help_outline, 'Help & Support', () {}),
                  _buildMenuItem(context, Icons.logout, 'Logout', () {
                    context.goNamed(Routes.login);
                  }, isLast: true),
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
            color: const Color(0xFFFF6B35),
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 4)),
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 12),
            color: const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, VoidCallback onTap, {bool isLast = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : Responsive.spacing(context, 12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: EdgeInsets.all(Responsive.spacing(context, 8)),
          decoration: BoxDecoration(
            color: const Color(0xFFFF6B35).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFFFF6B35), size: Responsive.iconSize(context, 20)),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 15),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A2E),
          ),
        ),
        trailing: Icon(Icons.chevron_right, size: Responsive.iconSize(context, 20)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Responsive.spacing(context, 16),
          vertical: Responsive.spacing(context, 4),
        ),
      ),
    );
  }
}