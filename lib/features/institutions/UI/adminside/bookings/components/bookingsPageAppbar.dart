import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// SHARED MODELS & DUMMY DATA
// ─────────────────────────────────────────────────────────────

const _statusColors = {
  'Pending': Color(0xFFF59E0B),
  'Confirmed': Color(0xFF10B981),
  'Completed': Color(0xFF6366F1),
  'Cancelled': Color(0xFFEF4444),
};

final List<Map<String, dynamic>> dummyAdminBookings = [
  {
    'id': 'ORD-2025-001',
    'serviceName': 'Sports Complex',
    'userName': 'Abhay Pratap',
    'userAvatar': '',
    'items': ['Basketball Court', 'Locker Room', 'Equipment Kit'],
    'date': '15 Mar 2025',
    'createdAt': 'Today, 9:42 AM',
    'totalCost': 1200.0,
    'persons': 12,
    'status': 'Pending',
  },
  {
    'id': 'ORD-2025-002',
    'serviceName': 'University Hostel',
    'userName': 'Priya Sharma',
    'userAvatar': '',
    'items': ['Single Room', 'Meals (3x)', 'WiFi Access'],
    'date': '18 Mar 2025',
    'createdAt': 'Yesterday, 3:15 PM',
    'totalCost': 3500.0,
    'persons': 1,
    'status': 'Confirmed',
  },
  {
    'id': 'ORD-2025-003',
    'serviceName': 'Seminar Hall',
    'userName': 'Rahul Verma',
    'userAvatar': '',
    'items': ['Hall A (200 seats)', 'Projector', 'Mic System', 'Catering'],
    'date': '20 Mar 2025',
    'createdAt': '6 Mar 2025, 11:00 AM',
    'totalCost': 8000.0,
    'persons': 180,
    'status': 'Completed',
  },
  {
    'id': 'ORD-2025-004',
    'serviceName': 'Admissions Counselling',
    'userName': 'Neha Singh',
    'userAvatar': '',
    'items': ['1:1 Session (60 min)', 'Course Brochure'],
    'date': '22 Mar 2025',
    'createdAt': '5 Mar 2025, 2:30 PM',
    'totalCost': 500.0,
    'persons': null,
    'status': 'Cancelled',
  },
];

final List<Map<String, dynamic>> dummyUserBookings = [
  {
    'id': 'ORD-2025-001',
    'institutionName': 'CSJMU University',
    'institutionLogo': '',
    'serviceName': 'Sports Complex',
    'items': ['Basketball Court', 'Locker Room', 'Equipment Kit'],
    'date': '15 Mar 2025',
    'createdAt': 'Today, 9:42 AM',
    'totalCost': 1200.0,
    'persons': 12,
    'status': 'Pending',
  },
  {
    'id': 'ORD-2025-007',
    'institutionName': 'City Hospital',
    'institutionLogo': '',
    'serviceName': 'General Checkup',
    'items': ['Blood Test', 'ECG', 'Doctor Consultation'],
    'date': '10 Mar 2025',
    'createdAt': '8 Mar 2025, 10:00 AM',
    'totalCost': 950.0,
    'persons': null,
    'status': 'Completed',
  },
  {
    'id': 'ORD-2025-010',
    'institutionName': 'Spice Garden',
    'institutionLogo': '',
    'serviceName': 'Table Reservation',
    'items': ['Table for 4', 'Welcome Drinks', 'Dessert Platter'],
    'date': '25 Mar 2025',
    'createdAt': 'Today, 1:20 PM',
    'totalCost': 1800.0,
    'persons': 4,
    'status': 'Confirmed',
  },
];

final List<Map<String, dynamic>> dummySponsoringRequests = [
  {
    'id': 'SPR-001',
    'clubName': 'Vivek Poetry Club',
    'clubLogo': '',
    'eventName': 'Annual Poetry Festival 2025',
    'description':
        'We are organizing our flagship Annual Poetry Festival on 5th April 2025 at the University Auditorium. The event will host 200+ students and alumni. We are seeking sponsorship for stage setup, sound system, and refreshments.',
    'requestedAmount': 25000.0,
    'eventDate': '5 Apr 2025',
    'contactName': 'Abhay Pratap',
    'contactRole': 'Club President',
    'status': 'Pending',
    'submittedOn': '2 days ago',
  },
  {
    'id': 'SPR-002',
    'clubName': 'Robotics Club',
    'clubLogo': '',
    'eventName': 'TechFest Hackathon',
    'description':
        'TechFest Hackathon is a 24-hour coding competition open to all engineering students. Expected participation of 300+ students. Sponsorship will cover prizes, infrastructure, food and beverages for participants.',
    'requestedAmount': 50000.0,
    'eventDate': '12 Apr 2025',
    'contactName': 'Neha Singh',
    'contactRole': 'Tech Lead',
    'status': 'Pending',
    'submittedOn': '5 days ago',
  },
  {
    'id': 'SPR-003',
    'clubName': 'Music Club',
    'clubLogo': '',
    'eventName': 'Spring Music Fest',
    'description':
        'Spring Music Fest is our annual cultural evening featuring live performances by student bands, solo artists, and invited performers. We expect an audience of 500+.',
    'requestedAmount': 35000.0,
    'eventDate': '20 Apr 2025',
    'contactName': 'Rahul Verma',
    'contactRole': 'Secretary',
    'status': 'Approved',
    'submittedOn': '1 week ago',
  },
];

// ─────────────────────────────────────────────────────────────
// STATUS BADGE
// ─────────────────────────────────────────────────────────────

class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final color = _statusColors[status] ?? Colors.white38;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}