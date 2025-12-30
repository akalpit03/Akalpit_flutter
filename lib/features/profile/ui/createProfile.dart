import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/features/profile/ui/viewmodel/profileviewmodel.dart';
 
import 'package:flutter/material.dart';

class CreateProfileScreen extends StatefulWidget {
  final ProfileViewModel vm; // Passed from ProfilePage StoreConnector

  const CreateProfileScreen({super.key, required this.vm});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _hobbyInputController = TextEditingController();
  final List<String> _hobbies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Complete Your Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                validator: (v) => v!.isEmpty ? "Name is required" : null,
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

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.add_a_photo_outlined, size: 30, color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),
          const Text("Add Profile Photo", style: TextStyle(color: Colors.grey, fontSize: 14)),
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
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
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
          label: "", // Label handled by section title
          controller: _hobbyInputController,
          hint: "Type a hobby and press +",
          icon: Icons.local_activity_outlined,
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () {
              if (_hobbyInputController.text.isNotEmpty) {
                setState(() {
                  _hobbies.add(_hobbyInputController.text);
                  _hobbyInputController.clear();
                });
              }
            },
            icon: const Icon(Icons.add, size: 18),
            label: const Text("Add Hobby"),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 0,
          children: _hobbies.map((h) => Chip(
            backgroundColor: Colors.white,
            side: BorderSide(color: Colors.grey[200]!),
            label: Text(h, style: const TextStyle(fontSize: 13)),
            onDeleted: () => setState(() => _hobbies.remove(h)),
            deleteIcon: const Icon(Icons.close, size: 14),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildExperienceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), shape: BoxShape.circle),
            child: const Icon(Icons.work_outline, color: Colors.blueAccent),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Experiences", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Add work or club history", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Modern high-contrast black
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        onPressed: widget.vm.isLoading ? null : _submitProfile,
        child: widget.vm.isLoading 
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text("Complete Setup", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  void _submitProfile() {
    if (_formKey.currentState!.validate()) {
      final profileData = {
        "name": _nameController.text,
        "about": _aboutController.text,
        "hobbies": _hobbies,
        "experiences": [],
      };
      
      widget.vm.createProfile(profileData);
    }
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
}