import 'dart:async';
import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/auth/services/auth_actions.dart';
import 'package:akalpit/features/auth/services/auth_state.dart';
import 'package:akalpit/features/auth/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

 
import '../../../../../core/utils/responsive_utils.dart';

class VerificationScreen extends StatefulWidget {
  final String email;

  const VerificationScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  static const int otpLength = 6;

  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  Timer? _timer;
  int _secondsRemaining = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(otpLength, (_) => FocusNode());
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 60;
      _canResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        setState(() => _canResend = true);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(String value, int index) {
    if (value.length == 1 && index < otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String get _enteredOtp => _controllers.map((c) => c.text).join();

  void _verifyOtp(BuildContext context) {
    if (_enteredOtp.length != otpLength) {
      _showSnack(context, "Please enter complete OTP");
      return;
    }

    StoreProvider.of<AppState>(context).dispatch(
      VerifyOtpAction(widget.email, _enteredOtp),
    );
  }

  void _resendOtp(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(
      ResendOtpAction(widget.email),
    );
    _startTimer();
  }

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthState>(
      distinct: true,
      converter: (store) => store.state.authState,
      
     
      onDidChange: (prev, auth) {
       
        if (auth.isOtpVerified && !(prev?.isOtpVerified ?? false)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          });
        }

 
        if (auth.errorMessage != null && auth.errorMessage != prev?.errorMessage) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showSnack(context, auth.errorMessage!);
            
      
            StoreProvider.of<AppState>(context).dispatch(ClearAuthErrorAction());
          });
        }
      },
      
      builder: (context, auth) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
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
                  constraints: const BoxConstraints(maxWidth: 550),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Verify your email",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "We sent a 6-digit code to\n${widget.email}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 32),
                      
                      // OTP INPUTS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          otpLength,
                          (index) => SizedBox(
                            width: 48,
                            height: 56,
                            child: TextField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              maxLength: 1,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                counterText: "",
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white24),
                                ),
                              ),
                              onChanged: (v) => _onCodeChanged(v, index),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _canResend
                            ? "OTP expired"
                            : "OTP expires in 00:${_secondsRemaining.toString().padLeft(2, '0')}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 30),
                      
                      // CONFIRM BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: auth.isLoading
                              ? null
                              : () => _verifyOtp(context),
                          child: auth.isLoading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text("Confirm"),
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // RESEND BUTTON
                      TextButton(
                        onPressed: _canResend
                            ? () => _resendOtp(context)
                            : null,
                        child: Text(
                          "Resend code",
                          style: TextStyle(
                            color: _canResend ? Colors.white : Colors.white38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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