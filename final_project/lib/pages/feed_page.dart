import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../l10n/app_localizations.dart';
import '../blocs/auth/auth_cubit.dart';
import '../blocs/post/post_cubit.dart';
import '../blocs/post/post_state.dart';
import '../core/widgets/post_card.dart';
import '../core/widgets/saida_logo.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const SaidaLogo(fontSize: 28),
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state.loading && state.posts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null && state.posts.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('${t.errorGeneric}\n${state.error}',
                    textAlign: TextAlign.center),
              ),
            );
          }
          if (state.posts.isEmpty) {
            return Center(
              child: Text(
                t.feedEmpty,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }
          final auth = context.watch<AuthCubit>().state;
          return ListView.builder(
            padding: const EdgeInsets.only(top: 6, bottom: 16),
            itemCount: state.posts.length,
            itemBuilder: (context, i) {
              final p = state.posts[i];
              final liked = auth.uid != null && p.likedBy.contains(auth.uid);
              return PostCard(
                post: p,
                index: i,
                likedByMe: liked,
                onLike: () {
                  if (auth.uid == null) return;
                  context.read<PostCubit>().toggleLike(
                        postId: p.postId,
                        uid: auth.uid!,
                        currentlyLiked: liked,
                      );
                },
              );
            },
          );
        },
      ),
    );
  }
}
