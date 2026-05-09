import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindecho/core/components/custom_elevated_button.dart';
import '../../../../../core/components/app_container.dart';
import '../../../../../core/components/custom_text_field.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../manager/create_memory_cubit.dart';

class AddMemoryScreen extends StatefulWidget {
  const AddMemoryScreen({super.key});

  @override
  State<AddMemoryScreen> createState() => _AddMemoryScreenState();
}

class _AddMemoryScreenState extends State<AddMemoryScreen> {
  File? _image;
  final _picker = ImagePicker();
  final _titleController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateMemoryCubit, CreateMemoryState>(
      listener: (context, state) {
        if (state is CreateMemorySuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Memory saved! ✨")),
          );
          Navigator.pop(context);
        } else if (state is CreateMemoryErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failures.errors ?? "Error")),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add New Memory", style: AppStyles.bold16Black),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _image == null
                  ? AppContainer(
                title: "Select Photo",
                subtitle: "Pick a beautiful moment to save",
                buttonText: "Open Gallery",
                iconData: Icons.add_a_photo,
                iconColor: Colors.white,
                onPressed: _pickImage,
              )
                  : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      _image!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.7),
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: AppColors.lavenderColor),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Text("Memory Title", style: AppStyles.bold16Black),
              const SizedBox(height: 10),

              CustomTextField(
                hintText: "What happened today?",
                controller: _titleController,
                prefixIcon: const Icon(Icons.title, color: AppColors.lavenderColor),
              ),

              const SizedBox(height: 40),

              BlocBuilder<CreateMemoryCubit, CreateMemoryState>(
                builder: (context, state) {
                  if (state is CreateMemoryLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: CustomElevatedButton(
                      textButton: "Save Memory",
                      textStyle: AppStyles.bold17Lavender.copyWith(color: Colors.white),
                      backGroundColor: AppColors.lavenderColor,
                      onPressed: () {
                        if (_image != null && _titleController.text.isNotEmpty) {
                          context.read<CreateMemoryCubit>().createMemory(
                            "Happy",
                            _titleController.text,
                            _image!.path,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please select an image and enter a title")),
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
    );
  }
}