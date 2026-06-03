// import 'package:consumer_app/configs/assets/app_images.dart';
// import 'package:consumer_app/configs/theme/app_colors.dart';
// import 'package:consumer_app/utils/responsive.dart';
// import 'package:flutter/material.dart';

// class BottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final ValueChanged<int> onTap;

//   const BottomNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       _NavItem(label: 'Home', icon: AppImages.home),
//       _NavItem(label: 'Products', icon: AppImages.products),
//       _NavItem(label: 'Games', icon: AppImages.games),
//       _NavItem(label: 'Tickets', icon: AppImages.ticket),
//       _NavItem(label: 'Profile', icon: AppImages.profile),
//     ];

//     return SafeArea(
//       top: false,
//       child: Padding(
//         padding: EdgeInsets.only(
//           left: Responsive.width(context, 16),
//           right: Responsive.width(context, 16),
//           bottom: Responsive.height(context, 12),
//         ),
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: Responsive.width(context, 4),
//             vertical: Responsive.height(context, 6),
//           ),
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(Responsive.radius(context, 40)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.08),
//                 blurRadius: 18,
//                 offset: const Offset(0, 8),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: List.generate(items.length, (index) {
//               final item = items[index];

//               final isActive = currentIndex == index;

//               return Expanded(
//                 child: GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () => onTap(index),
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 250),
//                     curve: Curves.easeOutCubic,
//                     margin: EdgeInsets.symmetric(
//                       horizontal: Responsive.width(context, 4),
//                     ),
//                     padding: EdgeInsets.symmetric(
//                       horizontal: isActive
//                           ? Responsive.width(context, 14)
//                           : Responsive.width(context, 10),
//                       vertical: Responsive.height(context, 12),
//                     ),
//                     decoration: BoxDecoration(
//                       color: isActive ? AppColors.primary : Colors.transparent,
//                       borderRadius: BorderRadius.circular(
//                         Responsive.radius(context, 30),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(
//                           item.icon,
//                           height: Responsive.fontSize(context, 22),
//                           width: Responsive.fontSize(context, 22),
//                           colorFilter: ColorFilter.mode(
//                             isActive
//                                 ? AppColors.white
//                                 : AppColors.primary.withOpacity(.35),
//                             BlendMode.srcIn,
//                           ),
//                         ),

//                         if (isActive) ...[
//                           SizedBox(width: Responsive.width(context, 8)),

//                           Flexible(
//                             child: Text(
//                               item.label,
//                               overflow: TextOverflow.ellipsis,
//                               style: context.medium.copyWith(
//                                 color: AppColors.white,
//                                 fontSize: Responsive.fontSize(context, 12),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _NavItem {
//   final String label;
//   final String icon;

//   const _NavItem({required this.label, required this.icon});
// }
