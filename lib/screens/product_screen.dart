import 'package:flutter/material.dart';
import 'package:consumer_app/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import '../utils/responsive.dart';

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Products',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 28),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          ),
                          IconButton(
                            onPressed: () {
                              _showFilterBottomSheet(context);
                            },
                            icon: const Icon(Icons.tune),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.spacing(context, 8)),
                  Text(
                    'Browse products & win prizes',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 16)),

                  // Category Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categories.map((category) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: Responsive.spacing(context, 8),
                          ),
                          child: _buildCategoryChip(category),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Active Filter Badge
            if (_selectedFilter != 'All Products')
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.spacing(context, 16),
                  vertical: Responsive.spacing(context, 8),
                ),
                color: const Color(0xFFFF6B35).withOpacity(0.1),
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_alt,
                      size: Responsive.iconSize(context, 16),
                      color: const Color(0xFFFF6B35),
                    ),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    Expanded(
                      child: Text(
                        'Filter: $_selectedFilter',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 13),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFF6B35),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilter = 'All Products';
                        });
                      },
                      child: Icon(
                        Icons.close,
                        size: Responsive.iconSize(context, 18),
                        color: const Color(0xFFFF6B35),
                      ),
                    ),
                  ],
                ),
              ),

            // Products Grid
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(Responsive.spacing(context, 16)),
                children: [
                  // Featured Products
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Featured Products',
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
                  SizedBox(height: Responsive.spacing(context, 12)),

                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: Responsive.spacing(context, 12),
                    mainAxisSpacing: Responsive.spacing(context, 12),
                    childAspectRatio: 0.5,
                    children: [
                      _buildProductCard(
                        '📱',
                        'iPhone 15 Pro',
                        'Electronics',
                        '₹1,29,999',
                        'Win iPhone 15 Pro Max',
                        '₹299',
                        true,
                        const LinearGradient(
                          colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                        ),
                      ),
                      _buildProductCard(
                        '⌚',
                        'Apple Watch Ultra',
                        'Electronics',
                        '₹89,999',
                        'Win Apple Watch',
                        '₹149',
                        true,
                        const LinearGradient(
                          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                        ),
                      ),
                      _buildProductCard(
                        '💻',
                        'MacBook Air M3',
                        'Electronics',
                        '₹1,14,999',
                        'Win MacBook',
                        '₹349',
                        true,
                        const LinearGradient(
                          colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                        ),
                      ),
                      _buildProductCard(
                        '🎧',
                        'AirPods Pro Max',
                        'Electronics',
                        '₹59,999',
                        'Win AirPods',
                        '₹99',
                        true,
                        const LinearGradient(
                          colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
                        ),
                      ),
                      _buildProductCard(
                        '👟',
                        'Nike Air Max',
                        'Fashion',
                        '₹12,999',
                        null,
                        null,
                        false,
                        const LinearGradient(
                          colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
                        ),
                      ),
                      _buildProductCard(
                        '🎮',
                        'PlayStation 5',
                        'Electronics',
                        '₹54,999',
                        'Win PS5 Bundle',
                        '₹199',
                        true,
                        const LinearGradient(
                          colors: [Color(0xFFfa709a), Color(0xFFfee140)],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Responsive.spacing(context, 24)),

                  // All Products Section
                  Text(
                    'All Products',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 20),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 12)),

                  // List View Products
                  ..._buildProductListItems(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    final isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.spacing(context, 16),
          vertical: Responsive.spacing(context, 8),
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF6B35) : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(
    String emoji,
    String title,
    String category,
    String price,
    String? campaignTitle,
    String? entryFee,
    bool hasCampaign,
    Gradient gradient,
  ) {
    return GestureDetector(
      onTap: () {
        if (hasCampaign) {
          context.pushNamed(Routes.campaignDetail);
        }
      },
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
            // Image Section with Campaign Badge
            Stack(
              children: [
                Container(
                  height: Responsive.dimension(context, 140),
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      emoji,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 50),
                      ),
                    ),
                  ),
                ),
                if (hasCampaign)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.spacing(context, 8),
                        vertical: Responsive.spacing(context, 4),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD23F),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '🎟️',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 12),
                            ),
                          ),
                          SizedBox(width: Responsive.spacing(context, 2)),
                          Text(
                            'Win',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 10),
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1A1A2E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            // Details Section
            Padding(
              padding: EdgeInsets.all(Responsive.spacing(context, 12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 15),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Responsive.spacing(context, 4)),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 8)),
                  Row(
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 16),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFFF6B35),
                        ),
                      ),
                    ],
                  ),
                  if (hasCampaign && campaignTitle != null) ...[
                    SizedBox(height: Responsive.spacing(context, 8)),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.spacing(context, 8),
                        vertical: Responsive.spacing(context, 6),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B35).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Raffle',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 9),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                          Text(
                            campaignTitle,
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 11),
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFFF6B35),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (entryFee != null)
                            Text(
                              'Entry: $entryFee',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 10),
                                color: const Color(0xFF6B7280),
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

  List<Widget> _buildProductListItems() {
    final products = [
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
        'entryFee': '₹99',
      },
    ];

    return products.map((product) {
      return Container(
        margin: EdgeInsets.only(bottom: Responsive.spacing(context, 12)),
        padding: EdgeInsets.all(Responsive.spacing(context, 12)),
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
            // Product Image
            Container(
              width: Responsive.dimension(context, 80),
              height: Responsive.dimension(context, 80),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  product['emoji'] as String,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 36),
                  ),
                ),
              ),
            ),
            SizedBox(width: Responsive.spacing(context, 12)),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['title'] as String,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 15),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Responsive.spacing(context, 4)),
                  Text(
                    product['category'] as String,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 4)),
                  Text(
                    product['seller'] as String,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 11),
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 8)),
                  Row(
                    children: [
                      Text(
                        product['price'] as String,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 16),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFFF6B35),
                        ),
                      ),
                      if (product['hasCampaign'] == true) ...[
                        SizedBox(width: Responsive.spacing(context, 8)),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.spacing(context, 6),
                            vertical: Responsive.spacing(context, 3),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD23F),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '🎟️ Win Prize',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 10),
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1A1A2E),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Action Button
            Icon(
              Icons.arrow_forward_ios,
              size: Responsive.iconSize(context, 16),
              color: const Color(0xFF6B7280),
            ),
          ],
        ),
      );
    }).toList();
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(Responsive.spacing(context, 24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Products',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 20),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: Responsive.spacing(context, 20)),

            ..._filters.map((filter) {
              return ListTile(
                leading: Radio<String>(
                  value: filter,
                  groupValue: _selectedFilter,
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value!;
                    });
                    Navigator.pop(context);
                  },
                  activeColor: const Color(0xFFFF6B35),
                ),
                title: Text(
                  filter,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 15),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedFilter = filter;
                  });
                  Navigator.pop(context);
                },
              );
            }),

            SizedBox(height: Responsive.spacing(context, 20)),
          ],
        ),
      ),
    );
  }
}