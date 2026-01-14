import 'package:akalpit/features/Events/activities/ui/daycard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/Events/activities/services/viewmodel.dart';
import 'package:akalpit/features/Events/activities/services/actions.dart';

import 'package:intl/intl.dart';

class EventSchedulePage extends StatelessWidget {
  final String eventId;

  const EventSchedulePage({super.key, required this.eventId});

  // Helper to format the ISO date from backend to DD/MM/YYYY
  String formatDate(String isoDate) {
    try {
      DateTime dt = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy').format(dt);
    } catch (e) {
      return isoDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ActivityViewModel>(
      onInit: (store) =>
          store.dispatch(GetEventScheduleAction(eventId)),
      converter: (store) => ActivityViewModel.fromStore(store),
      builder: (context, vm) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text("Event Schedule"),
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          body: vm.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent))
              : vm.schedule.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: vm.schedule.length,
                      itemBuilder: (context, index) {
                        final dayData = vm.schedule[index];

                        // Extracting activity names for your 'tracks' parameter
                        final List<dynamic> metadata =
                            dayData['metadata'] ?? [];
                        final List<String> activityNames = metadata
                            .map((item) => item['activityName'].toString())
                            .toList();
                        print(vm.schedule);
                        return EventDayCard(
                          dayTitle: "Day ${dayData['dayNumber']}",
                          date: formatDate(dayData['date']),
                          tracks: activityNames,
                          // Optional: pass metadata for navigation
                          // onTrackTap: (id) => vm.loadActivity(eventId, id),
                        );
                      },
                    ),
          //
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        "No activities scheduled for this event.",
        style: TextStyle(color: Colors.white38),
      ),
    );
  }
}
