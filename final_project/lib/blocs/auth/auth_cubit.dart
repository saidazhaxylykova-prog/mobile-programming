import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/storage/preferences_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final PreferencesService _prefs;
  StreamSubscription<User?>? _sub;

  AuthCubit(this._auth, this._db, this._prefs)
      : super(const AuthState.initial()) {
    _sub = _auth.authStateChanges().listen(_handleUser);
  }

  Future<void> _handleUser(User? user) async {
    if (user == null) {
      await _prefs.clearUsername();
      emit(const AuthState(authenticated: false));
      return;
    }
    String username = _prefs.getCachedUsername() ?? _emailPrefix(user.email);
    try {
      final doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null && data['username'] is String) {
          username = data['username'];
        }
      } else {
        await _db.collection('users').doc(user.uid).set({
          'email': user.email ?? '',
          'username': username,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (_) {}
    await _prefs.setCachedUsername(username);
    emit(AuthState(
      authenticated: true,
      uid: user.uid,
      email: user.email,
      username: username,
    ));
  }

  String _emailPrefix(String? email) {
    if (email == null || email.isEmpty) return 'user';
    final at = email.indexOf('@');
    if (at <= 0) return email;
    return email.substring(0, at);
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(loading: true, clearError: true));
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(loading: false, error: e.message ?? e.code));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(state.copyWith(loading: true, clearError: true));
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(loading: false, error: e.message ?? e.code));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> updateUsername(String newUsername) async {
    final uid = state.uid;
    if (uid == null) return;
    final clean = newUsername.trim();
    if (clean.isEmpty) return;
    await _db.collection('users').doc(uid).update({'username': clean});
    await _prefs.setCachedUsername(clean);
    emit(state.copyWith(username: clean));
  }

  void clearError() {
    if (state.error != null) emit(state.copyWith(clearError: true));
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
