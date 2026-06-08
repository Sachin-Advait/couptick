import 'package:flutter/material.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import '../utils/responsive.dart';

class CampaignDetailScreen extends StatelessWidget {
  const CampaignDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Hero Section
                Container(
                  height: Responsive.dimension(context, 380),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Container(
                              padding: EdgeInsets.all(Responsive.spacing(context, 8)),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: Responsive.iconSize(context, 20),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Responsive.spacing(context, 16),
                                    vertical: Responsive.spacing(context, 6),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '🔥 HOT CAMPAIGN',
                                    style: TextStyle(
                                      fontSize: Responsive.fontSize(context, 12),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: Responsive.spacing(context, 16)),
                                Text(
                                  '📱',
                                  style: TextStyle(fontSize: Responsive.fontSize(context, 100)),
                                ),
                                SizedBox(height: Responsive.spacing(context, 16)),
                                Text(
                                  'iPhone 15 Pro Max',
                                  style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 2),
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: Responsive.spacing(context, 8)),
                                Text(
                                  'Prize Worth ₹1,20,000',
                                  style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 11),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Content Section
                Transform.translate(
                  offset: Offset(0, Responsive.spacing(context, -32)),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(Responsive.spacing(context, 24)),
                      child: Column(
                        children: [
                          // Stats Row
                          Row(
                            children: [
                              Expanded(child: _buildStatCard(context, '₹299', 'Per Play')),
                              SizedBox(width: Responsive.spacing(context, 12)),
                              Expanded(child: _buildStatCard(context, '2.4K', 'Playing')),
                              SizedBox(width: Responsive.spacing(context, 12)),
                              Expanded(child: _buildStatCard(context, '12', 'Days Left')),
                            ],
                          ),
                          SizedBox(height: Responsive.spacing(context, 24)),

                          // Participants Preview
                          Row(
                            children: [
                              Stack(
                                children: List.generate(5, (index) {
                                  return Transform.translate(
                                    offset: Offset(index * Responsive.dimension(context, 24), 0),
                                    child: Container(
                                      width: Responsive.dimension(context, 36),
                                      height: Responsive.dimension(context, 36),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                                        ),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                      child: Center(
                                        child: Text(
                                          index < 4 ? ['A', 'R', 'S', 'M'][index] : '+',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: Responsive.fontSize(context, 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(width: Responsive.spacing(context, 130)),
                              Expanded(
                                child: Text(
                                  '2,456 people are playing',
                                  style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 13),
                                    color: const Color(0xFF6B7280),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.spacing(context, 24)),

                          // Campaign Details
                          _buildSection(
                            context,
                            'Campaign Details',
                            Container(
                              padding: EdgeInsets.all(Responsive.spacing(context, 16)),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  _buildInfoRow(context, 'Start Date', 'Jan 15, 2026'),
                                  _buildInfoRow(context, 'End Date', 'Feb 20, 2026'),
                                  _buildInfoRow(context, 'Draw Date', 'Feb 22, 2026'),
                                  _buildInfoRow(context, 'Max Tickets', '10,000', isLast: true),
                                ],
                              ),
                            ),
                          ),

                          // About
                          _buildSection(
                            context,
                            'About This Campaign',
                            Text(
                              'Win the latest iPhone 15 Pro Max (256GB) in Titanium Blue! Purchase any mobile phone from our partner stores and get instant raffle tickets. The more you buy, the higher your chances to win this amazing prize worth ₹1,20,000!',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 14),
                                color: const Color(0xFF2D3142),
                                height: 1.6,
                              ),
                            ),
                          ),

                          // How to Play
                          _buildSection(
                            context,
                            'How to Play',
                            Column(
                              children: [
                                _buildRuleItem(context, 'Buy any eligible product from partner stores'),
                                _buildRuleItem(context, 'Pay ₹299 to enter the campaign'),
                                _buildRuleItem(context, 'Play the instant game to reveal your tickets'),
                                _buildRuleItem(context, 'Get up to 5 raffle tickets per entry'),
                                _buildRuleItem(context, 'Winner announced on draw date via live stream'),
                              ],
                            ),
                          ),

                          SizedBox(height: Responsive.spacing(context, 100)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Action
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(
                Responsive.spacing(context, 20),
                Responsive.spacing(context, 16),
                Responsive.spacing(context, 20),
                Responsive.spacing(context, 32),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Entry Fee',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                      Text(
                        '₹299',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 28),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFFF6B35),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.spacing(context, 16)),
                  SizedBox(
                    width: double.infinity,
                    height: Responsive.dimension(context, 56),
                    child: ElevatedButton(
                      onPressed: () => context.pushNamed(Routes.gamePlay),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                        shadowColor: const Color(0xFFFF6B35).withOpacity(0.3),
                      ),
                      child: Text(
                        '▶️ Play Now & Win',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 16),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label) {
    return Container(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 22),
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A1A2E),
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 4)),
          Text(
            label,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 11),
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.spacing(context, 24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E),
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 12)),
          content,
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : Responsive.spacing(context, 10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              color: const Color(0xFF6B7280),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRuleItem(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.spacing(context, 8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '✓ ',
            style: TextStyle(
              color: const Color(0xFF10B981),
              fontWeight: FontWeight.bold,
              fontSize: Responsive.fontSize(context, 16),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 13),
                color: const Color(0xFF2D3142),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}