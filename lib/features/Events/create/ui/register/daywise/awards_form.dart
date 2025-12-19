import 'package:flutter/material.dart';

class AwardsPage extends StatefulWidget {
  const AwardsPage({super.key});

  @override
  State<AwardsPage> createState() => _AwardsPageState();
}

class _AwardsPageState extends State<AwardsPage> {
  final List<AwardItem> _awards = [];

  /// ================= ADD / EDIT DIALOG =================
  Future<void> _openAwardDialog({AwardItem? item, int? index}) async {
    final rankController =
        TextEditingController(text: item?.rank.toString() ?? "");
    final titleController = TextEditingController(text: item?.title ?? "");
    final prizeController = TextEditingController(text: item?.prize ?? "");

    PrizeType selectedType = item?.type ?? PrizeType.cash;

    await showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(item == null ? "Add Award" : "Edit Award"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// -------- Rank --------
                    TextField(
                      controller: rankController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Rank",
                        hintText: "1, 2, 3...",
                      ),
                    ),
                    const SizedBox(height: 12),

                    /// -------- Title --------
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Award Title",
                        hintText: "Winner, Runner-up...",
                      ),
                    ),
                    const SizedBox(height: 12),

                    /// -------- Prize --------
                    TextField(
                      controller: prizeController,
                      decoration: const InputDecoration(
                        labelText: "Prize",
                        hintText: "₹5000 / Trophy / Gift Hamper",
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// -------- Prize Type --------
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Prize Type",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8,
                      children: PrizeType.values.map((type) {
                        final selected = selectedType == type;
                        return ChoiceChip(
                          label: Text(type.label),
                          selected: selected,
                          onSelected: (_) {
                            setDialogState(() {
                              selectedType = type;
                            });
                          },
                        );
                      }).toList(),
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
                    if (rankController.text.isEmpty ||
                        titleController.text.isEmpty ||
                        prizeController.text.isEmpty) {
                      return;
                    }

                    final award = AwardItem(
                      rank: int.parse(rankController.text),
                      title: titleController.text.trim(),
                      prize: prizeController.text.trim(),
                      type: selectedType,
                    );

                    setState(() {
                      if (index != null) {
                        _awards[index] = award;
                      } else {
                        _awards.add(award);
                      }
                    });

                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Awards & Recognition"),
      ),
      body: _awards.isEmpty
          ? const Center(
              child: Text("No awards added yet"),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _awards.length,
              itemBuilder: (_, index) {
                final award = _awards[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Text(
                      "🏅",
                      style: TextStyle(fontSize: 24),
                    ),
                    title: Text(
                      "${award.rank}. ${award.title}",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "${award.prize} • ${award.type.label}",
                    ),
                    trailing: const Icon(Icons.edit),
                    onTap: () => _openAwardDialog(item: award, index: index),
                  ),
                );
              },
            ),

      /// ================= ADD BUTTON =================
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAwardDialog(),
        icon: const Icon(Icons.add),
        label: const Text("Add Award"),
      ),
    );
  }
}

/// ================= MODEL =================
class AwardItem {
  final int rank;
  final String title;
  final String prize;
  final PrizeType type;

  AwardItem({
    required this.rank,
    required this.title,
    required this.prize,
    required this.type,
  });
}

/// ================= ENUM =================
enum PrizeType {
  cash,
  gift,
  both,
}

extension PrizeTypeX on PrizeType {
  String get label {
    switch (this) {
      case PrizeType.cash:
        return "Cash";
      case PrizeType.gift:
        return "Gift";
      case PrizeType.both:
        return "Cash + Gift";
    }
  }
}
