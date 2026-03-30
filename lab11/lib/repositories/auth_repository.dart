class AuthRepository {
  Future<bool> login({required String email, required String password}) async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }
}
