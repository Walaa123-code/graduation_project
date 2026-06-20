import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/components/app_card.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import '../journals/ui/manager/delete_journal_cubit.dart';
import '../memories/ui/manager/delete_memory_cubit.dart';

class SpaceItemCard extends StatefulWidget {
  final dynamic itemData;
  final String title;
  final String subtitle;
  final String emoji;
  final bool isMemory;

  const SpaceItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.emoji,
    this.itemData,
    this.isMemory = false,
  });

  @override
  State<SpaceItemCard> createState() => _SpaceItemCardState();
}

class _SpaceItemCardState extends State<SpaceItemCard> {
  void _navigateToEdit() {
    debugPrint("Navigate to edit ${widget.itemData.id}");
  }

  void _executeDelete(BuildContext cardContext) {
    if (widget.itemData?.id == null) {
      debugPrint("Error: Item ID is null");
      return;
    }

    final int parsedId = int.parse(widget.itemData.id.toString());

    if (widget.isMemory) {
      cardContext.read<DeleteMemoryCubit>().deleteMemory(parsedId);
    } else {
      cardContext.read<DeleteJournalCubit>().deleteJournal(parsedId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Text(widget.emoji, style: const TextStyle(fontSize: 25)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.title,
                    style: AppStyles.bold20Lavender, maxLines: 1),
                const SizedBox(height: 4),
                Text(widget.subtitle,
                    style: AppStyles.medium15Black, maxLines: 1),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                _navigateToEdit();
              } else if (value == 'delete') {
                _showDeleteDialog(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text("Edit")),
              const PopupMenuItem(value: 'delete', child: Text("Delete")),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext cardContext) {
    showDialog(
      context: cardContext,
      builder: (dialogContext) => AlertDialog(
        title: Text(widget.isMemory ? "Delete Memory" : "Delete Journal"),
        content: Text(
          "Are you sure you want to delete this ${widget.isMemory ? 'memory' : 'journal'}?",
          style: AppStyles.medium15Gray,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text("Cancel", style: AppStyles.medium16Black),
          ),
          TextButton(
            onPressed: () {
              _executeDelete(cardContext);
              Navigator.pop(dialogContext);
            },
            child: Text("Delete", style: AppStyles.medium16Red),
          ),
        ],
      ),
    );
  }
}