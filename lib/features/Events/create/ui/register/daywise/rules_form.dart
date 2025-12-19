import 'package:flutter/material.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  final List<String> _rules = [];

  /// ================= ADD / EDIT DIALOG =================
  Future<void> _openRuleDialog({String? rule, int? index}) async {
    final controller = TextEditingController(text: rule ?? "");

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(rule == null ? "Add Rule" : "Edit Rule"),
        content: TextField(
          controller: controller,
          maxLines: 3,
          maxLength: 200,
          decoration: const InputDecoration(
            hintText: "Enter rule or guideline",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isEmpty) return;

              setState(() {
                if (index != null) {
                  _rules[index] = controller.text.trim();
                } else {
                  _rules.add(controller.text.trim());
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
  void _deleteRule(int index) {
    setState(() {
      _rules.removeAt(index);
    });
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rules & Guidelines"),
      ),
      body: _rules.isEmpty
          ? const Center(
              child: Text("No rules added yet"),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _rules.length,
              itemBuilder: (_, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Text(
                      "📌",
                      style: TextStyle(fontSize: 22),
                    ),
                    title: Text(
                      _rules[index],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "edit") {
                          _openRuleDialog(
                            rule: _rules[index],
                            index: index,
                          );
                        } else if (value == "delete") {
                          _deleteRule(index);
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
                    onTap: () => _openRuleDialog(
                      rule: _rules[index],
                      index: index,
                    ),
                  ),
                );
              },
            ),

      /// ================= ADD BUTTON =================
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openRuleDialog(),
        icon: const Icon(Icons.add),
        label: const Text("Add Rule"),
      ),
    );
  }
}
