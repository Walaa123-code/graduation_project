import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/app_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../di/di.dart';
import '../../journals/domain/entities/GetJournalByIDResEntity.dart';
import '../../journals/ui/manager/delete_journal_cubit.dart';
import '../../journals/ui/manager/journal_cubit.dart';
import '../../journals/ui/manager/update_journal_cubit.dart';
import '../../journals/ui/widgets/add_journal_screen.dart';

class SpaceItemCard extends StatefulWidget {
  final dynamic journal;
  final String title;
  final String subtitle;
  final String emoji;

  const SpaceItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.emoji,
     this.journal,
  });


  @override
  State<SpaceItemCard> createState() => _SpaceItemCardState();
}

class _SpaceItemCardState extends State<SpaceItemCard> {
  void _navigateToEdit() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt<UpdateJournalCubit>(),
          child: AddJournalScreen(isUpdate: true, journal: widget.journal),
        ),
      ),
    );
    if (mounted) {
      context.read<JournalCubit>().getJournal();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteJournalCubit, DeleteJournalState>(
      listener: (context, state) {
        if (state is DeleteJournalLoadingState) {
        } else if (state is DeleteJournalSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
              state.deleteResponseEntity.message ?? "Deleted Successfully",
              style: AppStyles.medium16White,
            )),
          );
          context.read<JournalCubit>().getJournal();
        } else if (state is DeleteJournalErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
              state.failures.errors ?? "Error occurred",
              style: AppStyles.medium16White,
            )),
          );
        }
      },
      child: AppCard(
        child: Row(
          children: [
            Text(widget.emoji, style: const TextStyle(fontSize: 25)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: AppStyles.bold20Lavender,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    style: AppStyles.medium15Black,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: AppColors.lavenderColor),
              onSelected: (value) {
                if (value == 'edit') {
                  _navigateToEdit();
                } else if (value == 'delete') {
                  _showDeleteDialog(context); // نادي ميثود التأكيد
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text("Edit"),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Delete Journal"),
        content: Text(
          "Are you sure you want to delete this journal?",
          style: AppStyles.medium15Gray,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              "Cancel",
              style: AppStyles.medium16Black,
            ),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<DeleteJournalCubit>()
                  .deleteJournal(widget.journal.id);
              Navigator.pop(dialogContext);
            },
            child: Text("Delete", style: AppStyles.medium16Red),
          ),
        ],
      ),
    );
  }
}
