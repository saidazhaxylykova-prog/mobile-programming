import 'package:equatable/equatable.dart';
import '../../models/post.dart';

class PostState extends Equatable {
  final bool loading;
  final List<Post> posts;
  final String? error;
  final bool creating;

  const PostState({
    this.loading = true,
    this.posts = const [],
    this.error,
    this.creating = false,
  });

  PostState copyWith({
    bool? loading,
    List<Post>? posts,
    String? error,
    bool? creating,
    bool clearError = false,
  }) {
    return PostState(
      loading: loading ?? this.loading,
      posts: posts ?? this.posts,
      error: clearError ? null : (error ?? this.error),
      creating: creating ?? this.creating,
    );
  }

  @override
  List<Object?> get props => [loading, posts, error, creating];
}
