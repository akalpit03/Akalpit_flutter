import 'package:flutter/material.dart';

class InformAdminsPage extends StatefulWidget {
  final String clubId;

  const InformAdminsPage({
    super.key,
    required this.clubId,
  });

  @override
  State<InformAdminsPage> createState() =>
      _InformAdminsPageState();
}

class _InformAdminsPageState extends State<InformAdminsPage> {
  final TextEditingController _controller =
      TextEditingController();

  bool _isSubmitting = false;

  void _submit() async {
    final content = _controller.text.trim();

    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Message cannot be empty"),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // 🔥 TODO: Replace this with your Redux dispatch / API call
      // Example:
      // store.dispatch(SendAdminRequestAction(widget.clubId, content));

      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Message sent to admins"),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong"),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inform Admins"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText:
                    "Write your message to the admins...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:
                    _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Send"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
