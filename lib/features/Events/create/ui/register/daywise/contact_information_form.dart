import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final List<ContactItem> _contacts = [];

  /// ================= ADD / EDIT DIALOG =================
  Future<void> _openContactDialog({ContactItem? item, int? index}) async {
    final nameController =
        TextEditingController(text: item?.name ?? "");
    final roleController =
        TextEditingController(text: item?.role ?? "");
    final phoneController =
        TextEditingController(text: item?.phone ?? "");
    final emailController =
        TextEditingController(text: item?.email ?? "");

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(item == null ? "Add Contact" : "Edit Contact"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// -------- Name --------
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
              ),
              const SizedBox(height: 10),

              /// -------- Role --------
              TextField(
                controller: roleController,
                decoration: const InputDecoration(
                  labelText: "Role",
                  hintText: "Coordinator / Support",
                ),
              ),
              const SizedBox(height: 10),

              /// -------- Phone --------
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                ),
              ),
              const SizedBox(height: 10),

              /// -------- Email --------
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email (Optional)",
                ),
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
              if (nameController.text.trim().isEmpty ||
                  phoneController.text.trim().isEmpty) {
                return;
              }

              final contact = ContactItem(
                name: nameController.text.trim(),
                role: roleController.text.trim(),
                phone: phoneController.text.trim(),
                email: emailController.text.trim(),
              );

              setState(() {
                if (index != null) {
                  _contacts[index] = contact;
                } else {
                  _contacts.add(contact);
                }
              });

              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  /// ================= DELETE =================
  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Information"),
      ),
      body: _contacts.isEmpty
          ? const Center(
              child: Text("No contacts added yet"),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _contacts.length,
              itemBuilder: (_, index) {
                final contact = _contacts[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Text(
                      "📞",
                      style: TextStyle(fontSize: 24),
                    ),
                    title: Text(
                      contact.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (contact.role.isNotEmpty)
                          Text(contact.role),
                        Text("📱 ${contact.phone}"),
                        if (contact.email.isNotEmpty)
                          Text("✉️ ${contact.email}"),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "edit") {
                          _openContactDialog(
                            item: contact,
                            index: index,
                          );
                        } else if (value == "delete") {
                          _deleteContact(index);
                        }
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: "edit",
                          child: Text("Edit"),
                        ),
                        PopupMenuItem(
                          value: "delete",
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                    onTap: () => _openContactDialog(
                      item: contact,
                      index: index,
                    ),
                  ),
                );
              },
            ),

      /// ================= ADD BUTTON =================
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openContactDialog(),
        icon: const Icon(Icons.add),
        label: const Text("Add Contact"),
      ),
    );
  }
}

/// ================= MODEL =================
class ContactItem {
  final String name;
  final String role;
  final String phone;
  final String email;

  ContactItem({
    required this.name,
    required this.role,
    required this.phone,
    required this.email,
  });
}
