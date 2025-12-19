import 'package:flutter/material.dart';

class VenueLogisticsPage extends StatefulWidget {
  const VenueLogisticsPage({super.key});

  @override
  State<VenueLogisticsPage> createState() => _VenueLogisticsPageState();
}

class _VenueLogisticsPageState extends State<VenueLogisticsPage> {
  final TextEditingController _venueNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mapLinkController = TextEditingController();

  final List<String> _logistics = [];

  /// ================= ADD / EDIT LOGISTIC =================
  Future<void> _openLogisticDialog({String? text, int? index}) async {
    final controller = TextEditingController(text: text ?? "");

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(text == null ? "Add Facility / Logistic" : "Edit Facility"),
        content: TextField(
          controller: controller,
          maxLines: 2,
          maxLength: 150,
          decoration: const InputDecoration(
            hintText: "Parking available, Wheelchair access...",
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
                  _logistics[index] = controller.text.trim();
                } else {
                  _logistics.add(controller.text.trim());
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
  void _deleteLogistic(int index) {
    setState(() {
      _logistics.removeAt(index);
    });
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Venue & Logistics"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// -------- Venue Name --------
          TextField(
            controller: _venueNameController,
            decoration: const InputDecoration(
              labelText: "Venue Name",
            ),
          ),
          const SizedBox(height: 12),

          /// -------- Address --------
          TextField(
            controller: _addressController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Full Address",
            ),
          ),
          const SizedBox(height: 12),

          /// -------- Map Link --------
          TextField(
            controller: _mapLinkController,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(
              labelText: "Google Maps Link",
            ),
          ),
          const SizedBox(height: 24),

          /// -------- Logistics --------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Facilities & Logistics",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _openLogisticDialog(),
              ),
            ],
          ),
          const SizedBox(height: 8),

          _logistics.isEmpty
              ? const Text(
                  "No logistics added",
                  style: TextStyle(color: Colors.grey),
                )
              : Column(
                  children: List.generate(
                    _logistics.length,
                    (index) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const Text("📦"),
                        title: Text(_logistics[index]),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == "edit") {
                              _openLogisticDialog(
                                text: _logistics[index],
                                index: index,
                              );
                            } else if (value == "delete") {
                              _deleteLogistic(index);
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
                      ),
                    ),
                  ),
                ),
        ],
      ),

      /// ================= SAVE =================
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(
            onPressed: () {
              // TODO: Save to backend
            },
            child: const Text("Save Venue Details"),
          ),
        ),
      ),
    );
  }
}
