import 'package:equatable/equatable.dart';

class ApiState extends Equatable {
  final bool loading;
  final List<String> reasons;
  final String? error;

  const ApiState({
    this.loading = false,
    this.reasons = const [],
    this.error,
  });

  ApiState copyWith({
    bool? loading,
    List<String>? reasons,
    String? error,
    bool clearError = false,
  }) {
    return ApiState(
      loading: loading ?? this.loading,
      reasons: reasons ?? this.reasons,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [loading, reasons, error];
}
