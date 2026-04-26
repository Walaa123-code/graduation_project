// import 'package:flutter/material.dart';
// import 'package:graduation_project/features/my_space/ui/widgets/space_item_card.dart';
//
// import '../../../../core/utils/app_colors.dart';
// import '../../../../core/utils/app_styles.dart';
//
// class JournalsTab extends StatelessWidget {
//   const JournalsTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Previous Journals",
//               style: AppStyles.bold20Black,
//             ),
//             Container(
//               decoration:
//               BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),),
//               child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child:Row(children: [ Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Container
//                       (
//                         decoration: BoxDecoration(
//                             color: AppColors.lavenderColor,
//                             borderRadius: BorderRadius.circular(50)),
//                         child: Icon(Icons.add, color: AppColors.whiteColor,)),
//                   ),
//                     Text("New", style: AppStyles.bold18Lavender,),
//                   ],)
//               ),
//             )
//           ],
//         ),
//         const SpaceItemCard(
//           title: "Beautiful Day at the Park",
//           subtitle: "I enjoyed the sunshine and felt peaceful today...",
//           emoji: "😊",
//         ),
//         const SpaceItemCard(
//           title: "Moment of Reflection",
//           subtitle: "I took time to think about my goals..."
//               "",
//           emoji: "🤔",
//         ),
//       ],
//     );
//   }
// }
