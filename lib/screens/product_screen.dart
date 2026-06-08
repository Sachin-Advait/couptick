import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _selectedCategory = 'All';
  String _selectedFilter = 'All Products';

  final List<String> _categories = [
    'All',
    'Electronics',
    'Fashion',
    'Home & Living',
    'Sports',
    'Beauty',
  ];

  final List<String> _filters = [
    'All Products',
    'With Active Campaigns',
    'Best Offers',
    'New Arrivals',
  ];

  final List<Map<String, dynamic>> _featuredProducts = [
    {
      'emoji': '📱',
      'title': 'iPhone 15 Pro',
      'category': 'Electronics',
      'price': '₹1,29,999',
      'campaign': 'Win iPhone 15 Pro Max',
      'entry': '₹299',
      'hasCampaign': true,
      'gradient': const LinearGradient(
        colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
      ),
    },
    {
      'emoji': '⌚',
      'title': 'Apple Watch Ultra',
      'category': 'Electronics',
      'price': '₹89,999',
      'campaign': 'Win Apple Watch',
      'entry': '₹149',
      'hasCampaign': true,
      'gradient': LinearGradient(
        colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
      ),
    },
    {
      'emoji': '💻',
      'title': 'MacBook Air M3',
      'category': 'Electronics',
      'price': '₹1,14,999',
      'campaign': 'Win MacBook',
      'entry': '₹349',
      'hasCampaign': true,
      'gradient': const LinearGradient(
        colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
      ),
    },
    {
      'emoji': '🎧',
      'title': 'AirPods Pro Max',
      'category': 'Electronics',
      'price': '₹59,999',
      'campaign': 'Win AirPods',
      'entry': '₹99',
      'hasCampaign': true,
      'gradient': const LinearGradient(
        colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
      ),
    },
  ];

  final List<Map<String, dynamic>> _listProducts = [
    {
      'emoji': '📷',
      'title': 'Canon EOS R6',
      'category': 'Electronics',
      'price': '₹2,29,999',
      'seller': 'Digital Camera Store',
      'hasCampaign': false,
    },
    {
      'emoji': '🎸',
      'title': 'Fender Stratocaster',
      'category': 'Music',
      'price': '₹89,999',
      'seller': 'Music World',
      'hasCampaign': false,
    },
    {
      'emoji': '🚴',
      'title': 'Mountain Bike Pro',
      'category': 'Sports',
      'price': '₹45,999',
      'seller': 'Sports Arena',
      'hasCampaign': true,
      'campaign': 'Win Bike Gear',
      'entry': '₹99',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          if (_selectedFilter != 'All Products') _buildFilterBadge(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 16.widthMultiplier,
                vertical: 20.heightMultiplier,
              ),
              children: [
                _buildSectionRow(context, 'Featured Products'),
                SizedBox(height: 14.heightMultiplier),
                GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.widthMultiplier,
                    mainAxisSpacing: 12.heightMultiplier,
                    childAspectRatio: 0.56,
                  ),
                  itemCount: _featuredProducts.length,
                  itemBuilder: (_, i) =>
                      _buildProductCard(context, _featuredProducts[i]),
                ),
                SizedBox(height: 28.heightMultiplier),
                _buildSectionRow(context, 'All Products', showViewAll: false),
                SizedBox(height: 14.heightMultiplier),
                ..._listProducts.map((p) => _buildListItem(context, p)),
                100.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12.heightMultiplier,
        left: 20.widthMultiplier,
        right: 12.widthMultiplier,
        bottom: 16.heightMultiplier,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Products',
                style: context.extraBold.copyWith(
                  fontSize: 22.textMultiplier,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                children: [
                  _iconBtn(AppImages.search, () {}),
                  SizedBox(width: 8.widthMultiplier),
                  _iconBtn(
                    null,
                    () => _showFilterSheet(context),
                    fallback: Icons.tune_rounded,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4.heightMultiplier),
          Text(
            'Browse products & win prizes',
            style: context.regular.copyWith(
              fontSize: 13.textMultiplier,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 16.heightMultiplier),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((c) {
                final sel = _selectedCategory == c;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = c),
                  child: Container(
                    margin: EdgeInsets.only(right: 8.widthMultiplier),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.widthMultiplier,
                      vertical: 8.heightMultiplier,
                    ),
                    decoration: BoxDecoration(
                      color: sel ? AppColors.primary : AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(20.radiusMultipier),
                    ),
                    child: Text(
                      c,
                      style: context.semiBold.copyWith(
                        fontSize: 13.textMultiplier,
                        color: sel ? AppColors.white : AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(String? asset, VoidCallback onTap, {IconData? fallback}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.widthMultiplier,
        height: 40.widthMultiplier,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12.radiusMultipier),
        ),
        child: asset != null
            ? Padding(
                padding: EdgeInsets.all(10.widthMultiplier),
                child: Image.asset(asset, color: AppColors.textSecondary),
              )
            : Icon(
                fallback,
                size: 18.widthMultiplier,
                color: AppColors.textSecondary,
              ),
      ),
    );
  }

  Widget _buildFilterBadge(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 20.widthMultiplier,
        vertical: 10.heightMultiplier,
      ),
      color: AppColors.primarySurface,
      child: Row(
        children: [
          Icon(
            Icons.filter_alt_rounded,
            size: 16.widthMultiplier,
            color: AppColors.primary,
          ),
          SizedBox(width: 8.widthMultiplier),
          Expanded(
            child: Text(
              'Filter: $_selectedFilter',
              style: context.semiBold.copyWith(
                fontSize: 12.textMultiplier,
                color: AppColors.primary,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _selectedFilter = 'All Products'),
            child: Icon(
              Icons.close_rounded,
              size: 16.widthMultiplier,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionRow(
    BuildContext context,
    String title, {
    bool showViewAll = true,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.bold.copyWith(
            fontSize: 16.textMultiplier,
            color: AppColors.textPrimary,
          ),
        ),
        if (showViewAll)
          GestureDetector(
            onTap: () {},
            child: Text(
              'View All →',
              style: context.semiBold.copyWith(
                fontSize: 13.textMultiplier,
                color: AppColors.secondary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> p) {
    final hasCampaign = p['hasCampaign'] as bool;
    return GestureDetector(
      onTap: () {
        if (hasCampaign) context.pushNamed(Routes.campaignDetail);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.radiusMultipier),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 130.heightMultiplier,
                  decoration: BoxDecoration(
                    gradient: p['gradient'] as Gradient,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.radiusMultipier),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      p['emoji'],
                      style: TextStyle(fontSize: 44.textMultiplier),
                    ),
                  ),
                ),
                if (hasCampaign)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.widthMultiplier,
                        vertical: 4.heightMultiplier,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.warning,
                        borderRadius: BorderRadius.circular(10.radiusMultipier),
                      ),
                      child: Text(
                        '🎟 Win',
                        style: context.medium.copyWith(
                          fontSize: 10.textMultiplier,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.widthMultiplier),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'],
                    style: context.semiBold.copyWith(
                      fontSize: 13.textMultiplier,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.heightMultiplier),
                  Text(
                    p['category'],
                    style: context.regular.copyWith(
                      fontSize: 11.textMultiplier,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 6.heightMultiplier),
                  Text(
                    p['price'],
                    style: context.bold.copyWith(
                      fontSize: 15.textMultiplier,
                      color: AppColors.secondary,
                    ),
                  ),
                  if (hasCampaign && p['campaign'] != null) ...[
                    SizedBox(height: 8.heightMultiplier),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8.widthMultiplier),
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(10.radiusMultipier),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'RAFFLE',
                            style: context.medium.copyWith(
                              fontSize: 9.textMultiplier,
                              color: AppColors.primary,
                              letterSpacing: 0.8,
                            ),
                          ),
                          SizedBox(height: 2.heightMultiplier),
                          Text(
                            p['campaign'],
                            style: context.semiBold.copyWith(
                              fontSize: 11.textMultiplier,
                              color: AppColors.primary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (p['entry'] != null)
                            Text(
                              'Entry: ${p['entry']}',
                              style: context.regular.copyWith(
                                fontSize: 10.textMultiplier,
                                color: AppColors.textSecondary,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Map<String, dynamic> p) {
    final hasCampaign = p['hasCampaign'] as bool;
    return Container(
      margin: EdgeInsets.only(bottom: 12.heightMultiplier),
      padding: EdgeInsets.all(14.widthMultiplier),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.radiusMultipier),
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
            width: 72.widthMultiplier,
            height: 72.widthMultiplier,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(14.radiusMultipier),
            ),
            child: Center(
              child: Text(
                p['emoji'],
                style: TextStyle(fontSize: 32.textMultiplier),
              ),
            ),
          ),
          SizedBox(width: 14.widthMultiplier),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p['title'],
                  style: context.semiBold.copyWith(
                    fontSize: 14.textMultiplier,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.heightMultiplier),
                Text(
                  p['category'],
                  style: context.regular.copyWith(
                    fontSize: 11.textMultiplier,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 2.heightMultiplier),
                Text(
                  p['seller'],
                  style: context.light.copyWith(
                    fontSize: 11.textMultiplier,
                    color: AppColors.textDisabled,
                  ),
                ),
                SizedBox(height: 6.heightMultiplier),
                Row(
                  children: [
                    Text(
                      p['price'],
                      style: context.bold.copyWith(
                        fontSize: 15.textMultiplier,
                        color: AppColors.secondary,
                      ),
                    ),
                    if (hasCampaign) ...[
                      SizedBox(width: 8.widthMultiplier),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.widthMultiplier,
                          vertical: 3.heightMultiplier,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warningSurface,
                          borderRadius: BorderRadius.circular(
                            8.radiusMultipier,
                          ),
                        ),
                        child: Text(
                          '🎟 Win Prize',
                          style: context.medium.copyWith(
                            fontSize: 10.textMultiplier,
                            color: AppColors.warning,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            size: 20.widthMultiplier,
            color: AppColors.textDisabled,
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.radiusMultipier),
        ),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.all(24.widthMultiplier),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Products',
                  style: context.bold.copyWith(
                    fontSize: 18.textMultiplier,
                    color: AppColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(ctx),
                  child: Icon(
                    Icons.close_rounded,
                    size: 22.widthMultiplier,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.heightMultiplier),
            ..._filters.map(
              (f) => RadioListTile<String>(
                value: f,
                groupValue: _selectedFilter,
                activeColor: AppColors.primary,
                title: Text(
                  f,
                  style: context.semiBold.copyWith(
                    fontSize: 14.textMultiplier,
                    color: AppColors.textPrimary,
                  ),
                ),
                onChanged: (v) {
                  setState(() => _selectedFilter = v!);
                  Navigator.pop(ctx);
                },
              ),
            ),
            SizedBox(height: 12.heightMultiplier),
          ],
        ),
      ),
    );
  }
}
