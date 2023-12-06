import 'package:flutter/material.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/primary_button.dart';

class HomeBottomSheet extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const HomeBottomSheet({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.backgroundSecondaryColor,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            PrimaryButton(
              withBorder: false,
              onPressed: onEdit,
              text: 'Edit',
            ),
            const SizedBox(height: 10),
            PrimaryButton(
              withBorder: true,
              onPressed: onDelete,
              text: 'Delete',
            ),
            const SizedBox(height: 10),
            PrimaryButton(
              withBorder: true,
              onPressed: () => Navigator.pop(context),
              text: 'Cancel',
            ),
          ],
        ),
      ),
    );
  }
}
