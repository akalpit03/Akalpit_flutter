import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../../../core/utils/responsive_utils.dart';
import '../widgets/custom_text_field.dart';
import 'verification_screen.dart';
import 'login_screen.dart';
import '../viewmodel/register_viewmodel.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// STEP CONTROL
  int _currentStep = 0;

  /// ROLE
  String _selectedRole = 'user';
  final List<String> _roles = ['user', 'club', 'institution'];

  bool _isPasswordVisible = false;
  bool _handledResult = false;

  final List<bool> _passwordCriteria = List.filled(3, false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updatePasswordCriteria(String password) {
    setState(() {
      _passwordCriteria[0] = password.length >= 8;
      _passwordCriteria[1] = RegExp(r'[0-9]').hasMatch(password);
      _passwordCriteria[2] = RegExp(r'[A-Z]').hasMatch(password);
    });
  }

  void _onCreateAccount(RegisterViewModel vm) {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    _handledResult = false;

    vm.onRegister(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _selectedRole, // ✅ SAME STATE
    );
  }

  /// STEP 1 UI
  Widget _buildRoleStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose account type',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 12),
        Text(
          'Select how you want to use Akalpit',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),

        ..._roles.map(
          (role) => RadioListTile<String>(
            value: role,
            groupValue: _selectedRole,
            activeColor: Colors.white,
            title: Text(
              role.toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
            onChanged: (value) {
              setState(() {
                _selectedRole = value!;
              });
            },
          ),
        ),

        const SizedBox(height: 32),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _currentStep = 1;
              });
            },
            child: const Text('Continue'),
          ),
        ),
      ],
    );
  }

  /// STEP 2 UI
  Widget _buildCredentialStep(RegisterViewModel vm) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create ${_selectedRole} account',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Enter your credentials',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),

          /// EMAIL
          CustomTextField(
            label: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          /// PASSWORD
          CustomTextField(
            label: 'Password',
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.white70,
              ),
              onPressed: () => setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              }),
            ),
            onChanged: _updatePasswordCriteria,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your password';
              }
              if (!_passwordCriteria.every((e) => e)) {
                return 'Password requirements not met';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          ...[
            'Min 8 characters',
            'At least 1 number',
            'At least 1 uppercase letter',
          ].asMap().entries.map(
                (e) => Row(
                  children: [
                    Icon(
                      _passwordCriteria[e.key]
                          ? Icons.check
                          : Icons.close,
                      size: 16,
                      color: _passwordCriteria[e.key]
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      e.value,
                      style: TextStyle(
                        color: _passwordCriteria[e.key]
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),

          const SizedBox(height: 32),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentStep = 0;
                    });
                  },
                  child: const Text('Back',style: TextStyle(color: Colors.white),),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed:
                      vm.isLoading ? null : () => _onCreateAccount(vm),
                  child: vm.isLoading
                      ? const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        )
                      : const Text('Create account'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account? '),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                ),
                child: const Text('Log in'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RegisterViewModel>(
      distinct: true,
      converter: RegisterViewModel.fromStore,
      builder: (context, vm) {
        /// SUCCESS
        if (!_handledResult && !vm.isLoading && vm.isRegistered) {
          _handledResult = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => VerificationScreen(
                  email: _emailController.text.trim(),
                ),
              ),
            );
          });
        }

        /// ERROR
        if (vm.errorMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(vm.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
            vm.clearError();
          });
        }

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                if (_currentStep == 1) {
                  setState(() => _currentStep = 0);
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: ResponsiveUtils.getScreenPadding(context),
                child: Container(
                  width: ResponsiveUtils.getFormWidth(context),
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: _currentStep == 0
                      ? _buildRoleStep()
                      : _buildCredentialStep(vm),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
