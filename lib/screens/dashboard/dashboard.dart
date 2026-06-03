import 'dart:ui';

import 'package:consumer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/responsive.dart';

class Dashboard extends StatefulWidget {
  final Widget child;

  const Dashboard({super.key, required this.child});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  static const List<_ShellTab> _tabs = [
    _ShellTab(path: Routes.home, label: 'Home', icon: Icons.home_rounded),
    _ShellTab(
      path: Routes.products,
      label: 'Products',
      icon: Icons.shopping_bag_rounded,
    ),
    _ShellTab(
      path: Routes.gamesHub,
      label: 'Games',
      icon: Icons.sports_esports_rounded,
    ),
    _ShellTab(
      path: Routes.ticketWallet,
      label: 'Tickets',
      icon: Icons.confirmation_number_rounded,
    ),
    _ShellTab(
      path: Routes.profile,
      label: 'Profile',
      icon: Icons.person_rounded,
    ),
  ];

  late AnimationController _animationController;

  bool _isSearching = false;

  final TextEditingController _searchController = TextEditingController();

  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _animationController.value = 1;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  int _selectedIndex(String location) {
    for (var i = 0; i < _tabs.length; i++) {
      if (location.startsWith(_tabs[i].path)) {
        return i;
      }
    }

    return 0;
  }

  void _onTap(int index, int currentIndex) {
    if (index == currentIndex) return;

    _animationController.forward(from: 0);

    context.go(_tabs[index].path);
  }

  String _getTitle(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Products';
      case 2:
        return 'Games';
      case 3:
        return 'Tickets';
      case 4:
        return 'Profile';
      default:
        return 'Dashboard';
    }
  }

  bool _shouldShowBackButton(String location) {
    return location.contains('details') ||
        location.contains('view') ||
        location.contains('edit');
  }

  void _onSearchTap() {
    setState(() {
      _isSearching = true;
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      _searchFocusNode.requestFocus();
    });
  }

  void _closeSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });

    _searchFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final routeInfo = GoRouter.of(context).routeInformationProvider.value;

    final currentLocation = routeInfo.uri.toString();

    final currentIndex = _selectedIndex(currentLocation);

    return GestureDetector(
      onTap: () {
        if (_isSearching) {
          _closeSearch();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,

        /// APP BAR
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.white.withOpacity(0.75),

                surfaceTintColor: Colors.transparent,

                leading: _shouldShowBackButton(currentLocation)
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        onPressed: () {
                          context.pop();
                        },
                      )
                    : null,

                title: _isSearching
                    ? Container(
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextField(
                          controller: _searchController,
                          focusNode: _searchFocusNode,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: _closeSearch,
                            ),
                          ),
                        ),
                      )
                    : Text(
                        _getTitle(currentIndex),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: Responsive.fontSize(context, 18),
                          color: Colors.black87,
                        ),
                      ),

                actions: _isSearching
                    ? null
                    : [
                        _GlassIconButton(
                          icon: Icons.search_rounded,
                          onTap: _onSearchTap,
                        ),

                        const SizedBox(width: 10),

                        _GlassIconButton(
                          icon: Icons.notifications_none_rounded,
                          onTap: () {
                            // TODO: notification screen
                          },
                        ),

                        const SizedBox(width: 16),
                      ],
              ),
            ),
          ),
        ),

        /// BODY
        body: FadeTransition(
          opacity: _animationController,
          child: widget.child,
        ),

        /// BOTTOM NAVIGATION
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: BottomNavigationBar(
              currentIndex: currentIndex,

              onTap: (index) => _onTap(index, currentIndex),

              type: BottomNavigationBarType.fixed,

              elevation: 0,

              backgroundColor: Colors.white,

              selectedItemColor: const Color(0xFFFF6B35),

              unselectedItemColor: const Color(0xFF6B7280),

              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Responsive.fontSize(context, 11),
              ),

              unselectedLabelStyle: TextStyle(
                fontSize: Responsive.fontSize(context, 11),
              ),

              items: _tabs.map((tab) {
                return BottomNavigationBarItem(
                  icon: Icon(tab.icon, size: Responsive.fontSize(context, 24)),
                  label: tab.label,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShellTab {
  final String path;
  final String label;
  final IconData icon;

  const _ShellTab({
    required this.path,
    required this.label,
    required this.icon,
  });
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _GlassIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.55),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Icon(icon, size: 22, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
