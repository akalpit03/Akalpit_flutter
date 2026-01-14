import 'package:akalpit/core/store/app_state.dart';
 
import 'package:akalpit/features/Events/layout/ui/widgets/essentials/filterTag.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/events/services/actions.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/events/services/viewmodel.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:akalpit/features/Events/layout/ui/widgets/essentials/eventCard.dart';

class EventBody extends StatelessWidget {
  final bool isClub;
  final String? clubId; // Added to fetch specific club events

  const EventBody({
    super.key,
    required this.isClub,
    this.clubId,
  });

@override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClubEventViewModel>(
      onInit: (store) {
       
        if (isClub && clubId != null) {
         
          store.dispatch(GetUpcomingEventsAction(clubId!));
        }  
      },
      converter: (store) {
        // This prints every time the Redux state changes
        final eventsCount = store.state.clubEventState.events.length;
      
        return ClubEventViewModel.fromStore(store);
      },
      builder: (context, vm) {
       

        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
            // ... (Your search bar and filter code remains same) ...

            const SizedBox(height: 12),

            /// ================= Event Cards Logic =================
            if (vm.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (vm.events.isEmpty)
              Center(
                child: Text(
                  "Debug: List is empty. Error state: ${vm.error}", 
                  style: const TextStyle(color: Colors.red),
                ),
              )
            else
              ...vm.events.map((event) {
               
                return EventCard(event: event);
              }),
          ],
        );
      },
    );
  }
  Widget _buildFilters(bool isClub) {
    final List<String> tags = isClub
        ? ['Upcoming', 'Ongoing', 'Past']
        : ['Genre', 'City', 'Upcoming', 'Free', 'Paid'];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) => FilterTag(label: tags[index]),
      ),
    );
  }
}