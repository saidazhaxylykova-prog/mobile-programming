import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/naas.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://naas.isalman.dev')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl, ParseErrorLogger? errorLogger}) =
      _RestClient;

  @GET('/no')
  Future<NaasReason> getOne();
}
