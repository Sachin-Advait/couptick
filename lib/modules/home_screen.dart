import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

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

  // ─────────────────────────────────────────────
  //  2×2 QUICK ACTION GRID
  // ─────────────────────────────────────────────
  Widget _buildQuickActionGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 2.widthMultiplier,
      mainAxisSpacing: 12.heightMultiplier,
      childAspectRatio: 2.4,
      children: [
        _buildActionCard(
          label: 'Products',
          assetIcon: AppImages.products,
          onTap: () => context.pushNamed(Routes.products),
        ),
        _buildActionCard(
          label: 'Active Draws',
          assetIcon: AppImages.activeDraws,
          onTap: () {},
        ),
        _buildActionCard(
          label: 'E-Tickets',
          assetIcon: AppImages.eTicket,
          onTap: () => context.pushNamed(Routes.ticketWallet),
        ),
        _buildActionCard(
          label: 'E-Coupons',
          assetIcon: AppImages.eCoupon,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String label,
    required String assetIcon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.radiusMultipier),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.radiusMultipier),
          child: Stack(
            fit: StackFit.expand,
            children: [
              /// Card.png as the card background
              Image.asset(AppImages.card, fit: BoxFit.cover),
              Positioned(
                left: 14.widthMultiplier,
                top: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    label,
                    style: context.semiBold.copyWith(
                      fontSize: 13.textMultiplier,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

              /// icon (right, bottom-anchored)
              Positioned(
                right: 40.widthMultiplier,
                bottom: 20.heightMultiplier,
                child: Image.asset(
                  assetIcon,
                  width: 34.widthMultiplier,
                  height: 34.widthMultiplier,
                  fit: BoxFit.contain,
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
