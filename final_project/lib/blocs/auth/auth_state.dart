import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool loading;
  final bool authenticated;
  final String? uid;
  final String? email;
  final String? username;
  final String? error;

  const AuthState({
    this.loading = false,
    this.authenticated = false,
    this.uid,
    this.email,
    this.username,
    this.error,
  });

  const AuthState.initial() : this();

  AuthState copyWith({
    bool? loading,
    bool? authenticated,
    String? uid,
    String? email,
    String? username,
    String? error,
    bool clearError = false,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      authenticated: authenticated ?? this.authenticated,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props =>
      [loading, authenticated, uid, email, username, error];
}
