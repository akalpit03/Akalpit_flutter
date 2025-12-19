import 'package:flutter/material.dart';
 

class EditClubInfoPage extends StatefulWidget {
  const EditClubInfoPage({super.key});

  @override
  State<EditClubInfoPage> createState() => _EditClubInfoPageState();
}

class _EditClubInfoPageState extends State<EditClubInfoPage> {
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _councilController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _servicesController = TextEditingController();
  final TextEditingController _founderController = TextEditingController();
  final TextEditingController _foundingYearController = TextEditingController();

  void _saveInfo() {
    if (_institutionController.text.isEmpty ||
        _councilController.text.isEmpty ||
        _aboutController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _servicesController.text.isEmpty ||
        _founderController.text.isEmpty ||
        _foundingYearController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final clubInfo = {
      "institutionName": _institutionController.text.trim(),
      "councilName": _councilController.text.trim(),
      "about": _aboutController.text.trim(),
      "address": _addressController.text.trim(),
      "services": _servicesController.text.trim(),
      "founder": _founderController.text.trim(),
      "foundingYear": _foundingYearController.text.trim(),
    };

    print(clubInfo);

    // TODO: Save to backend

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Club info saved successfully")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Club Information"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(_institutionController, "Institution Name"),
            const SizedBox(height: 12),
            _buildTextField(_councilController, "Council Name"),
            const SizedBox(height: 12),
            _buildTextField(
              _aboutController,
              "About",
              maxLines: 3,
              maxLength: 200,
              hintText: "Briefly describe your club",
            ),
            const SizedBox(height: 12),
            _buildTextField(_addressController, "Address", maxLines: 2),
            const SizedBox(height: 12),
            _buildTextField(
              _servicesController,
              "Services Offered",
              hintText: "Workshops, Hackathons, Tech Talks...",
            ),
            const SizedBox(height: 12),
            _buildTextField(_founderController, "Founder / Founded By"),
            const SizedBox(height: 12),
            _buildTextField(_foundingYearController, "Founding Year"),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _saveInfo,
            child: const Text("Save Club Info"),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    int? maxLength,
    String? hintText,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
