import 'package:flutter/material.dart';

/// Retro CRT-style background with vignette effect
class RetroBackground extends StatelessWidget {
  final Widget child;
  final bool enableScanlines;
  
  const RetroBackground({
    super.key,
    required this.child,
    this.enableScanlines = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main content
        child,
        
        // Vignette overlay
        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.5),
                ],
                stops: const [0.5, 1.0],
              ),
            ),
          ),
        ),
        
        // Scanlines effect (optional, may affect performance)
        if (enableScanlines)
          IgnorePointer(
            child: CustomPaint(
              size: Size.infinite,
              painter: ScanlinePainter(),
            ),
          ),
      ],
    );
  }
}

/// Custom painter for scanline effect
class ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..strokeWidth = 1;
    
    // Draw horizontal lines
    for (double y = 0; y < size.height; y += 3) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
