// import 'package:flutter/material.dart';
//
// import '../../../../../core/components/app_card.dart';
// import '../../../../../core/utils/app_styles.dart';
//
//
//
// class SpaceItemCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String emoji;
//
//   const SpaceItemCard({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.emoji,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AppCard(
//       child: Row(
//         children: [
//           Text(emoji, style: const TextStyle(fontSize: 25)),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title,
//                     style:  AppStyles.bold20Lavender),
//                 const SizedBox(height: 4),
//                 Text(subtitle, style: AppStyles.medium15Black),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
