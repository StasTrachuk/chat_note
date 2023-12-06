import 'package:flutter/material.dart';
import 'package:home_work/settings/context_theme.dart';

class SelectIconButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String asset;

  const SelectIconButton({
    required this.onTap,
    required this.isSelected,
    required this.asset,
    super.key,
  });

  @override
  State<SelectIconButton> createState() => _SelectIconButtonState();
}

class _SelectIconButtonState extends State<SelectIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );
    animation = Tween(begin: 58.0, end: 50.0).animate(controller)
      ..addListener(
        () => controller.status == AnimationStatus.completed
            ? controller.reverse()
            : null,
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            widget.onTap();
            controller.forward();
          },
          child: Container(
            height: animation.value,
            width: animation.value,
            decoration: BoxDecoration(
              gradient: widget.isSelected
                  ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xffbccbff),
                        Color(0xfffadaff),
                      ],
                    )
                  : null,
              color: context.theme.selectIconButtonColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                widget.asset,
                width: 24,
                height: 24,
              ),
            ),
          ),
        );
      },
    );
  }
}
