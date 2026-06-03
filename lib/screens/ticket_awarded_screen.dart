import 'package:flutter/material.dart';
import 'package:consumer_app/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import 'package:confetti/confetti.dart';
import '../utils/responsive.dart';

class TicketsAwardedScreen extends StatefulWidget {
  const TicketsAwardedScreen({super.key});

  @override
  State<TicketsAwardedScreen> createState() => _TicketsAwardedScreenState();
}

class _TicketsAwardedScreenState extends State<TicketsAwardedScreen>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  // Sample data - in real app this would come from route arguments
  final String campaignName = 'iPhone 15 Pro Max';
  final int ticketsAwarded = 3;
  final List<String> ticketNumbers = ['#2451', '#2452', '#2453'];
  final String drawDate = 'Feb 22, 2026';
  final String drawTime = '6:00 PM';

  @override
  void initState() {
    super.initState();

    // Confetti controller
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    // Animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Start animations
    Future.delayed(const Duration(milliseconds: 300), () {
      _confettiController.play();
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Stack(
        children: [
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.05,
              shouldLoop: false,
              colors: const [
                Color(0xFFFF6B35),
                Color(0xFFFFD23F),
                Color(0xFF10B981),
                Color(0xFF667eea),
                Color(0xFFf093fb),
              ],
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Container(
                          padding: EdgeInsets.all(Responsive.spacing(context, 8)),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: Responsive.iconSize(context, 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(Responsive.spacing(context, 24)),
                    child: Column(
                      children: [
                        SizedBox(height: Responsive.spacing(context, 40)),

                        // Success Animation
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: Container(
                              width: Responsive.dimension(context, 140),
                              height: Responsive.dimension(context, 140),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF6B35).withOpacity(0.3),
                                    blurRadius: 30,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  '🎟️',
                                  style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 70),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.spacing(context, 32)),

                        // Success Message
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                'Congratulations! 🎉',
                                style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 32),
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: Responsive.spacing(context, 12)),
                              Text(
                                'You\'ve Won Raffle Tickets!',
                                style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 18),
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Responsive.spacing(context, 40)),

                        // Campaign Info Card
                        Container(
                          padding: EdgeInsets.all(Responsive.spacing(context, 24)),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Campaign Name
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                      Responsive.spacing(context, 8),
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF6B35).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.emoji_events,
                                      color: const Color(0xFFFFD23F),
                                      size: Responsive.iconSize(context, 24),
                                    ),
                                  ),
                                  SizedBox(width: Responsive.spacing(context, 12)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Campaign',
                                          style: TextStyle(
                                            fontSize: Responsive.fontSize(context, 12),
                                            color: Colors.white.withOpacity(0.6),
                                          ),
                                        ),
                                        Text(
                                          campaignName,
                                          style: TextStyle(
                                            fontSize: Responsive.fontSize(context, 18),
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Responsive.spacing(context, 20)),

                              // Tickets Count
                              Container(
                                padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      ticketsAwarded.toString(),
                                      style: TextStyle(
                                        fontSize: Responsive.fontSize(context, 48),
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: Responsive.spacing(context, 12)),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Raffle',
                                          style: TextStyle(
                                            fontSize: Responsive.fontSize(context, 14),
                                            color: Colors.white.withOpacity(0.9),
                                          ),
                                        ),
                                        Text(
                                          'Tickets',
                                          style: TextStyle(
                                            fontSize: Responsive.fontSize(context, 20),
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Responsive.spacing(context, 20)),

                              // Ticket Numbers
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your Ticket Numbers',
                                    style: TextStyle(
                                      fontSize: Responsive.fontSize(context, 14),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                  SizedBox(height: Responsive.spacing(context, 12)),
                                  Wrap(
                                    spacing: Responsive.spacing(context, 8),
                                    runSpacing: Responsive.spacing(context, 8),
                                    children: ticketNumbers.map((number) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Responsive.spacing(context, 16),
                                          vertical: Responsive.spacing(context, 10),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFFF6B35)
                                                  .withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          number,
                                          style: TextStyle(
                                            fontSize: Responsive.fontSize(context, 18),
                                            fontWeight: FontWeight.w800,
                                            color: const Color(0xFFFF6B35),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              SizedBox(height: Responsive.spacing(context, 20)),

                              // Draw Info
                              Container(
                                padding: EdgeInsets.all(Responsive.spacing(context, 16)),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFD23F).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFFFD23F).withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: const Color(0xFFFFD23F),
                                      size: Responsive.iconSize(context, 20),
                                    ),
                                    SizedBox(width: Responsive.spacing(context, 12)),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Draw Date',
                                            style: TextStyle(
                                              fontSize: Responsive.fontSize(context, 12),
                                              color: Colors.white.withOpacity(0.6),
                                            ),
                                          ),
                                          Text(
                                            '$drawDate • $drawTime',
                                            style: TextStyle(
                                              fontSize: Responsive.fontSize(context, 15),
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
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
                        ),
                        SizedBox(height: Responsive.spacing(context, 32)),

                        // Info Message
                        Container(
                          padding: EdgeInsets.all(Responsive.spacing(context, 16)),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF10B981).withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: const Color(0xFF10B981),
                                size: Responsive.iconSize(context, 20),
                              ),
                              SizedBox(width: Responsive.spacing(context, 12)),
                              Expanded(
                                child: Text(
                                  'Your tickets have been added to your wallet. Good luck!',
                                  style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 13),
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Action Buttons
                Container(
                  padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: Responsive.dimension(context, 52),
                        child: ElevatedButton(
                          onPressed: () {
                            context.goNamed(Routes.ticketWallet);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF6B35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'View My Tickets',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 16),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.spacing(context, 12)),
                      SizedBox(
                        width: double.infinity,
                        height: Responsive.dimension(context, 52),
                        child: OutlinedButton(
                          onPressed: () {
                            context.goNamed(Routes.home);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Back to Home',
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}