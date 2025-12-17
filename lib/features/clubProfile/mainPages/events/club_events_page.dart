import 'package:akalpit/features/Events/layout/ui/widgets/body.dart';
import 'package:flutter/material.dart';

class ClubEventsPage extends StatelessWidget {
  const ClubEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EventBody(
        isClub: true,
      ),
    );
  }
}
