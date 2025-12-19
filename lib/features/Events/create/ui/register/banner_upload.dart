import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RegisterEventHeader extends StatefulWidget {
  final VoidCallback onRegister;

  const RegisterEventHeader({
    super.key,
    required this.onRegister,
  });

  @override
  State<RegisterEventHeader> createState() => _RegisterEventHeaderState();
}

class _RegisterEventHeaderState extends State<RegisterEventHeader> {
  final _eventNameController = TextEditingController();
  final _venueController = TextEditingController();
  final _feesController = TextEditingController();
  final _aboutController = TextEditingController();
  final _daysController = TextEditingController(text: "1");

  File? _bannerImage;

  int _days = 1;
  String _eventType = "Workshop";

  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _eventTypes = [
    "Workshop",
    "Seminar",
    "Hackathon",
    "Competition",
    "Meetup",
  ];

  /// ================= IMAGE PICKER =================
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (image != null) {
      setState(() {
        _bannerImage = File(image.path);
      });
    }
  }

  /// ================= DATE PICKER =================
  Future<void> _pickDate({required bool isStart}) async {
    final initialDate = isStart ? DateTime.now() : (_startDate ?? DateTime.now());

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(picked)) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _increaseDays() {
    setState(() {
      _days++;
      _daysController.text = _days.toString();
    });
  }

  void _decreaseDays() {
    if (_days <= 1) return;
    setState(() {
      _days--;
      _daysController.text = _days.toString();
    });
  }

  /// ================= VALIDATION =================
  bool _isFormValid() {
    return _eventNameController.text.isNotEmpty &&
        _venueController.text.isNotEmpty &&
        _feesController.text.isNotEmpty &&
        _aboutController.text.isNotEmpty &&
        _aboutController.text.length <= 200 &&
        _startDate != null &&
        _endDate != null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ================= BANNER =================
        GestureDetector(
          onTap: _pickImage,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
                image: _bannerImage != null
                    ? DecorationImage(
                        image: FileImage(_bannerImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _bannerImage == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add_photo_alternate_outlined, size: 40),
                        SizedBox(height: 8),
                        Text("Upload Event Banner"),
                      ],
                    )
                  : null,
            ),
          ),
        ),

        const SizedBox(height: 24),

        /// ================= EVENT NAME =================
        _buildTextField("Event Name", _eventNameController),

        const SizedBox(height: 16),

        /// ================= VENUE =================
        _buildTextField("Venue", _venueController),

        const SizedBox(height: 16),

        /// ================= FEES =================
        _buildTextField(
          "Participation Fees",
          _feesController,
          keyboardType: TextInputType.number,
        ),

        const SizedBox(height: 16),

        /// ================= EVENT TYPE =================
        DropdownButtonFormField<String>(
          value: _eventType,
          items: _eventTypes
              .map(
                (type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              _eventType = value!;
            });
          },
          decoration: _inputDecoration("Event Type"),
        ),

        const SizedBox(height: 16),

        /// ================= ABOUT =================
        TextField(
          controller: _aboutController,
          maxLines: 2,
          maxLength: 200,
          decoration: _inputDecoration("About Event"),
        ),

        const SizedBox(height: 16),

        /// ================= DAYS =================
        Text("Days for Event"),
        Row(
          children: [
            IconButton(
              onPressed: _decreaseDays,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            SizedBox(
              width: 60,
              child: TextField(
                controller: _daysController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final parsed = int.tryParse(value);
                  if (parsed != null && parsed > 0) _days = parsed;
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            IconButton(
              onPressed: _increaseDays,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),

        const SizedBox(height: 20),

        /// ================= DATE RANGE =================
        Row(
          children: [
            Expanded(
              child: _dateTile(
                label: "Start Date",
                date: _startDate,
                onTap: () => _pickDate(isStart: true),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _dateTile(
                label: "End Date",
                date: _endDate,
                onTap: () => _pickDate(isStart: false),
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        /// ================= SUBMIT =================
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _isFormValid()
                ? () {
                    widget.onRegister();
                  }
                : null,
            child: const Text("Create Event"),
          ),
        ),
      ],
    );
  }

  /// ================= HELPERS =================
  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputDecoration(label),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _dateTile({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: _inputDecoration(label),
        child: Text(
          date == null ? "Select date" : DateFormat("dd MMM yyyy").format(date),
        ),
      ),
    );
  }
}
