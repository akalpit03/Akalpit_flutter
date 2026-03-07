import 'dart:io';
import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/models/userProfileModel.dart';
import 'package:akalpit/features/profile/services/viewmodels/profileviewmodel.dart';
import 'package:akalpit/features/profile/services/models/userExperiencemodel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:akalpit/features/entrypoint/entrypoint_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// =======================================================
/// CONTAINER
/// =======================================================
/// Gets ViewModel from Redux store
class ProfileFormScreen extends StatelessWidget {
  final UserProfileModel? profile; // null = create, not null = edit

  const ProfileFormScreen({super.key, this.profile});

  bool get isEditMode => profile != null;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      distinct: true,
      converter: (store) => ProfileViewModel.fromStore(store),

      onDidChange: (prev, curr) {
        // -------- SUCCESS (loading -> not loading & profile exists) --------
        final wasLoading = prev?.isLoading ?? false;
        final isNowLoaded = !curr.isLoading && curr.profile != null;

        if (wasLoading && isNowLoaded) {
          final message = profile != null
              ? "Profile updated successfully"
              : "Profile created successfully";

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );

          if (profile != null) {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const EntryPointUI(initialIndex: 4)),
              (route) => false,
            );
          }
        }

        // -------- ERROR --------
        if (curr.error != null && curr.error != prev?.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(curr.error!)),
          );
        }
      },

      builder: (context, vm) {
        return _ProfileFormView(vm: vm, profile: profile);
      },
    );
  }
}

/// =======================================================
/// VIEW (Stateful UI)
/// =======================================================
class _ProfileFormView extends StatefulWidget {
  final ProfileViewModel vm;
  final UserProfileModel? profile;

  const _ProfileFormView({
    required this.vm,
    this.profile,
  });

  bool get isEditMode => profile != null;

  @override
  State<_ProfileFormView> createState() => _ProfileFormViewState();
}

class _ProfileFormViewState extends State<_ProfileFormView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _hobbyInputController = TextEditingController();

  final List<String> _hobbies = [];
  final List<ExperienceModel> _experiences = [];
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    /// Pre-fill data for edit mode
    if (widget.isEditMode) {
      final p = widget.profile!;
      _nameController.text = p.displayName;
      _aboutController.text = p.bio;
      _hobbies.addAll(p.hobbies);
      _experiences.addAll(p.experiences);
    }
  }

  void _showExperienceDialog() {
    final titleController = TextEditingController();
    final orgController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text("Add Experience", style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: "Title", labelStyle: TextStyle(color: Colors.grey)),
              ),
              TextField(
                controller: orgController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: "Organization", labelStyle: TextStyle(color: Colors.grey)),
              ),
              TextField(
                controller: descController,
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Description", labelStyle: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && orgController.text.isNotEmpty) {
                setState(() {
                  _experiences.add(ExperienceModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text.trim(),
                    organization: orgController.text.trim(),
                    description: descController.text.trim(),
                  ));
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aboutController.dispose();
    _hobbyInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        centerTitle: true,
        leading: widget.isEditMode
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: Text(
          widget.isEditMode ? "Edit Profile" : "Complete Your Profile",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildInputField(
                label: "Full Name",
                controller: _nameController,
                hint: "Enter your name",
                icon: Icons.person_outline,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? "Name is required" : null,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: "About Me",
                controller: _aboutController,
                hint: "Tell us about your journey...",
                maxLines: 4,
                icon: Icons.badge_outlined,
              ),
              const SizedBox(height: 25),
              _buildSectionTitle("Interests & Hobbies"),
              const SizedBox(height: 12),
              _buildHobbySection(),
              const SizedBox(height: 30),
              _buildExperienceCard(),
              const SizedBox(height: 40),
              _buildSubmitButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ===================== UI COMPONENTS =====================

  Widget _buildHeader() {
    final imageUrl = widget.profile?.imageUrl;

    ImageProvider? imageProvider;
    if (_imageFile != null) {
      if (kIsWeb) {
        imageProvider = NetworkImage(_imageFile!.path);
      } else {
        imageProvider = FileImage(File(_imageFile!.path));
      }
    } else if (imageUrl != null && imageUrl.isNotEmpty) {
      imageProvider = NetworkImage(imageUrl);
    }

    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.cardBackground,
                  backgroundImage: imageProvider,
                  child: imageProvider == null
                      ? Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.grey[600],
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _imageFile != null ? "Image Selected" : "Tap to change photo",
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        if (label.isNotEmpty) const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            validator: validator,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.grey),
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              floatingLabelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHobbySection() {
    return Column(
      children: [
        _buildInputField(
          label: "",
          controller: _hobbyInputController,
          hint: "Type a hobby and press +",
          icon: Icons.local_activity_outlined,
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: _addHobby,
            icon: const Icon(Icons.add, size: 18),
            label: const Text("Add Hobby", style: TextStyle(fontSize: 14,color: Colors.white)),
          ),
        ),
        Wrap(
          spacing: 8,
          children: _hobbies
              .map(
                (h) => Chip(
                  backgroundColor: AppColors.cardBackground,
                  side: BorderSide(color: Colors.grey[200]!),
                  label: Text(h, style: const TextStyle(fontSize: 13)),
                  onDeleted: () => setState(() => _hobbies.remove(h)),
                  deleteIcon: const Icon(Icons.close, size: 14),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildExperienceCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _showExperienceDialog,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[100]!.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.work_outline,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Experiences",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "Add work or club history",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.add_circle_outline, size: 24, color: Colors.blueAccent),
              ],
            ),
          ),
        ),
        if (_experiences.isNotEmpty) const SizedBox(height: 12),
        ..._experiences.map((exp) => Card(
              color: AppColors.cardBackground,
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(exp.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text("${exp.organization}\n${exp.description}", style: const TextStyle(color: Colors.grey)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                  onPressed: () => setState(() => _experiences.remove(exp)),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cardBackground,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        onPressed: widget.vm.isLoading ? null : _submitProfile,
        child: widget.vm.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                widget.isEditMode ? "Update Profile" : "Complete Setup",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  // ===================== LOGIC =====================

  void _addHobby() {
    final hobby = _hobbyInputController.text.trim();
    if (hobby.isEmpty) return;

    if (!_hobbies.contains(hobby)) {
      setState(() => _hobbies.add(hobby));
    }

    _hobbyInputController.clear();
  }

  void _submitProfile() {
    if (_formKey.currentState!.validate()) {
      final data = {
        "displayName": _nameController.text.trim(),
        "bio": _aboutController.text.trim(),
        "hobbies": _hobbies,
        "experiences": _experiences.map((e) => e.toJson()).toList(),
      };

      if (widget.isEditMode) {
        widget.vm.updateProfile(data, imageFile: _imageFile);
      } else {
        widget.vm.createProfile(data, imageFile: _imageFile);
      }
    }
  }
}