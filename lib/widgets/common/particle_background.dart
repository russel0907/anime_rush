import 'dart:math';
import 'package:flutter/material.dart';
import '../../config/theme.dart';

class ParticleBackground extends StatefulWidget {
  final Widget child;
  final int particleCount;

  const ParticleBackground({
    super.key,
    required this.child,
    this.particleCount = 20,
  });

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    final random = Random();
    for (int i = 0; i < widget.particleCount; i++) {
      _particles.add(_Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 3 + 1,
        speed: random.nextDouble() * 0.02 + 0.005,
        opacity: random.nextDouble() * 0.3 + 0.1,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            if (child != null) child,
            ..._particles.map((particle) {
              particle.y += particle.speed;
              if (particle.y > 1) {
                particle.y = -0.05;
                particle.x = Random().nextDouble();
              }
              return Positioned(
                left: particle.x * MediaQuery.of(context).size.width,
                top: particle.y * MediaQuery.of(context).size.height,
                child: Container(
                  width: particle.size,
                  height: particle.size,
                  decoration: BoxDecoration(
                    color: AppColors.accentCyan.withOpacity(particle.opacity),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentCyan.withOpacity(
                          particle.opacity * 0.5,
                        ),
                        blurRadius: particle.size * 2,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
      child: widget.child,
    );
  }
}

class _Particle {
  double x;
  double y;
  final double size;
  final double speed;
  final double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}
