import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/post.dart';
import '../constants/app_colors.dart';
import 'like_button.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final int index;
  final bool likedByMe;
  final VoidCallback onLike;

  const PostCard({
    super.key,
    required this.post,
    required this.index,
    required this.likedByMe,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    final initial = post.username.isNotEmpty
        ? post.username[0].toUpperCase()
        : '?';
    final time = DateFormat.yMMMd().add_jm().format(post.createdAt.toLocal());

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 40).clamp(0, 240)),
      curve: Curves.easeOutCubic,
      tween: Tween(begin: 0, end: 1),
      builder: (context, v, child) {
        return Opacity(
          opacity: v,
          child: Transform.translate(
            offset: Offset(0, 18 * (1 - v)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        gradient: AppColors.gradientPink,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        initial,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.username,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.color
                                  ?.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  post.content,
                  style: const TextStyle(fontSize: 15, height: 1.35),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    LikeButton(
                      liked: likedByMe,
                      count: post.likesCount,
                      onTap: onLike,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
