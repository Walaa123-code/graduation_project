// import 'package:flutter/material.dart';
// import 'package:graduation_project/core/components/app_card.dart';
// import 'package:graduation_project/core/utils/app_colors.dart';
// import 'package:graduation_project/core/utils/app_styles.dart';
//
// class LibraryItemCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String duration;
//
//   final TextStyle? titleStyle;
//   final TextStyle? subTitleStyle;
//   final TextStyle? durationStyle;
//
//   const LibraryItemCard({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.duration,
//     this.titleStyle,
//     this.subTitleStyle,
//     this.durationStyle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//
//     return AppCard(
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: titleStyle ?? AppStyles.bold20Black,
//                 ),
//                 SizedBox(height: height * 0.01),
//                 Text(
//                   subtitle,
//                   style: subTitleStyle ?? AppStyles.medium15Gray,
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             children: [
//               Icon(
//                 Icons.play_circle_fill,
//                 color: AppColors.lavenderColor,
//                 size: 33,
//               ),
//               SizedBox(height: height * 0.01),
//               Text(
//                 duration,
//                 style: durationStyle ?? AppStyles.medium15Gray,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
