import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  String email;

  OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();

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
                'Enter 4 Digit Code',
                style: TextStyle(
                  fontFamily: 'GeneralSans',
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Enter 4 digit code that your receive on your \nemail (${widget.email}).",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF808080),
                ),
              ),
              const SizedBox(height: 20),
              TextFields(
                name: 'otp',
                hintText: 'Enter OTP',
                controller: _otpController,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: const Text.rich(
                  TextSpan(
                    text: 'Email not received?  ',
                    children: [
                      TextSpan(
                        text: 'Reset your password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Button(
                name: 'Continue',
                textColor: Colors.white,
                color: WidgetStateProperty.all<Color>(
                  const Color(0xFF1A1A1A),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sending Code...')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFields extends StatefulWidget {
  final String name;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final IconButton? passwordVisibilityIcon;

  const TextFields({
    super.key,
    required this.name,
    required this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.passwordVisibilityIcon,
  });

  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isObscure = true; // Track whether password is obscured

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isValid = widget.validator?.call(widget.controller.text) == null;

    Color getBorderColor() {
      if (!_isFocused && widget.controller.text.isEmpty) {
        return Colors.grey;
      }
      return isValid ? Colors.green : Colors.red;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: const TextStyle(
            fontFamily: 'GeneralSans',
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          // Wrap with Container to set fixed height
          height: 60, // Fixed height
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.obscureText && _isObscure,
            cursorColor: const Color(0xFF808080),
            validator: widget.validator,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w300,
                color: Color(0xFF808080),
                fontFamily: 'GeneralSans',
              ),
              suffix: widget.obscureText
                  ? IconButton(
                      icon: _isObscure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: getBorderColor(),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: getBorderColor(),
                  width: 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final WidgetStateProperty<Color?> color;
  final String name;
  final Color textColor;
  final String? imagePath;
  final bool isOutlined;
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.name,
    required this.textColor,
    required this.color,
    this.imagePath,
    this.isOutlined = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton(
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all<Size>(const Size.fromHeight(55)),
          side: WidgetStateProperty.all<BorderSide>(
            BorderSide(color: textColor),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(imagePath!, width: 30, height: 30),
            if (imagePath != null) const SizedBox(width: 10),
            Text(
              name,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      );
    } else {
      return ElevatedButton(
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all<Size>(const Size.fromHeight(55)),
          backgroundColor: color,
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(imagePath!, width: 30, height: 30),
            if (imagePath != null) const SizedBox(width: 10),
            Text(
              name,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      );
    }
  }
}
