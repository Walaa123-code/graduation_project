import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/features/user/my_space/ui/widgets/journals/ui/manager/update_journal_cubit.dart';
import 'package:mindecho/core/components/custom_elevated_button.dart';
import 'package:mindecho/core/components/custom_text_field.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/di/di.dart';
import '../../domain/use_cases/journal_use_case.dart';
import '../manager/create_journal_cubit.dart';

class AddJournalScreen extends StatefulWidget {
  final bool isUpdate;
  final dynamic journal;

  const AddJournalScreen({super.key, this.isUpdate = false, this.journal});

  @override
  State<AddJournalScreen> createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate && widget.journal != null) {
      titleController.text = widget.journal.title ?? "";
      contentController.text = widget.journal.content ?? "";
    }
  }

  void handleSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Journal Saved Successfully! 🎉",
          style: AppStyles.bold20Whit,
        ),
        backgroundColor: AppColors.lavenderColor,
      ),
    );
    Navigator.pop(context);
  }

  void handleError(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => CreateJournalCubit(getIt<JournalUseCase>())),
        BlocProvider(create: (context) => getIt<UpdateJournalCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CreateJournalCubit, CreateJournalState>(
            listener: (context, state) {
              if (state is CreateJournalSuccessState) handleSuccess(context);
              if (state is CreateJournalErrorState) {
                handleError(context, state.failures.errors);
              }
            },
          ),
          BlocListener<UpdateJournalCubit, UpdateJournalState>(
            listener: (context, state) {
              if (state is UpdateJournalSuccessState) handleSuccess(context);
              if (state is UpdateJournalErrorState) {
                handleError(context, state.failures.errors);
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.isUpdate ? "Edit Journal" : "New Journal",
              style: AppStyles.bold23Black,
            ),
            titleSpacing: 0,
            iconTheme: const IconThemeData(color: AppColors.blackColor),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: titleController,
                    hintText: "What's on your mind?",
                    validator: (value) =>
                        value!.isEmpty ? "Title is required" : null,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: contentController,
                    hintText: "Write your thoughts here...",
                    maxLines: 8,
                    validator: (value) =>
                        value!.isEmpty ? "Content is required" : null,
                  ),
                  const Spacer(),
                  Builder(
                    builder: (context) {
                      final createLoading = context
                          .watch<CreateJournalCubit>()
                          .state is CreateJournalLoadingState;
                      final updateLoading = context
                          .watch<UpdateJournalCubit>()
                          .state is UpdateJournalLoadingState;

                      if (createLoading || updateLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: CustomElevatedButton(
                            textButton: widget.isUpdate
                                ? "Update Journal"
                                : "Save Journal",
                            textStyle: AppStyles.bold20Whit,
                            backGroundColor: AppColors.lavenderColor,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (widget.isUpdate) {
                                  context
                                      .read<UpdateJournalCubit>()
                                      .updateJournal(
                                        widget.journal.id!.toInt(),
                                        titleController.text,
                                        contentController.text,
                                      );
                                } else {
                                  context
                                      .read<CreateJournalCubit>()
                                      .createJournal(
                                        titleController.text,
                                        contentController.text,
                                      );
                                }
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
