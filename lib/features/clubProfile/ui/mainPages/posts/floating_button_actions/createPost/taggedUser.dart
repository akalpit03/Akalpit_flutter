import 'package:flutter/material.dart';

class TaggedUsersSection extends StatelessWidget {
  final List<Map<String, String?>> taggedUsers;
  final Function(Map<String, String?>) onAdd;
  final Function(Map<String, String?>) onRemove;

  const TaggedUsersSection({
    super.key,
    required this.taggedUsers,
    required this.onAdd,
    required this.onRemove,
  });

  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    final idController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Tag User",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name *",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: "User ID (Optional)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.trim().isEmpty) return;

                  onAdd({
                    "userId": idController.text.isEmpty
                        ? null
                        : idController.text,
                    "name": nameController.text.trim(),
                  });

                  Navigator.pop(context);
                },
                child: const Text("Add"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tagged Users",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: taggedUsers
              .map(
                (user) => Chip(
                  label: Text(user["name"]!),
                  onDeleted: () => onRemove(user),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () => _showAddDialog(context),
          icon: const Icon(Icons.person_add),
          label: const Text("Add User"),
        ),
      ],
    );
  }
}
