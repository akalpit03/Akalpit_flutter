import 'package:flutter/material.dart';

class AddPersonPage extends StatefulWidget {
  const AddPersonPage({super.key});

  @override
  State<AddPersonPage> createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  // Example pages that can be accessed
  final List<String> _allPages = [
    "Events",
    "Scheduling",
    "Awards",
    "Rules",
    "Venue",
    "Contacts",
  ];

  // Selected pages for access
  final Set<String> _selectedPages = {};

  void _togglePage(String page) {
    setState(() {
      if (_selectedPages.contains(page)) {
        _selectedPages.remove(page);
      } else {
        _selectedPages.add(page);
      }
    });
  }

  void _savePerson() {
    if (_nameController.text.isEmpty ||
        _roleController.text.isEmpty ||
        _idController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all fields")),
      );
      return;
    }

    // TODO: Save person to backend
    final newPerson = {
      "name": _nameController.text.trim(),
      "role": _roleController.text.trim(),
      "id": _idController.text.trim(),
      "accessPages": _selectedPages.toList(),
    };

    print(newPerson);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Person saved successfully")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Person"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // ---------------- Name ----------------
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
              ),
            ),
            const SizedBox(height: 12),

            // ---------------- Role ----------------
            TextField(
              controller: _roleController,
              decoration: const InputDecoration(
                labelText: "Role / Designation",
              ),
            ),
            const SizedBox(height: 12),

            // ---------------- ID ----------------
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: "ID / Employee Code",
              ),
            ),
            const SizedBox(height: 24),

            // ---------------- Access Pages ----------------
            const Text(
              "Allow Access To",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _allPages.map((page) {
                final selected = _selectedPages.contains(page);
                return FilterChip(
                  label: Text(page),
                  selected: selected,
                  onSelected: (_) => _togglePage(page),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _savePerson,
            child: const Text("Save Person"),
          ),
        ),
      ),
    );
  }
}
