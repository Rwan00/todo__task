import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          LucideIcons.loader,
          size: 50,
        ),
        const SizedBox(height: 16),
        const CircularProgressIndicator(
          strokeWidth: 3,
        ),
        const SizedBox(height: 16),
        Text(
          "Please wait...",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
