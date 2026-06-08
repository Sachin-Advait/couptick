import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/responsive.dart';

class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({super.key});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  bool _scratched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(Responsive.spacing(context, 16)),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.05)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'iPhone 15 Pro Max',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 16),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.spacing(context, 12),
                          vertical: Responsive.spacing(context, 6),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B35).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '⏱️ 0:45',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 14),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFFFD23F),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.spacing(context, 12)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.6,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFFF6B35),
                      ),
                      minHeight: Responsive.spacing(context, 8),
                    ),
                  ),
                ],
              ),
            ),

            // Game Area
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(Responsive.spacing(context, 32)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scratch & Win!',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 24),
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: Responsive.spacing(context, 12)),
                    Text(
                      'Scratch the card to reveal your tickets',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 15),
                        color: Colors.white.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Responsive.spacing(context, 40)),

                    // Stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStat(context, '5', 'Max Tickets'),
                        SizedBox(width: Responsive.spacing(context, 32)),
                        _buildStat(context, '₹299', 'Entry Fee'),
                      ],
                    ),
                    SizedBox(height: Responsive.spacing(context, 40)),

                    // Scratch Card
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _scratched = true;
                        });
                      },
                      child: Container(
                        width: Responsive.dimension(context, 280),
                        height: Responsive.dimension(context, 280),
                        decoration: BoxDecoration(
                          gradient: _scratched
                              ? null
                              : const LinearGradient(
                                  colors: [
                                    Color(0xFFC0C0C0),
                                    Color(0xFFE8E8E8),
                                  ],
                                ),
                          color: _scratched ? const Color(0xFF667eea) : null,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 40,
                            ),
                          ],
                        ),
                        child: Center(
                          child: _scratched
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '🎟️',
                                      style: TextStyle(
                                        fontSize: Responsive.fontSize(
                                          context,
                                          80,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Responsive.spacing(context, 16),
                                    ),
                                    Text(
                                      'You Won!',
                                      style: TextStyle(
                                        fontSize: Responsive.fontSize(
                                          context,
                                          20,
                                        ),
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Responsive.spacing(context, 8),
                                    ),
                                    Text(
                                      '3 Raffle Tickets',
                                      style: TextStyle(
                                        fontSize: Responsive.fontSize(
                                          context,
                                          15,
                                        ),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '👆',
                                      style: TextStyle(
                                        fontSize: Responsive.fontSize(
                                          context,
                                          60,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Responsive.spacing(context, 16),
                                    ),
                                    Text(
                                      'Scratch Here',
                                      style: TextStyle(
                                        fontSize: Responsive.fontSize(
                                          context,
                                          18,
                                        ),
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF1A1A2E),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Responsive.spacing(context, 8),
                                    ),
                                    Text(
                                      'Use your finger to scratch',
                                      style: TextStyle(
                                        fontSize: Responsive.fontSize(
                                          context,
                                          13,
                                        ),
                                        color: const Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.spacing(context, 40)),

                    // Action Buttons
                    if (_scratched) ...[
                      SizedBox(
                        width: Responsive.dimension(context, 280),
                        height: Responsive.dimension(context, 52),
                        child: ElevatedButton(
                          onPressed: () {
                            context.pushNamed(Routes.processingTickets);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF6B35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Continue to Tickets',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 15),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.spacing(context, 12)),
                      SizedBox(
                        width: Responsive.dimension(context, 280),
                        height: Responsive.dimension(context, 30),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.2),
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'View Campaign Details',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 15),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
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
            fontSize: Responsive.fontSize(context, 28),
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 4)),
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 12),
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
