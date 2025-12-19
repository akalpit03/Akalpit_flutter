import 'package:akalpit/features/Events/create/ui/register/daywise.dart';
import 'package:flutter/material.dart';
import 'register/banner_upload.dart';
import 'register_screen_Appbar.dart';

class CreateEventMainPage extends StatefulWidget {
  const CreateEventMainPage({super.key});

  @override
  State<CreateEventMainPage> createState() => _CreateEventMainPageState();
}

class _CreateEventMainPageState extends State<CreateEventMainPage> {
  bool isRegistered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CreateEventPageAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------- Register Section ----------
            RegisterEventHeader(
              onRegister: () {
                setState(() {
                  isRegistered = true;
                });
              },
            ),

            const SizedBox(height: 30),

            /// ---------- Day-wise Events (Placeholder) ----------
            if (isRegistered) ...[
              Text(
                "Event Schedule",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                children: List.generate(3, (index) {
                  return OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DayWiseEventPage(),
                        ),
                      );
                    },
                    child: Text("Day ${index + 1}",
                    style: const TextStyle(color : Colors.white),),
                    
                  );
                }),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
