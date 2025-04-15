import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'otp_screen.dart'; // Update the import path

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String? _errorMessage;

  void resetPassword() async {
    if (_emailController.text.isEmpty ||
        !_emailController.text.contains('@') ||
        !_emailController.text.contains('.')) {
      setState(() {
        _errorMessage = 'Please enter a valid email address';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(email: _emailController.text),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Forgot password',
                style: TextStyle(
                  fontFamily: 'GeneralSans',
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Enter your email for the verification process. \nWe will send a 4-digit code to your email.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF808080),
                ),
              ),
              const SizedBox(height: 20),
              TextFields(
                name: 'Email',
                hintText: 'Enter your email address',
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty ||
                      !value.contains('@') ||
                      !value.contains('.')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 8),
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
              const SizedBox(height: 20),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Button(
                  name: 'Send Code',
                  textColor: Colors.white,
                  color: WidgetStateProperty.all<Color>(
                    const Color(0xFF1A1A1A),
                  ),
                  onPressed: resetPassword,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
