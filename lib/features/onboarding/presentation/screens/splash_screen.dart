import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:akalpit/core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../core/store/app_state.dart';
import '../../../../core/utils/navigation_service.dart';
import 'package:akalpit/features/auth/ui/screens/username.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final onboardingDone = prefs.getBool('onboarding_done') ?? false;

    /// FIRST: Check if onboarding is completed
    if (!onboardingDone) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
      return;
    }

    /// SECOND: Check login status
    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/home');
      return;
    }

    /// Default → login screen
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _handleRedirect() {
    final store = StoreProvider.of<AppState>(context, listen: false);
    final authState = store.state.authState;

    if (authState.isLoggedIn) {
      if (authState.isProfileComplete) {
        NavigationService.pushReplacementNamed('/home');
      } else {
        NavigationService.pushReplacementNamed('/completeProfile');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (store) => store.state.authState.isLoggedIn,
      distinct: true,
      onInitialBuild: (isLoggedIn) {
        if (isLoggedIn) {
          _handleRedirect();
        }
      },
      onWillChange: (prev, curr) {
        if (curr == true && prev != true) {
          _handleRedirect();
        }
      },
      builder: (context, isLoggedIn) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/akalpit.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  AppConstants.appName,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
