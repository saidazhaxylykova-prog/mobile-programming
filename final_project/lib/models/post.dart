import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String userId;
  final String username;
  final String content;
  final DateTime createdAt;
  final int likesCount;
  final List<String> likedBy;

  Post({
    required this.postId,
    required this.userId,
    required this.username,
    required this.content,
    required this.createdAt,
    required this.likesCount,
    required this.likedBy,
  });

  factory Post.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    final ts = data['createdAt'];
    DateTime date;
    if (ts is Timestamp) {
      date = ts.toDate();
    } else {
      date = DateTime.now();
    }
    return Post(
      postId: doc.id,
      userId: data['userId'] ?? '',
      username: data['username'] ?? '',
      content: data['content'] ?? '',
      createdAt: date,
      likesCount: (data['likesCount'] ?? 0) is int
          ? data['likesCount']
          : (data['likesCount'] as num).toInt(),
      likedBy: List<String>.from(data['likedBy'] ?? const []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
      'likesCount': likesCount,
      'likedBy': likedBy,
    };
  }
}
