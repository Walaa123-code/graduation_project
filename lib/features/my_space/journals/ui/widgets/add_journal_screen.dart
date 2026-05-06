import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/components/custom_elevated_button.dart';
import '../../../../../core/components/custom_text_field.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../di/di.dart';
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateJournalCubit(getIt<JournalUseCase>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isUpdate ? "Edit Journal" : "New Journal", // تغيير العنوان بناءً على الحالة
            style: AppStyles.bold23Black,
          ),
          titleSpacing: 0,
          iconTheme: const IconThemeData(color: AppColors.blackColor),
        ),
        body: BlocListener<CreateJournalCubit, CreateJournalState>(
          listener: (context, state) {
            if (state is CreateJournalSuccessState) {
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
            } else if (state is CreateJournalErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failures.errors.toString())),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // استخدام الـ CustomTextField للعنوان
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

                  BlocBuilder<CreateJournalCubit, CreateJournalState>(
                    builder: (context, state) {
                      if (state is CreateJournalLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: CustomElevatedButton(
                          textButton: "Save Journal",
                          textStyle: AppStyles.bold20Whit,
                          backGroundColor: AppColors.lavenderColor,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<CreateJournalCubit>().createJournal(
                                titleController.text,
                                contentController.text,
                              );
                            }
                          },
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