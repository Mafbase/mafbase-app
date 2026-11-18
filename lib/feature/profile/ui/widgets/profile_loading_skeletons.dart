import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/shimmer.dart';

class ProfileLoadingSkeletons extends StatelessWidget {
  const ProfileLoadingSkeletons({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final skeletonColor = theme.greyColor.withValues(alpha: 0.15);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Shimmer(
            linearGradient: shimmerGradient,
            child: Column(
              children: [
                const SizedBox(height: 40),
                ShimmerLoading(
                  isLoading: true,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: skeletonColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ShimmerLoading(
                  isLoading: true,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: skeletonColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ShimmerLoading(
                  isLoading: true,
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      color: skeletonColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
