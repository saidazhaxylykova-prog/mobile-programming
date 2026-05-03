import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class LikeButton extends StatefulWidget {
  final bool liked;
  final int count;
  final VoidCallback onTap;

  const LikeButton({
    super.key,
    required this.liked,
    required this.count,
    required this.onTap,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  double _scale = 1.0;

  void _handleTap() async {
    setState(() => _scale = 1.4);
    widget.onTap();
    await Future.delayed(const Duration(milliseconds: 150));
    if (mounted) setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: _handleTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: _scale,
              duration: const Duration(milliseconds: 150),
              curve: Curves.elasticOut,
              child: Icon(
                widget.liked ? Icons.favorite : Icons.favorite_border,
                color: widget.liked ? AppColors.heart : null,
                size: 26,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '${widget.count}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
