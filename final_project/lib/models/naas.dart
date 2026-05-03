import 'package:json_annotation/json_annotation.dart';

part 'naas.g.dart';

@JsonSerializable()
class NaasReason {
  final String reason;

  NaasReason({required this.reason});

  factory NaasReason.fromJson(Map<String, dynamic> json) =>
      _$NaasReasonFromJson(json);
  Map<String, dynamic> toJson() => _$NaasReasonToJson(this);
}
