import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../di/di.dart';
import '../../domain/entities/GetJournalByIDResEntity.dart';
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
    // 1. قمنا بتغليف كل شيء بـ BlocProvider
    return BlocProvider(
      // ملاحظة: إذا كنت تستخدم Dependency Injection مثل GetIt استخدم:
      // create: (context) => getIt<CreateJournalCubit>(),
      create: (context) => CreateJournalCubit(getIt<JournalUseCase>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "New Journal",
            style: AppStyles.bold23Black,
          ),
          titleSpacing: 0,
          iconTheme: const IconThemeData(color: AppColors.blackColor),
        ),
        // 2. الآن الـ BlocListener سيجد الـ Cubit بنجاح
        body: BlocListener<CreateJournalCubit, CreateJournalState>(
          listener: (context, state) {
            if (state is CreateJournalSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                      "Journal Added Successfully! 🎉",
                      style: AppStyles.bold20Whit,
                    )),
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
                  TextFormField(
                    controller: titleController,
                    style: AppStyles.bold18Black,
                    decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle: AppStyles.medium17Gray,
                        hintText: "What's on your mind?",
                        hintStyle: AppStyles.medium15Gray),
                    validator: (value) =>
                    value!.isEmpty ? "Title is required" : null,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    style: AppStyles.bold18Black,
                    controller: contentController,
                    maxLines: 8,
                    minLines: 5,
                    decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: "Content",
                        labelStyle: AppStyles.medium17Gray,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: AppColors.lavenderColor, width: 2),
                        ),
                        hintText: "Write your thoughts here...",
                        hintStyle: AppStyles.medium15Gray),
                    validator: (value) =>
                    value!.isEmpty ? "Content is required" : null,
                  ),
                  const Spacer(),
                  BlocBuilder<CreateJournalCubit, CreateJournalState>(
                    builder: (context, state) {
                      if (state is CreateJournalLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lavenderColor,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // هنا context.read ستعمل بشكل صحيح
                              context.read<CreateJournalCubit>().createJournal(
                                titleController.text,
                                contentController.text,
                              );
                            }
                          },
                          child:
                          Text("Save Journal", style: AppStyles.bold20Whit),
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
  }}
