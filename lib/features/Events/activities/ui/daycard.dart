import 'package:akalpit/features/Events/activities/ui/demopage.dart';
import 'package:flutter/material.dart';

class EventDayCard extends StatelessWidget {
  final String dayTitle;
  final String date;
  final List<String> tracks;

  const EventDayCard({
    super.key,
    required this.dayTitle,
    required this.date,
    required this.tracks,
  });

  @override
  Widget build(BuildContext context) {
    // This is your dummy response for testing navigation
    final dummyResponse = {
      "message": "New activity document created",
      "data": {
        "eventId": "695dd2a294c8429bde427a3c",
        "activityName": "National Debate Competition",
        "dayNumber": 2,
        "date": "2026-01-20T10:00:00.000Z",
        "scheduling": [
          {
            "title": "Registration & Reporting",
            "description": "Participants report at the registration desk",
            "startTime": "09:00",
            "endTime": "10:00",
            "location": "Main Lobby"
          },
          {
            "title": "Preliminary Round",
            "description": "Group-wise debate rounds",
            "startTime": "10:30",
            "endTime": "13:30",
            "location": "Seminar Hall A"
          },
          {
            "title": "Final Round & Results",
            "description": "Top teams compete and winners announced",
            "startTime": "15:00",
            "endTime": "17:00",
            "location": "Auditorium"
          }
        ],
        "awardsRecognition": [
          {
            "title": "Winner",
            "position": 1,
            "amount": 10000,
            "certificate": true,
            "description": "First position trophy and cash prize"
          },
          {
            "title": "Runner-up",
            "position": 2,
            "amount": 5000,
            "certificate": true,
            "description": "Second position trophy and cash prize"
          }
        ],
        "rulesGuidelines": [
          {
            "title": "Time Limit",
            "description": "Each participant gets 5 minutes to speak",
            "mandatory": true
          },
          {
            "title": "Language",
            "description": "Only English language is permitted",
            "mandatory": true
          }
        ],
        "venueLogistics": {
          "venueName": "University Convention Center",
          "address": "Sector 15, Knowledge Park, New Delhi",
          "hallOrRoom": "Auditorium Block",
          "capacity": 300,
          "resources": ["Projector", "Microphone", "Sound System", "WiFi"],
          "instructions": "Participants must reach 30 minutes before their slot"
        },
        "contactsSupport": [
          {
            "name": "Amit Sharma",
            "role": "Event Coordinator",
            "phone": "+91-9876543210",
            "email": "amit.sharma@example.com"
          },
          {
            "name": "Neha Verma",
            "role": "Assistant Coordinator",
            "phone": "+91-9123456780",
            "email": "neha.verma@example.com"
          }
        ],
        "status": "active",
        "_id": "695ea1027cf0f83f1c301ef9",
        "createdAt": "2026-01-07T18:08:02.697Z",
        "updatedAt": "2026-01-07T18:08:02.697Z",
        "__v": 0
      }
    };
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= HEADER: DAY & DATE =================
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dayTitle.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "AVAILABLE TRACKS",
              style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),

          // ================= TRACKS (SPAN BUTTONS) =================
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tracks.map((trackName) {
                return GestureDetector(
                  onTap: () {
                    // Testing: Navigate to a detail page with dummy data
                    // debugPrint("Tapped on $trackName");

                    // Note: Ensure you have an ActivityDetailsPage class defined as per previous steps

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActivityDetailDummyPage(
                          data: dummyResponse,
                        ),
                      ),
                    );
                  },
                  child: _TrackSpan(name: trackName),
                );
              }).toList(),
            ),
          ),

          // ================= FOOTER HINT =================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.02),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: const Center(
              child: Text(
                "Tap an activity to view details",
                style: TextStyle(color: Colors.white24, fontSize: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Compact Span-like Button
class _TrackSpan extends StatelessWidget {
  final String name;
  const _TrackSpan({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30), // Pill/Span shape
        border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
      ),
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.blueAccent,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
