import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubsection/ui/viewmodel/clubStateViewmodel.dart';
import 'package:akalpit/features/clubsection/ui/clubpage.dart';
import 'package:akalpit/features/misc/services/categories/categoriesVm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SetClubProfilePage extends StatefulWidget {
  const SetClubProfilePage({super.key, this.initialClubId});
  final String? initialClubId;

  @override
  State<SetClubProfilePage> createState() => _SetClubProfilePageState();
}

class _SetClubProfilePageState extends State<SetClubProfilePage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController aboutCtrl = TextEditingController();

  bool _navigated = false;

  void _submit(
    ClubScreenViewModel clubVm,
    CategoryViewModel categoryVm,
  ) {
    if (nameCtrl.text.isEmpty ||
        aboutCtrl.text.isEmpty ||
        categoryVm.selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    final clubData = {
      "clubId": widget.initialClubId,
      "clubName": nameCtrl.text.trim(),
      "about": aboutCtrl.text.trim(),
      "categories": [categoryVm.selectedCategory!.id],
    };

    clubVm.submitCreateClub(clubData);
  }

  void _openCategorySheet(CategoryViewModel categoryVm) {
    categoryVm.fetchCategories();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StoreConnector<AppState, CategoryViewModel>(
          converter: CategoryViewModel.fromStore,
          builder: (context, vm) {
            if (vm.isLoading) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: vm.categories.length,
              itemBuilder: (context, index) {
                final category = vm.categories[index];

                return ListTile(
                  title: Text(category.name),
                  onTap: () {
                    vm.selectCategory(category);
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClubScreenViewModel>(
      distinct: true,
      converter: ClubScreenViewModel.fromStore,

      /// ✅ NAVIGATE ONLY WHEN CLUB ACTUALLY EXISTS
      onDidChange: (_, clubVm) {
        if (!_navigated && clubVm.myClubId != null) {
          _navigated = true;

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const ClubPage()),
            (_) => false,
          );
        }
      },

      builder: (context, clubVm) {
        return StoreConnector<AppState, CategoryViewModel>(
          converter: CategoryViewModel.fromStore,
          builder: (context, categoryVm) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Set Name & About'),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Club Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: aboutCtrl,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'About Your Club',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 14),

                    /// CATEGORY SELECT
                    GestureDetector(
                      onTap: () => _openCategorySheet(categoryVm),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              categoryVm.selectedCategory?.name ??
                                  'Select Category',
                              style: TextStyle(
                                color: categoryVm.selectedCategory == null
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: clubVm.isLoading
                            ? null
                            : () => _submit(clubVm, categoryVm),
                        child: clubVm.isLoading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Submit'),
                      ),
                    ),

                    if (clubVm.error != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        clubVm.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
