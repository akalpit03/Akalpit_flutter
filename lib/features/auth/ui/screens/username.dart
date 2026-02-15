import 'dart:async';
import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/features/search/viewmodels/usernameAvailability.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../../../core/utils/responsive_utils.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/store/app_state.dart';
 
import '../widgets/custom_text_field.dart';

class EnterNameUsernameScreen extends StatefulWidget {
  const EnterNameUsernameScreen({super.key});

  @override
  State<EnterNameUsernameScreen> createState() =>
      _EnterNameUsernameScreenState();
}

class _EnterNameUsernameScreenState
    extends State<EnterNameUsernameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _onUsernameChanged(
      String value, UsernameAvailabilityViewModel vm) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final username = value.trim();

      if (username.length >= 3) {
        vm.checkAvailability(username);
      } else {
        vm.clear();
      }
    });
  }

  void _onContinue(UsernameAvailabilityViewModel vm) {
    if (_formKey.currentState?.validate() ?? false) {
      if (vm.available != true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Username is not available"),
          ),
        );
        return;
      }

      final name = _nameController.text.trim();
      final username = _usernameController.text.trim();

      // Dispatch profile update here
      // store.dispatch(UpdateProfileAction({...}));

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UsernameAvailabilityViewModel>(
      distinct: true,
      converter: UsernameAvailabilityViewModel.fromStore,
      builder: (context, vm) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: ResponsiveUtils.getScreenPadding(context),
                child: Container(
                  width: ResponsiveUtils.getFormWidth(context),
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tell us about you',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Enter your name and choose a username',
                          style:
                              Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 32),

                        /// Name Field
                        CustomTextField(
                          label: 'Full Name',
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            if (value.trim().length < 2) {
                              return 'Name must be at least 2 characters';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        /// Username Field
                        CustomTextField(
                          label: 'Username',
                          controller: _usernameController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) =>
                              _onUsernameChanged(value, vm),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Please enter a username';
                            }
                            if (value.contains(' ')) {
                              return 'Username cannot contain spaces';
                            }
                            if (!RegExp(
                                    r'^[a-zA-Z0-9_.]+$')
                                .hasMatch(value)) {
                              return 'Only letters, numbers, _ and . allowed';
                            }
                            if (value.length < 3) {
                              return 'Username must be at least 3 characters';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 8),

                        /// Availability Indicator
                        if (vm.isChecking)
                          const Text(
                            "Checking availability...",
                            style: TextStyle(
                                color: Colors.grey),
                          )
                        else if (vm.available == true)
                          const Text(
                            "Username is available ✓",
                            style: TextStyle(
                                color: Colors.green),
                          )
                        else if (vm.available == false)
                          const Text(
                            "Username already taken ✕",
                            style: TextStyle(
                                color: Colors.red),
                          ),

                        const SizedBox(height: 32),

                        CustomButton(
                          text: 'Continue',
                          onPressed: () => _onContinue(vm),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
