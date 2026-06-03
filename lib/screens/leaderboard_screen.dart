import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String _selectedTimeframe = 'Global';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {} catch (e) {
      print('Error loading leaderboard: $e');
    }
  }

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
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      SizedBox(width: Responsive.spacing(context, 8)),
                      Expanded(
                        child: Text(
                          'Leaderboard',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 20),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.spacing(context, 16)),

                  // Tabs
                  Row(
                    children: [
                      Expanded(child: _buildTab('Global')),
                      SizedBox(width: Responsive.spacing(context, 8)),
                      Expanded(child: _buildTab('Daily')),
                      SizedBox(width: Responsive.spacing(context, 8)),
                      Expanded(child: _buildTab('Weekly')),
                    ],
                  ),
                ],
              ),
            ),

            // My Rank Card (Sticky)
            Container(
              color: const Color(0xFFFFD23F).withOpacity(0.15),
              padding: EdgeInsets.all(Responsive.spacing(context, 16)),
              child: Row(
                children: [
                  Container(
                    width: Responsive.dimension(context, 50),
                    height: Responsive.dimension(context, 50),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B35),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '#32',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.spacing(context, 12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You (guest_123)',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 15),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                        Text(
                          'Best: 2100',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 13),
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '1250',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 20),
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFFF6B35),
                    ),
                  ),
                ],
              ),
            ),

            // Top List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(Responsive.spacing(context, 16)),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return _buildLeaderboardItem(
                    context,
                    index + 1,
                    [
                      'Ali',
                      'Sara',
                      'John',
                      'Emma',
                      'Rahul',
                      'Priya',
                      'Mike',
                      'Lisa',
                      'Tom',
                      'Nina',
                    ][index],
                    [
                      2450,
                      2100,
                      1980,
                      1850,
                      1720,
                      1650,
                      1580,
                      1500,
                      1450,
                      1400,
                    ][index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label) {
    final isSelected = _selectedTimeframe == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTimeframe = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Responsive.spacing(context, 10),
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF6B35) : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardItem(
    BuildContext context,
    int rank,
    String name,
    int score,
  ) {
    Color rankColor;
    if (rank == 1) {
      rankColor = const Color(0xFFFFD700); // Gold
    } else if (rank == 2) {
      rankColor = const Color(0xFFC0C0C0); // Silver
    } else if (rank == 3) {
      rankColor = const Color(0xFFCD7F32); // Bronze
    } else {
      rankColor = const Color(0xFF6B7280);
    }

    return Container(
      margin: EdgeInsets.only(bottom: Responsive.spacing(context, 12)),
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
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
      child: Row(
        children: [
          Container(
            width: Responsive.dimension(context, 40),
            height: Responsive.dimension(context, 40),
            decoration: BoxDecoration(
              color: rankColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  fontWeight: FontWeight.w800,
                  color: rankColor,
                ),
              ),
            ),
          ),
          SizedBox(width: Responsive.spacing(context, 12)),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 15),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A2E),
              ),
            ),
          ),
          Text(
            score.toString(),
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
    );
  }
}
