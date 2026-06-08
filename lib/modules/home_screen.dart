import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:couptick/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum _CardBgRotation { normal, flipHorizontal, flipVertical, flipBoth }

class _HomeScreenState extends State<HomeScreen> {
  final PageController _featuredProductsController = PageController();
  final PageController _featuredDrawsController = PageController();
  int _productsPage = 0;
  int _drawsPage = 0;

  @override
  void dispose() {
    _featuredProductsController.dispose();
    _featuredDrawsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.bg2),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.widthMultiplier),
            child: Column(
              children: [
                /// ── TOP BAR ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome Abdul',
                      style: context.bold.copyWith(
                        fontSize: 24.textMultiplier,
                        color: AppColors.white,
                      ),
                    ),
                    Image.asset(
                      AppImages.notification,
                      width: 20.widthMultiplier,
                      height: 20.widthMultiplier,
                      color: AppColors.white,
                    ),
                  ],
                ),

                SizedBox(height: 16.heightMultiplier),

                /// ── SEARCH BAR ──
                Container(
                  height: 48.heightMultiplier,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(30.radiusMultipier),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 16.widthMultiplier),
                      Text(
                        'Search...',
                        style: context.regular.copyWith(
                          fontSize: 14.textMultiplier,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 14.widthMultiplier),
                        child: Image.asset(
                          AppImages.search,
                          width: 20.widthMultiplier,
                          height: 20.widthMultiplier,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50.heightMultiplier),

                /// ── SCROLLABLE BODY ──
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildQuickActionGrid(),
                        SizedBox(height: 20.heightMultiplier),
                        _buildFeaturedRow(),
                        SizedBox(height: 20.heightMultiplier),
                        _trendingNow(),
                        40.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _trendingNow() {
    return GestureDetector(
      onTap: () => context.pushNamed(Routes.campaignDetail),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, Color(0xFF1a5d7a)],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        padding: EdgeInsets.all(Responsive.spacing(context, 24)),
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
                SizedBox(width: Responsive.spacing(context, 20)),
                _buildStat('₹1.2L', 'Prize'),
                SizedBox(width: Responsive.spacing(context, 20)),
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
                        vertical: Responsive.spacing(context, 14),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text('▶️ Play Now', style: context.bold),
                  ),
                ),
                SizedBox(width: Responsive.spacing(context, 12)),
                ElevatedButton(
                  onPressed: () => context.pushNamed(Routes.products),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.spacing(context, 20),
                      vertical: Responsive.spacing(context, 14),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    '🛍️ Shop',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 15),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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

  Widget _buildQuickActionGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12.widthMultiplier,
      mainAxisSpacing: 12.heightMultiplier,
      childAspectRatio: 2.4,
      children: [
        _buildActionCard(
          label: 'Products',
          assetIcon: AppImages.products,
          bgRotation: _CardBgRotation.normal,
          labelOnLeft: true,
          onTap: () => context.pushNamed(Routes.products),
        ),
        _buildActionCard(
          label: 'Active Draws',
          assetIcon: AppImages.activeDraws,
          bgRotation: _CardBgRotation.flipHorizontal,
          labelOnLeft: false,
          onTap: () {},
        ),
        _buildActionCard(
          label: 'E-Tickets',
          assetIcon: AppImages.eTicket,
          bgRotation: _CardBgRotation.flipVertical,
          labelOnLeft: true,
          onTap: () => context.pushNamed(Routes.ticketWallet),
        ),
        _buildActionCard(
          label: 'E-Coupons',
          assetIcon: AppImages.eCoupon,
          bgRotation: _CardBgRotation.flipBoth,
          labelOnLeft: false,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String label,
    required String assetIcon,
    required VoidCallback onTap,
    _CardBgRotation bgRotation = _CardBgRotation.normal,
    bool labelOnLeft = true,
  }) {
    Widget bg = Image.asset(AppImages.card, fit: BoxFit.cover);

    Widget rotatedBg;
    switch (bgRotation) {
      case _CardBgRotation.normal:
        rotatedBg = bg;
        break;
      case _CardBgRotation.flipHorizontal:
        // Mirror horizontally — blob flips to the other side
        rotatedBg = Transform.scale(scaleX: -1, child: bg);
        break;
      case _CardBgRotation.flipVertical:
        // Flip vertically — blob moves to top
        rotatedBg = Transform.scale(scaleY: -1, child: bg);
        break;
      case _CardBgRotation.flipBoth:
        // Mirror + flip — blob moves to top opposite side
        rotatedBg = Transform.scale(scaleX: -1, scaleY: -1, child: bg);
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.radiusMultipier),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.radiusMultipier),
          child: Stack(
            fit: StackFit.expand,
            children: [
              /// Background
              rotatedBg,

              /// Icon — opposite side from label
              Positioned(
                left: labelOnLeft ? null : 18.widthMultiplier,
                right: labelOnLeft ? 25.widthMultiplier : null,
                bottom: 10.heightMultiplier,
                child: Image.asset(
                  assetIcon,
                  width: 50.widthMultiplier,
                  height: 50.widthMultiplier,
                  fit: BoxFit.contain,
                ),
              ),

              /// Label — left or right
              Positioned(
                left: labelOnLeft ? 14.widthMultiplier : null,
                right: labelOnLeft ? null : 10.widthMultiplier,
                top: 0,
                bottom: 0,
                child: Align(
                  alignment: labelOnLeft
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Text(
                    label,
                    style: context.semiBold.copyWith(
                      fontSize: 13.textMultiplier,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  FEATURED ROW  (Products | Draws)
  // ─────────────────────────────────────────────
  Widget _buildFeaturedRow() {
    return Row(
      children: [
        Expanded(child: _buildFeaturedCard(isFeaturedProducts: true)),
        SizedBox(width: 12.widthMultiplier),
        Expanded(child: _buildFeaturedCard(isFeaturedProducts: false)),
      ],
    );
  }

  Widget _buildFeaturedCard({required bool isFeaturedProducts}) {
    final controller = isFeaturedProducts
        ? _featuredProductsController
        : _featuredDrawsController;
    final currentPage = isFeaturedProducts ? _productsPage : _drawsPage;
    final bgImage = isFeaturedProducts ? AppImages.card2 : AppImages.card3;
    final heroImage = isFeaturedProducts
        ? AppImages.laptop
        : AppImages.headphone;
    final title = isFeaturedProducts ? 'Featured\nProducts' : 'Featured\nDraws';
    final subtitle = isFeaturedProducts
        ? 'Handpicked favorites,\nchosen for quality and\nperformance.'
        : 'Highlighted draws,\nchosen for quality.';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(20.radiusMultipier),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 160.heightMultiplier,
            child: PageView(
              controller: controller,
              onPageChanged: (p) => setState(() {
                if (isFeaturedProducts) {
                  _productsPage = p;
                } else {
                  _drawsPage = p;
                }
              }),
              children: [
                _heroImage(heroImage),
                _heroImage(heroImage),
                _heroImage(heroImage),
              ],
            ),
          ),

          /// Text + dots
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: context.bold.copyWith(
                  fontSize: 14.textMultiplier,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4.heightMultiplier),
              Text(
                subtitle,
                style: context.regular.copyWith(
                  fontSize: 11.textMultiplier,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 10.heightMultiplier),

              /// page indicator dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) {
                  final active = i == currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.symmetric(horizontal: 3.widthMultiplier),
                    width: 6.widthMultiplier,
                    height: 6.widthMultiplier,
                    decoration: BoxDecoration(
                      color: active ? AppColors.primary : AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              10.verticalSpace,
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroImage(String asset) {
    return Padding(
      padding: EdgeInsets.all(12.widthMultiplier),
      child: Image.asset(asset, fit: BoxFit.contain),
    );
  }
}
