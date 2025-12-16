import 'dart:io';
import 'package:akalpit/features/clubProfile/categories/club_categories_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
 

class SetClubProfilePage extends StatefulWidget {
  const SetClubProfilePage({super.key});

  @override
  State<SetClubProfilePage> createState() => _SetClubProfilePageState();
}

class _SetClubProfilePageState extends State<SetClubProfilePage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController aboutCtrl = TextEditingController();

  File? clubImage;
  String selectedCategory = '';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        clubImage = File(image.path);
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Image, Name & About'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ================= Image Upload Card =================
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
                      backgroundImage:
                          clubImage != null ? FileImage(clubImage!) : null,
                      child: clubImage == null
                          ? const Icon(Icons.image, size: 36)
                          : null,
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.upload),
                      label: const Text('Upload Image'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// ================= Name =================
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Club Name',
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
                onPressed: () {
                  // submit logic later
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
