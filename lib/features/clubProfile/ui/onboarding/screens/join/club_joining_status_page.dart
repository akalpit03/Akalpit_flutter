import 'package:flutter/material.dart';

/// ================= STATUS ENUM =================
enum RequestStatus {
  success,
  rejected,
  pending,
}

/// ================= MAIN PAGE =================
class RequestStatusPage extends StatefulWidget {
  const RequestStatusPage({super.key});

  @override
  State<RequestStatusPage> createState() => _RequestStatusPageState();
}

class _RequestStatusPageState extends State<RequestStatusPage> {
  RequestStatus status = RequestStatus.pending; // 🔁 default

  void _changeStatus(RequestStatus newStatus) {
    setState(() {
      status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request Status',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),

            /// Status Icon
            _StatusIcon(status: status),

            const SizedBox(height: 24),

            /// Title
            _StatusTitle(status: status),

            const SizedBox(height: 10),

            /// Message
            _StatusMessage(status: status),

            const Spacer(),

            /// ================= TEMP STATUS CONTROLS =================
            Column(
              children: [
                const Text(
                  'Temporary Status Controls',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _changeStatus(RequestStatus.pending),
                        child: const Text(
                          'Pending',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _changeStatus(RequestStatus.success),
                        child: const Text(
                          'Success',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _changeStatus(RequestStatus.rejected),
                        child: const Text(
                          'Rejected',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// ================= GO TO CLUB PAGE (ONLY ON SUCCESS) =================
            if (status == RequestStatus.success)
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    //  ClubHomePage
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Go to Club Page'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// ================= STATUS ICON =================
class _StatusIcon extends StatelessWidget {
  final RequestStatus status;

  const _StatusIcon({required this.status});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (status) {
      case RequestStatus.success:
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case RequestStatus.rejected:
        icon = Icons.cancel;
        color = Colors.red;
        break;
      case RequestStatus.pending:
      default:
        icon = Icons.hourglass_top;
        color = Colors.orange;
    }

    return Icon(icon, size: 90, color: color);
  }
}

/// ================= STATUS TITLE =================
class _StatusTitle extends StatelessWidget {
  final RequestStatus status;

  const _StatusTitle({required this.status});

  @override
  Widget build(BuildContext context) {
    String title;

    switch (status) {
      case RequestStatus.success:
        title = 'Request Approved';
        break;
      case RequestStatus.rejected:
        title = 'Request Rejected';
        break;
      case RequestStatus.pending:
      default:
        title = 'Request Pending';
    }

    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

/// ================= STATUS MESSAGE =================
class _StatusMessage extends StatelessWidget {
  final RequestStatus status;

  const _StatusMessage({required this.status});

  @override
  Widget build(BuildContext context) {
    String message;

    switch (status) {
      case RequestStatus.success:
        message =
            'Your request has been approved. You are now part of the club.';
        break;
      case RequestStatus.rejected:
        message = 'Unfortunately, your request was not approved by the club.';
        break;
      case RequestStatus.pending:
      default:
        message = 'Your request is under review. Please wait for confirmation.';
    }

    return Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 13,
        color: Colors.white,
      ),
    );
  }
}
