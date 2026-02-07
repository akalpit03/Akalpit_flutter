import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/clubactions/actions.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/floating_button_actions/createPost/post_type.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/floating_button_actions/createPost/taggedUser.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/floating_button_actions/createPost/textfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CreateClubPostPage extends StatefulWidget {
  final String clubId;

  const CreateClubPostPage({super.key, required this.clubId});

  @override
  State<CreateClubPostPage> createState() => _CreateClubPostPageState();
}

class _CreateClubPostPageState extends State<CreateClubPostPage> {
  String selectedType = "Announcement";

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final felicitationNameController = TextEditingController();

  DateTime? expireAt;
  List<Map<String, String?>> taggedUsers = [];

  void _submit(Store<AppState> store) {
    print("asdfsdfsadsdf");
    if (contentController.text.trim().isEmpty) return;
    print("1211212121212");

    final postData = {
      "clubId": widget.clubId,
      "type": selectedType,
      "title": selectedType == "Felicitation"
          ? felicitationNameController.text
          : titleController.text,
      "content": contentController.text,
      "expireAt": expireAt?.toIso8601String(),
      "taggedUsers": taggedUsers,
    };

    store.dispatch(CreateClubPostAction(postData));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    felicitationNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (store) => store.state.clubState.isPostCreating,
      builder: (context, isLoading) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Create Club Post",
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          PostTypeSelector(
                            selectedType: selectedType,
                            onChanged: (val) =>
                                setState(() => selectedType = val),
                          ),
                          const SizedBox(height: 24),

                          /// Template fields
                          if (selectedType == "Felicitation")
                            ModernTextField(
                              controller: felicitationNameController,
                              label: "Honoree Name",
                            )
                          else
                            ModernTextField(
                              controller: titleController,
                              label: "Title",
                            ),

                          ModernTextField(
                            controller: contentController,
                            label: selectedType == "Update"
                                ? "Update Details"
                                : "Content",
                            maxLines: 4,
                          ),

                          const SizedBox(height: 20),

                          TaggedUsersSection(
                            taggedUsers: taggedUsers,
                            onAdd: (user) {
                              setState(() => taggedUsers.add(user));
                            },
                            onRemove: (user) {
                              setState(() => taggedUsers.remove(user));
                            },
                          ),

                          const SizedBox(height: 40),

                          StoreBuilder<AppState>(
                            builder: (context, store) {
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed:
                                      isLoading ? null : () => _submit(store),
                                  child: isLoading
                                      ? const CircularProgressIndicator()
                                      : const Text("Publish Post 🚀"),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
