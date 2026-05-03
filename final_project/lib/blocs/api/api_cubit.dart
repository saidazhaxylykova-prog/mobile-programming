import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/rest_client.dart';
import 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  final RestClient _client;

  ApiCubit(this._client) : super(const ApiState());

  Future<void> loadReasons() async {
    emit(state.copyWith(loading: true, clearError: true));
    try {
      final futures = List.generate(20, (_) => _client.getOne());
      final results = await Future.wait(futures);
      final reasons = results.map((r) => r.reason).toList();
      emit(state.copyWith(loading: false, reasons: reasons));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
