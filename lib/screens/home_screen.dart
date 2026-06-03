import 'package:flutter/material.dart';
import 'package:consumer_app/routes/app_pages.dart';
import 'package:go_router/go_router.dart';

import '../utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              padding: EdgeInsets.all(Responsive.spacing(context, 16)),
              child: Column(
                children: [
                  // Top Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                        ).createShader(bounds),
                        child: Text(
                          'CoupTick',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 24),
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          _buildIconButton('🎟️', 3),
                          SizedBox(width: Responsive.spacing(context, 12)),
                          _buildIconButton('🔔', 2),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.spacing(context, 20)),

                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search campaigns, prizes...',
                        hintStyle: TextStyle(
                          color: const Color(0xFF6B7280),
                          fontSize: Responsive.fontSize(context, 14),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: const Color(0xFF6B7280),
                          size: Responsive.iconSize(context, 20),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: Responsive.spacing(context, 12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quick Actions - NOW WITH PRODUCTS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildQuickAction(
                          '🛍️',
                          'Products',
                          const Color(0xFFFF6B35),
                          onTap: () {
                            context.goNamed(Routes.products);
                          },
                        ),
                        _buildQuickAction(
                          '🎮',
                          'Games',
                          const Color(0xFF667eea),
                          onTap: () {
                            context.goNamed(Routes.gamesHub);
                          },
                        ),
                        _buildQuickAction(
                          '🎫',
                          'Tickets',
                          const Color(0xFF4facfe),
                          onTap: () {
                            context.goNamed(Routes.ticketWallet);
                          },
                        ),
                        _buildQuickAction(
                          '🏆',
                          'Winners',
                          const Color(0xFF43e97b),
                          onTap: () {
                            context.pushNamed(Routes.winners);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.spacing(context, 24)),

                    // Featured Campaign
                    GestureDetector(
                      onTap: () => context.pushNamed(Routes.campaignDetail),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: EdgeInsets.all(
                          Responsive.spacing(context, 24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Responsive.spacing(context, 12),
                                vertical: Responsive.spacing(context, 6),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '🔥 TRENDING NOW',
                                style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 12),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: Responsive.spacing(context, 12)),
                            Text(
                              'Win iPhone 15 Pro Max!',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 22),
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: Responsive.spacing(context, 8)),
                            Text(
                              'Buy any phone & get instant tickets',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 14),
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            SizedBox(height: Responsive.spacing(context, 16)),
                            Row(
                              children: [
                                _buildStat('₹299', 'Per Play'),
                                SizedBox(
                                  width: Responsive.spacing(context, 20),
                                ),
                                _buildStat('₹1.2L', 'Prize'),
                                SizedBox(
                                  width: Responsive.spacing(context, 20),
                                ),
                                _buildStat('856', 'Playing'),
                              ],
                            ),
                            SizedBox(height: Responsive.spacing(context, 16)),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => context.pushNamed(Routes.gamePlay),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(0xFFFF6B35),
                                      padding: EdgeInsets.symmetric(
                                        vertical: Responsive.spacing(
                                          context,
                                          14,
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Text(
                                      '▶️ Play Now',
                                      style: TextStyle(
                                        fontSize: Responsive.fontSize(
                                          context,
                                          15,
                                        ),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Responsive.spacing(context, 12),
                                ),
                                ElevatedButton(
                                  onPressed: () => context.goNamed(Routes.products),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white.withOpacity(
                                      0.2,
                                    ),
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Responsive.spacing(
                                        context,
                                        20,
                                      ),
                                      vertical: Responsive.spacing(context, 14),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    '🛍️ Shop',
                                    style: TextStyle(
                                      fontSize: Responsive.fontSize(
                                        context,
                                        15,
                                      ),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.spacing(context, 24)),

                    // Section Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Active Campaigns',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 20),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'View All →',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 14),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFFF6B35),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.spacing(context, 16)),

                    // Campaigns Grid
                    GridView.count(
                      crossAxisCount: Responsive.isLargeScreen(context) ? 3 : 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: Responsive.spacing(context, 5),
                      mainAxisSpacing: Responsive.spacing(context, 10),
                      childAspectRatio: 0.68,
                      children: [
                        _buildCampaignCard(
                          '📱',
                          'Samsung Galaxy S24',
                          '₹80,000',
                          '₹199',
                          '1.2K left',
                          const LinearGradient(
                            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                          ),
                        ),
                        _buildCampaignCard(
                          '⌚',
                          'Apple Watch Ultra',
                          '₹60,000',
                          '₹149',
                          '890 left',
                          const LinearGradient(
                            colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
                          ),
                        ),
                        _buildCampaignCard(
                          '💻',
                          'MacBook Air M3',
                          '₹1,20,000',
                          '₹349',
                          '2.1K left',
                          const LinearGradient(
                            colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                          ),
                        ),
                        _buildCampaignCard(
                          '🎧',
                          'AirPods Pro Max',
                          '₹45,000',
                          '₹99',
                          '650 left',
                          const LinearGradient(
                            colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(String emoji, int badgeCount) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: Responsive.dimension(context, 40),
          height: Responsive.dimension(context, 40),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              emoji,
              style: TextStyle(fontSize: Responsive.fontSize(context, 20)),
            ),
          ),
        ),
        if (badgeCount > 0)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              width: Responsive.dimension(context, 18),
              height: Responsive.dimension(context, 18),
              decoration: const BoxDecoration(
                color: Color(0xFFFF6B35),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$badgeCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Responsive.fontSize(context, 10),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildQuickAction(
    String emoji,
    String label,
    Color color, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: Responsive.dimension(context, 56),
            height: Responsive.dimension(context, 56),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color, color.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                emoji,
                style: TextStyle(fontSize: Responsive.fontSize(context, 24)),
              ),
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 8)),
          Text(
            label,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 12),
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D3142),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 24),
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 12),
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildCampaignCard(
    String emoji,
    String title,
    String prize,
    String price,
    String ticketsLeft,
    Gradient gradient,
  ) {
    return GestureDetector(
      onTap: () => context.pushNamed(Routes.campaignDetail),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Responsive.dimension(context, 120),
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  emoji,
                  style: TextStyle(fontSize: Responsive.fontSize(context, 40)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Responsive.spacing(context, 12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Responsive.spacing(context, 6)),
                  Text(
                    'Prize: $prize',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 8)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.spacing(context, 10),
                          vertical: Responsive.spacing(context, 4),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD23F),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          price,
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 12),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                      ),
                      Text(
                        ticketsLeft,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 11),
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
    );
  }
}
