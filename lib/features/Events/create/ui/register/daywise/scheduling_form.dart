import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchedulingPage extends StatefulWidget {
  const SchedulingPage({super.key});

  @override
  State<SchedulingPage> createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  TimeOfDay? _dayStart;
  TimeOfDay? _dayEnd;

  final List<ScheduleItem> _scheduleItems = [];

  /// ================= TIME PICKER =================
  Future<TimeOfDay?> _pickTime({TimeOfDay? initial}) async {
    return await showTimePicker(
      context: context,
      initialTime: initial ?? TimeOfDay.now(),
    );
  }

  /// ================= ADD / EDIT SCHEDULE =================
 Future<void> _openScheduleDialog({
  ScheduleItem? item,
  int? index,
  required bool isBreak,
}) async {
  TimeOfDay? start = item?.start;
  TimeOfDay? end = item?.end;
  final controller =
      TextEditingController(text: item?.description ?? "");

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          String formatTime(TimeOfDay t) {
            return DateFormat.jm().format(
              DateTime(0, 1, 1, t.hour, t.minute),
            );
          }

          return AlertDialog(
            title: Text(
              item == null
                  ? (isBreak ? "Add Break" : "Add Schedule")
                  : "Edit Schedule",
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// ---------- START TIME ----------
                ListTile(
                  title: const Text("Start Time"),
                  trailing: Text(
                    start == null ? "Select" : formatTime(start!),
                  ),
                  onTap: () async {
                    final picked = await _pickTime(initial: start);
                    if (picked != null) {
                      setDialogState(() => start = picked);
                    }
                  },
                ),

                /// ---------- END TIME ----------
                ListTile(
                  title: const Text("End Time"),
                  trailing: Text(
                    end == null ? "Select" : formatTime(end!),
                  ),
                  onTap: () async {
                    final picked = await _pickTime(initial: end);
                    if (picked != null) {
                      setDialogState(() => end = picked);
                    }
                  },
                ),

                /// ---------- DESCRIPTION ----------
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: isBreak
                        ? "Break description (Lunch, Tea...)"
                        : "Event description",
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (start == null || end == null) return;

                  setState(() {
                    final newItem = ScheduleItem(
                      start: start!,
                      end: end!,
                      description: controller.text.trim(),
                      isBreak: isBreak,
                    );

                    if (index != null) {
                      _scheduleItems[index] = newItem;
                    } else {
                      _scheduleItems.add(newItem);
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

  /// ================= PREVIEW =================
  void _showPreview() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Schedule Preview",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _scheduleItems.length,
                itemBuilder: (_, index) {
                  final item = _scheduleItems[index];
                  return ListTile(
                    leading: Text(item.isBreak ? "☕" : "🕒",
                        style: const TextStyle(fontSize: 22)),
                    title: Text(item.description),
                    subtitle: Text(item.timeRange),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Event Scheduling")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= EVENT DURATION =================
            const Text("Duration of Event",
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: _timeTile(
                    label: "Start Time",
                    time: _dayStart,
                    onTap: () async {
                      final picked = await _pickTime();
                      if (picked != null) setState(() => _dayStart = picked);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _timeTile(
                    label: "End Time",
                    time: _dayEnd,
                    onTap: () async {
                      final picked = await _pickTime();
                      if (picked != null) setState(() => _dayEnd = picked);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// ================= SCHEDULE LIST =================
            Expanded(
              child: _scheduleItems.isEmpty
                  ? const Center(child: Text("No schedules added yet"))
                  : ListView.builder(
                      itemCount: _scheduleItems.length,
                      itemBuilder: (_, index) {
                        final item = _scheduleItems[index];
                        return Card(
                          child: ListTile(
                            leading: Text(item.isBreak ? "☕" : "🕒",
                                style: const TextStyle(fontSize: 22)),
                            title: Text(item.description),
                            subtitle: Text(item.timeRange),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _openScheduleDialog(
                                    item: item,
                                    index: index,
                                    isBreak: item.isBreak,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      _scheduleItems.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),

            /// ================= ADD BUTTONS =================
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.add,color: Colors.white),
                    label: const Text("Add Schedule",style: TextStyle(color: Colors.white),),
                    onPressed: () =>
                        _openScheduleDialog(isBreak: false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.free_breakfast,  color: Colors.white),
                    label: const Text("Add Break",style: TextStyle(color: Colors.white),),
                    onPressed: () =>
                        _openScheduleDialog(isBreak: true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      /// ================= BOTTOM ACTIONS =================
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _showPreview,
                child: const Text("See Preview",style: TextStyle(color: Colors.white),),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Save to backend
                },
                child: const Text("Save", style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= HELPERS =================
  Widget _timeTile({
    required String label,
    required TimeOfDay? time,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          time == null
              ? "Select"
              : DateFormat.jm().format(
                  DateTime(0, 0, 0, time.hour, time.minute),
                ),
        ),
      ),
    );
  }
}

/// ================= MODEL =================
class ScheduleItem {
  final TimeOfDay start;
  final TimeOfDay end;
  final String description;
  final bool isBreak;

  ScheduleItem({
    required this.start,
    required this.end,
    required this.description,
    required this.isBreak,
  });

  String get timeRange {
    final startTime =
        DateFormat.jm().format(DateTime(0, 0, 0, start.hour, start.minute));
    final endTime =
        DateFormat.jm().format(DateTime(0, 0, 0, end.hour, end.minute));
    return "$startTime - $endTime";
  }
}
