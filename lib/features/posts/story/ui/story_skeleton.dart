import 'package:akalpit/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
 

class StorySkeleton extends StatelessWidget {
  const StorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final paragraphHeight = screenHeight * 0.25; // 1/4 screen height

    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.scaffoldBackground,
            elevation: 1,
            floating: true,
            snap: true,
            title: Container(
              height: 18,
              width: 160,
              decoration: _box(),
            ),
            centerTitle: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 28), // 👈 gap between paragraphs
                    child: _paragraphSkeleton(paragraphHeight),
                  );
                },
                childCount: 4, // fewer, more realistic paragraphs
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paragraphSkeleton(double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _line(),
        const SizedBox(height: 10),
        _line(),
        const SizedBox(height: 10),
        _line(width: 260),
        const SizedBox(height: 14),
        _line(),
        const SizedBox(height: 10),
        _line(width: 200),
        const SizedBox(height: 16),
        _line(),
      ],
    );
  }

  Widget _line({double? width}) {
    return Container(
      height: 14,
      width: width ?? double.infinity,
      decoration: _box(),
    );
  }

  BoxDecoration _box() {
    return BoxDecoration(
      color: Colors.white.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6),
    );
  }
}
