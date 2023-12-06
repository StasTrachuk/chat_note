import 'package:flutter/material.dart';
import 'package:home_work/settings/context_theme.dart';

class AnimatedIconButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool? isAvaible;
  final String asset;

  const AnimatedIconButton({
    required this.onTap,
    required this.asset,
    this.isAvaible,
    super.key,
  });

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );
    animation = Tween(begin: 24.0, end: 20.0).animate(controller)
      ..addListener(
        () => controller.status == AnimationStatus.completed
            ? controller.reverse()
            : null,
      );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isAvaible ?? true) {
          widget.onTap();
        }
        controller.forward();
      },
      child: SizedBox(
        width: 40,
        child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            return Image.asset(
              widget.asset,
              height: animation.value,
              width: animation.value,
              color: widget.isAvaible ?? true
                  ? context.theme.iconSecondaryColor
                  : context.theme.buttonNotActiveColor,
            );
          },
        ),
      ),
    );
  }
}
