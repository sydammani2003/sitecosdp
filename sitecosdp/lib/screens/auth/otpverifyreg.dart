import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/io_client.dart';
import 'package:sitecosdp/screens/auth/login.dart';
import 'package:sitecosdp/screens/auth/ngroklink.dart';

class OTPVerifyPage extends StatefulWidget {
  final String? otptoken;

  const OTPVerifyPage({Key? key, this.otptoken}) : super(key: key);

  @override
  State<OTPVerifyPage> createState() => _OTPVerifyPageState();
}

class _OTPVerifyPageState extends State<OTPVerifyPage> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> otpverifyreg(String otp) async {
    try {
      var httpClient = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      var ioClient = IOClient(httpClient);

      var response = await ioClient.post(
        Uri.parse('${apilink}verify-otp/'),
        body: {'otp_token': widget.otptoken, 'otp': otp},
      );

      var data = jsonDecode(response.body);
      if (data['message'] == 'Registration successful') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Loginscreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Verification failed')),
        );
      }
    } catch (e) {
      print('Error during API call: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error verifying OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Gradient gradient = const LinearGradient(
      colors: [
        Color(0xFFAA60C8),
        Color(0xFFD69ADE),
        Color(0xFFEABDE6),
        Color(0xFFFFDFEF),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Enter OTP",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.5),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: 50,
                        height: 60,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          onChanged: (val) => _onChanged(val, index),
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ).animate().scale(delay: (index * 100).ms),
                  );
                }),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  String otp = _controllers.map((e) => e.text).join();
                  if (otp.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter full OTP")),
                    );
                    return;
                  }
                  otpverifyreg(otp);
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  backgroundColor: const Color(0xFFAA60C8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 10,
                ),
                child: const Text(
                  "Verify",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.5),
            ],
          ).animate().fadeIn(duration: 1000.ms).slideY(begin: 1),
        ),
      ),
    );
  }
}
