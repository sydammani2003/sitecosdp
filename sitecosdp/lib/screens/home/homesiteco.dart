// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:simple_animations/simple_animations.dart';

class Homesiteco extends StatefulWidget {
  const Homesiteco({super.key});

  @override
  _HomesitecoState createState() => _HomesitecoState();
}

class _HomesitecoState extends State<Homesiteco>
    with SingleTickerProviderStateMixin {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;

  String _detectedText = "Waiting for signs...";

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera =
        cameras.firstWhere((c) => c.lensDirection == CameraLensDirection.back);

    _cameraController =
        CameraController(camera, ResolutionPreset.high, enableAudio: false);
    await _cameraController.initialize();
    if (!mounted) return;

    setState(() {
      _isCameraInitialized = true;
    });

    Future.delayed(const Duration(seconds: 3), _simulateDetection);
  }

  void _simulateDetection() {
    setState(() {
      _detectedText = "Hello, how are you?";
    });

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _detectedText = "Good Morning!";
      });
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customPalette = [
      const Color(0xFF2E073F),
      const Color(0xFF7A1CAC),
      const Color(0xFFAD49E1),
      const Color(0xFFEBD3F8),
    ];

    return Scaffold(
      body: Stack(
        children: [
          _isCameraInitialized
              ? CameraPreview(_cameraController)
              : const Center(child: CircularProgressIndicator()),
          Positioned.fill(
            child: CustomParticles(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 28.0,
                  color: customPalette[0],
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TyperAnimatedText(_detectedText),
                  ],
                  onTap: () {},
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  customPalette[3].withOpacity(0.1),
                  customPalette[0].withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Siteco",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: customPalette[0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomParticles extends StatelessWidget {
  const CustomParticles({super.key});
  @override
  Widget build(BuildContext context) {
    return LoopAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 100),
      duration: const Duration(seconds: 20),
      builder: (context, value, child) {
        return CustomPaint(
          painter: ParticlePainter(value),
        );
      },
    );
  }
}

class ParticlePainter extends CustomPainter {
  final double animationValue;

  ParticlePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.3);
    final random = animationValue;

    for (int i = 0; i < 50; i++) {
      final x = (i * 70 + random * 5) % size.width;
      final y = (i * 30 + random * 10) % size.height;
      canvas.drawCircle(Offset(x, y), 2.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
