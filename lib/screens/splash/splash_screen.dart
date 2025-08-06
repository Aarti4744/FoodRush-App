import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import 'dart:math';

/// SPLASH SCREEN WIDGET
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _logoController;

  @override
  void initState() {
    super.initState();

    // 🌀 Rotating rays
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    // ✨ Logo scale/fade
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/intro');
    });

  }

  @override
  void dispose() {
    _rotationController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  /// 🟠 Reusable Circle Widget for 'o'
  Widget _circle(String char) {
    return Container(
      width: 36,
      height: 36,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.orange[400],
        shape: BoxShape.circle,
      ),
      child: Text(
        char,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  /// MAIN BUILD METHOD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Stack(
        children: [
          // 🌀 TOP-LEFT ROTATING RAYS
          Positioned(
            top: -50,
            left: -50,
            child: AnimatedBuilder(
              animation: _rotationController,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _rotationController.value * 2 * pi,
                  child: child,
                );
              },
              child: CustomPaint(
                size: const Size(200, 200),
                painter: SunRayPainter(color: Colors.grey.shade300),
              ),
            ),
          ),

          // 🌀 BOTTOM-RIGHT ROTATING RAYS
          Positioned(
            bottom: -50,
            right: -50,
            child: AnimatedBuilder(
              animation: _rotationController,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _rotationController.value * 2 * pi,
                  child: child,
                );
              },
              child: CustomPaint(
                size: const Size(200, 200),
                painter: SunRayPainter(color: Colors.orange.shade400),
              ),
            ),
          ),

          // 🍽️ CENTER LOGO WITH ANIMATION
          Center(
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _logoController,
                curve: Curves.easeOutBack,
              ),
              child: FadeTransition(
                opacity: _logoController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🔤 'Food' Text Row Only
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'F',
                          style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        _circle('o'),
                        _circle('o'),
                        Text(
                          'd',
                          style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4), // Minimal spacing

                    // ➖ Speed lines
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (i) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          height: 2,
                          width: 14 - (i * 4),
                          color: Colors.orange.shade300,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🎨 SUN RAY PAINTER FOR CORNERS
class SunRayPainter extends CustomPainter {
  final Color color;
  SunRayPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint rayPaint = Paint()
      ..color = color
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final int rays = 62;
    final double radius = size.width / 2;
    final double rayLength = radius * 2;

    // Draw radial rays
    for (int i = 0; i < rays; i++) {
      final angle = (i * (360 / rays)) * pi / 180;
      final x = radius + rayLength * cos(angle);
      final y = radius + rayLength * sin(angle);

      canvas.drawLine(
        Offset(radius, radius),
        Offset(x, y),
        rayPaint,
      );
    }

    // Mask center
    final Paint maskPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(radius, radius), radius * 0.3, maskPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
