import 'package:flutter/material.dart';

class GlowingImage extends StatefulWidget {
  const GlowingImage({super.key});

  @override
  State<GlowingImage> createState() => _GlowingImageState();
}

class _GlowingImageState extends State<GlowingImage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 30.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
              decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                blurRadius: _animation.value,
                spreadRadius: _animation.value / 2,
              ),
            ],
          ));
        });
  }
}
