import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/post.dart';
import 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final FirebaseFirestore _db;
  StreamSubscription? _sub;

  PostCubit(this._db) : super(const PostState());

  void watchFeed() {
    _sub?.cancel();
    emit(state.copyWith(loading: true, clearError: true));
    _sub = _db
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snap) {
      final list = snap.docs.map((d) => Post.fromDoc(d)).toList();
      emit(state.copyWith(loading: false, posts: list, clearError: true));
    }, onError: (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    });
  }

  Future<void> createPost({
    required String userId,
    required String username,
    required String content,
  }) async {
    final text = content.trim();
    if (text.isEmpty) return;
    emit(state.copyWith(creating: true, clearError: true));
    try {
      await _db.collection('posts').add({
        'userId': userId,
        'username': username,
        'content': text,
        'createdAt': FieldValue.serverTimestamp(),
        'likesCount': 0,
        'likedBy': <String>[],
      });
      emit(state.copyWith(creating: false));
    } catch (e) {
      emit(state.copyWith(creating: false, error: e.toString()));
    }
  }

  Future<void> toggleLike({
    required String postId,
    required String uid,
    required bool currentlyLiked,
  }) async {
    final ref = _db.collection('posts').doc(postId);
    if (currentlyLiked) {
      await ref.update({
        'likedBy': FieldValue.arrayRemove([uid]),
        'likesCount': FieldValue.increment(-1),
      });
    } else {
      await ref.update({
        'likedBy': FieldValue.arrayUnion([uid]),
        'likesCount': FieldValue.increment(1),
      });
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
