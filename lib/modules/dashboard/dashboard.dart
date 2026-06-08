import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends StatefulWidget {
  final Widget child;
  const Dashboard({super.key, required this.child});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  static const List<_ShellTab> _tabs = [
    _ShellTab(path: Routes.home, label: 'Home', activeIcon: AppImages.home),
    _ShellTab(
      path: Routes.products,
      label: 'Explore',
      activeIcon: AppImages.explore,
    ),
    _ShellTab(
      path: Routes.gamesHub,
      label: 'My Stuff',
      activeIcon: AppImages.myStuff,
    ),
    _ShellTab(
      path: Routes.profile,
      label: 'Profile',
      activeIcon: AppImages.profile,
    ),
  ];

  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..value = 1;
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  int _selectedIndex(String location) {
    for (var i = 0; i < _tabs.length; i++) {
      if (location.startsWith(_tabs[i].path)) return i;
    }
    return 0;
  }

  void _onTap(int index, int current) {
    if (index == current) return;
    _animController.forward(from: 0);
    context.go(_tabs[index].path);
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(
      context,
    ).routeInformationProvider.value.uri.toString();
    final currentIndex = _selectedIndex(location);

    return Scaffold(
      extendBody: true,
      body: FadeTransition(opacity: _animController, child: widget.child),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 3.heightMultiplier,
              horizontal: 8.widthMultiplier,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_tabs.length, (i) {
                final tab = _tabs[i];
                final selected = i == currentIndex;
                return _NavItem(
                  tab: tab,
                  selected: selected,
                  onTap: () => _onTap(i, currentIndex),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final _ShellTab tab;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.verticalSpace,
          Image.asset(
            tab.activeIcon,
            width: 24.widthMultiplier,
            height: 24.widthMultiplier,
            color: selected ? AppColors.secondary : AppColors.textDisabled,
          ),
          SizedBox(height: 4.heightMultiplier),
          Text(
            tab.label,
            style: context.semiBold.copyWith(
              fontSize: 11.5.textMultiplier,
              color: selected ? AppColors.secondary : AppColors.textDisabled,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShellTab {
  final String path;
  final String label;
  final String activeIcon;

  const _ShellTab({
    required this.path,
    required this.label,
    required this.activeIcon,
  });
}
