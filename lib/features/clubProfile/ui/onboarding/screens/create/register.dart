import 'dart:io';

import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/gettingClub/viewmodel.dart';
import 'package:akalpit/features/clubProfile/ui/categories/club_categories_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';

class SetClubProfilePage extends StatefulWidget {
  const SetClubProfilePage({super.key, this.initialClubId});
  final String? initialClubId; // Club ID passed from VerifyClubPage

  @override
  State<SetClubProfilePage> createState() => _SetClubProfilePageState();
}

class _SetClubProfilePageState extends State<SetClubProfilePage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController aboutCtrl = TextEditingController();

  String selectedCategory = '';

Future<void> _pickImage(ClubViewModel vm) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    // Store path only, not File object
    vm.selectImagePath(pickedFile.path);
  }
}


  void _openCategorySheet() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ClubCategoryBottomSheet(),
    );

    if (result != null) {
      setState(() {
        selectedCategory = result;
      });
    }
  }

  void _submit(ClubViewModel vm) {
    if (nameCtrl.text.isEmpty ||
        aboutCtrl.text.isEmpty ||
        selectedCategory.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    final clubData = {
      "clubId": widget.initialClubId, // passed from VerifyClubPage
      "clubName": nameCtrl.text.trim(), // owner types name freely
      "about": aboutCtrl.text.trim(),
      "categories": [selectedCategory],
      // Image handled separately in middleware via Redux state
    };

    vm.submitCreateClub(clubData);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClubViewModel>(
      distinct: true,
      converter: ClubViewModel.fromStore,
      builder: (context, vm) {
        final File? selectedImage = vm.selectedImage;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Set Image, Name & About'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// ================= Image Upload =================
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: selectedImage != null
                              ? FileImage(selectedImage)
                              : null,
                          child: selectedImage == null
                              ? const Icon(Icons.image, size: 36)
                              : null,
                        ),
                        const SizedBox(height: 12),
                        // OutlinedButton.icon(
                        //   // onPressed: () => _pickImage(vm),
                        //   icon: const Icon(Icons.upload),
                        //   label: const Text('Upload Image'),
                        // ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// ================= Club Name =================
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Club Name',
                    hintText: 'Enter your club name',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 14),

                /// ================= About =================
                TextField(
                  controller: aboutCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'About Your Club',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 14),

                /// ================= Category =================
                GestureDetector(
                  onTap: _openCategorySheet,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          selectedCategory.isEmpty
                              ? 'Select Category'
                              : selectedCategory,
                          style: TextStyle(
                            color: selectedCategory.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// ================= Submit =================
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: vm.isLoading ? null : () => _submit(vm),
                    child: vm.isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Submit'),
                  ),
                ),

                /// ================= Error =================
                if (vm.error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    vm.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
