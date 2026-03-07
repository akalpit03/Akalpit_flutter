import 'dart:convert';
import 'dart:io';

import 'package:akalpit/features/Events/create/ui/create_event.dart';
import 'package:akalpit/features/Events/create/ui/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  // Controllers
  final nameController = TextEditingController();
  final aboutController = TextEditingController();
  final venueController = TextEditingController();
  final locationIdController = TextEditingController();
  final clubIdController = TextEditingController();
  final tagsController = TextEditingController();
  final feeController = TextEditingController();
  final prizeController = TextEditingController();
  final maxParticipantsController = TextEditingController();
  final minTeamController = TextEditingController();
  final maxTeamController = TextEditingController();

  File? bannerImage;
  List<File> galleryImages = [];

  List<Map<String, TextEditingController>> sponsors = [];

  DateTime? startDate;
  DateTime? endDate;
  DateTime? lastRegDate;

  String eventType = "competition";
  String mode = "offline";
  String registrationType = "team";
  bool isPublic = true;

  @override
  void initState() {
    super.initState();
    addSponsor();
  }

  void addSponsor() {
    sponsors.add({
      "name": TextEditingController(),
      "logo": TextEditingController(),
      "website": TextEditingController(),
    });
  }

  Future<void> pickImage({required bool isBanner}) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Select Image"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  setState(() {
                    if (isBanner) {
                      bannerImage = File(image.path);
                    } else {
                      galleryImages.add(File(image.path));
                    }
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);
                if (isBanner) {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() => bannerImage = File(image.path));
                  }
                } else {
                  final List<XFile> images =
                      await _picker.pickMultiImage();
                  setState(() {
                    galleryImages
                        .addAll(images.map((e) => File(e.path)));
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickDateTime(Function(DateTime) onPicked) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2035),
      initialDate: DateTime.now(),
    );

    if (date == null) return;

    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (time == null) return;

    final finalDate = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    onPicked(finalDate);
  }

  Widget sectionCard(String title, Widget child) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget textField(String label, TextEditingController controller,
      {int maxLines = 1, TextInputType? type}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? "Required" : null,
      ),
    );
  }

  void submit() {
    if (!_formKey.currentState!.validate()) return;

    final jsonBody = {
      "name": nameController.text,
      "about": aboutController.text,
      "eventType": eventType,
      "tags":
          tagsController.text.split(",").map((e) => e.trim()).toList(),
      "locationId": locationIdController.text,
      "mode": mode,
      "venue": venueController.text,
      "startDate": startDate?.toUtc().toIso8601String(),
      "endDate": endDate?.toUtc().toIso8601String(),
      "lastRegistrationDate":
          lastRegDate?.toUtc().toIso8601String(),
      "participationFee":
          int.tryParse(feeController.text) ?? 0,
      "currency": "INR",
      "registrationType": registrationType,
      "minTeamSize":
          int.tryParse(minTeamController.text) ?? 0,
      "maxTeamSize":
          int.tryParse(maxTeamController.text) ?? 0,
      "maxParticipants":
          int.tryParse(maxParticipantsController.text) ?? 0,
      "prizePool":
          int.tryParse(prizeController.text) ?? 0,
      "clubId": clubIdController.text,
      "isPublic": isPublic,
    };

    debugPrint(jsonEncode(jsonBody));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Event Ready to Upload")),
    );
  }

  String formatDate(DateTime? dt) {
    if (dt == null) return "Select Date";
    return DateFormat("dd MMM yyyy, hh:mm a").format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CreateEventPageAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              sectionCard(
                "Basic Info",
                Column(
                  children: [
                    textField("Event Name", nameController),
                    textField("About Event", aboutController,
                        maxLines: 4),
                    textField("Venue", venueController),
                    textField("Location ID", locationIdController),
                    textField("Club ID", clubIdController),
                  ],
                ),
              ),

              sectionCard(
                "Media",
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => pickImage(isBanner: true),
                      child: bannerImage == null
                          ? Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(12),
                                color: Colors.grey.shade200,
                              ),
                              child: const Center(
                                  child: Text("Pick Banner Image")),
                            )
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(12),
                              child: Image.file(
                                bannerImage!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: [
                        ...galleryImages.map((img) =>
                            Image.file(img,
                                height: 70, width: 70)),
                        IconButton(
                          icon: const Icon(Icons.add_photo_alternate),
                          onPressed: () =>
                              pickImage(isBanner: false),
                        )
                      ],
                    )
                  ],
                ),
              ),

              sectionCard(
                "Schedule",
                Column(
                  children: [
                    ListTile(
                      title: Text(formatDate(startDate)),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () =>
                          pickDateTime((d) => setState(() => startDate = d)),
                    ),
                    ListTile(
                      title: Text(formatDate(endDate)),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () =>
                          pickDateTime((d) => setState(() => endDate = d)),
                    ),
                    ListTile(
                      title: Text(formatDate(lastRegDate)),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => pickDateTime(
                          (d) => setState(() => lastRegDate = d)),
                    ),
                  ],
                ),
              ),

              sectionCard(
                "Participation",
                Column(
                  children: [
                    textField("Participation Fee",
                        feeController,
                        type: TextInputType.number),
                    textField("Prize Pool",
                        prizeController,
                        type: TextInputType.number),
                    textField("Max Participants",
                        maxParticipantsController,
                        type: TextInputType.number),
                  ],
                ),
              ),

              SwitchListTile(
                value: isPublic,
                onChanged: (v) =>
                    setState(() => isPublic = v),
                title: const Text("Public Event"),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submit,
                  child: const Text("Create Event"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
