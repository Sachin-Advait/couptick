import 'package:confetti/confetti.dart';
import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  final String campaignName = 'iPhone 15 Pro Max';
  final int ticketsAwarded = 3;
  final List<String> ticketNumbers = ['#2451', '#2452', '#2453'];
  final String drawDate = 'Feb 22, 2026';
  final String drawTime = '6:00 PM';

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

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

    Future.delayed(const Duration(milliseconds: 300), () {
      _confettiController.play();
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D2233),
      body: Stack(
        children: [
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
                AppColors.secondary,
                AppColors.warning,
                AppColors.success,
                AppColors.info,
                Color(0xFFf093fb),
              ],
            ),
          ),
          Positioned(
            left: 20,
            top: 70,
            child: InkWell(
              onTap: () => context.goNamed(Routes.home),
              child: Container(
                padding: EdgeInsets.all(8.widthMultiplier),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.radiusMultipier),
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: AppColors.white,
                  size: 18.widthMultiplier,
                ),
              ),
            ),
          ),

          Column(
            children: [
              40.verticalSpace,
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16.widthMultiplier),
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: 24.heightMultiplier),

                    // Success icon
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          width: 130.widthMultiplier,
                          height: 130.widthMultiplier,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, Color(0xFF1A6B8A)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.35),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '🎟️',
                              style: TextStyle(fontSize: 58.textMultiplier),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.heightMultiplier),

                    // Heading
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            'Congratulations! 🎉',
                            style: context.extraBold.copyWith(
                              fontSize: 26.textMultiplier,
                              color: AppColors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8.heightMultiplier),
                          Text(
                            "You've Won Raffle Tickets!",
                            style: context.regular.copyWith(
                              fontSize: 15.textMultiplier,
                              color: AppColors.white.withOpacity(0.75),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28.heightMultiplier),

                    // Campaign info card
                    Container(
                      padding: EdgeInsets.all(22.widthMultiplier),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(24.radiusMultipier),
                        border: Border.all(
                          color: AppColors.white.withOpacity(0.15),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Campaign name
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.widthMultiplier),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(
                                    12.radiusMultipier,
                                  ),
                                ),
                                child: Icon(
                                  Icons.emoji_events_rounded,
                                  color: AppColors.warning,
                                  size: 22.widthMultiplier,
                                ),
                              ),
                              SizedBox(width: 12.widthMultiplier),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Campaign',
                                      style: context.regular.copyWith(
                                        fontSize: 11.textMultiplier,
                                        color: AppColors.white.withOpacity(
                                          0.55,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      campaignName,
                                      style: context.bold.copyWith(
                                        fontSize: 16.textMultiplier,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18.heightMultiplier),

                          // Ticket count block
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.widthMultiplier,
                              vertical: 18.heightMultiplier,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.primary, Color(0xFF1A6B8A)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(
                                16.radiusMultipier,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ticketsAwarded.toString(),
                                  style: context.extraBold.copyWith(
                                    fontSize: 44.textMultiplier,
                                    color: AppColors.white,
                                  ),
                                ),
                                SizedBox(width: 12.widthMultiplier),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Raffle',
                                      style: context.regular.copyWith(
                                        fontSize: 13.textMultiplier,
                                        color: AppColors.white.withOpacity(
                                          0.85,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Tickets',
                                      style: context.bold.copyWith(
                                        fontSize: 18.textMultiplier,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 18.heightMultiplier),

                          // Ticket numbers
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Ticket Numbers',
                                style: context.semiBold.copyWith(
                                  fontSize: 13.textMultiplier,
                                  color: AppColors.white.withOpacity(0.65),
                                ),
                              ),
                              SizedBox(height: 10.heightMultiplier),
                              Wrap(
                                spacing: 8.widthMultiplier,
                                runSpacing: 8.heightMultiplier,
                                children: ticketNumbers.map((number) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14.widthMultiplier,
                                      vertical: 10.heightMultiplier,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(
                                        12.radiusMultipier,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary.withOpacity(
                                            0.25,
                                          ),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      number,
                                      style: context.extraBold.copyWith(
                                        fontSize: 16.textMultiplier,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          SizedBox(height: 18.heightMultiplier),

                          // Draw info
                          Container(
                            padding: EdgeInsets.all(14.widthMultiplier),
                            decoration: BoxDecoration(
                              color: AppColors.warning.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(
                                12.radiusMultipier,
                              ),
                              border: Border.all(
                                color: AppColors.warning.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  color: AppColors.warning,
                                  size: 18.widthMultiplier,
                                ),
                                SizedBox(width: 10.widthMultiplier),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Draw Date',
                                        style: context.regular.copyWith(
                                          fontSize: 11.textMultiplier,
                                          color: AppColors.white.withOpacity(
                                            0.55,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '$drawDate • $drawTime',
                                        style: context.semiBold.copyWith(
                                          fontSize: 14.textMultiplier,
                                          color: AppColors.white,
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
                    SizedBox(height: 20.heightMultiplier),

                    // Info message
                    Container(
                      padding: EdgeInsets.all(14.widthMultiplier),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14.radiusMultipier),
                        border: Border.all(
                          color: AppColors.success.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.success,
                            size: 18.widthMultiplier,
                          ),
                          SizedBox(width: 10.widthMultiplier),
                          Expanded(
                            child: Text(
                              'Your tickets have been added to your wallet. Good luck!',
                              style: context.regular.copyWith(
                                fontSize: 12.textMultiplier,
                                color: AppColors.white.withOpacity(0.85),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.heightMultiplier),
                  ],
                ),
              ),

              // Action buttons
              Container(
                padding: EdgeInsets.all(20.widthMultiplier),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.05),
                  border: Border(
                    top: BorderSide(color: AppColors.white.withOpacity(0.1)),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 52.heightMultiplier,
                      child: ElevatedButton(
                        onPressed: () => context.pushNamed(Routes.ticketWallet),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              16.radiusMultipier,
                            ),
                          ),
                        ),
                        child: Text(
                          'View My Tickets',
                          style: context.bold.copyWith(
                            fontSize: 15.textMultiplier,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.heightMultiplier),
                    SizedBox(
                      width: double.infinity,
                      height: 52.heightMultiplier,
                      child: OutlinedButton(
                        onPressed: () => context.pushNamed(Routes.home),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: AppColors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              16.radiusMultipier,
                            ),
                          ),
                        ),
                        child: Text(
                          'Back to Home',
                          style: context.bold.copyWith(
                            fontSize: 15.textMultiplier,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    90.verticalSpace,
                  ],
                ),
              ),
            ],
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
