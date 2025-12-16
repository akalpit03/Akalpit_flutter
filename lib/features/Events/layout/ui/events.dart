import 'package:flutter/material.dart';
import 'package:akalpit/features/Events/layout/ui/widgets/appbar.dart';
import 'package:akalpit/features/Events/layout/ui/widgets/body.dart';
import 'package:akalpit/features/Events/layout/ui/widgets/sidedrawer.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EventAppBar(),
      drawer: const EventSideDrawer(),
      body: const EventBody(),
    );
  }
}
