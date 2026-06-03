// import 'dart:ui';

// import 'package:consumer_app/configs/theme/app_colors.dart';
// import 'package:consumer_app/utils/responsive.dart';
// import 'package:flutter/material.dart';

// class GlassIconButton extends StatelessWidget {
//   final VoidCallback onTap;
//   final String imagePath;

//   const GlassIconButton({
//     super.key,
//     required this.onTap,
//     required this.imagePath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(
//           Responsive.radius(context, 20),
//         ),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(
//             sigmaX: 10,
//             sigmaY: 10,
//           ),
//           child: Container(
//             padding: EdgeInsets.all(
//               Responsive.width(context, 10),
//             ),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppColors.white.withOpacity(0.35),
//               border: Border.all(
//                 color: AppColors.white.withOpacity(0.25),
//                 width: 1.4,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.primary.withOpacity(0.08),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Image.asset(
//               imagePath,
//               color: AppColors.primary,
//               height: Responsive.fontSize(context, 20),
//               width: Responsive.fontSize(context, 20),
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }