import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import '../entities/sport_cat_entity.dart';
import 'constants.dart';

part 'api_client.g.dart';

final apiClientProvider = Provider((ref) {
  return ApiClient(
    Dio(dioDefaultOptions)
      ..interceptors.addAll(
        [LogInterceptor(requestBody: true, responseBody: true)],
      ),
    baseUrl: 'https://api.thecatapi.com/v1',
  );
});

@RestApi()
abstract class ApiClient {
  factory ApiClient(
    Dio dio, {
    String baseUrl,
  }) = _ApiClient;

  @GET('/images/search')
  Future<List<SportCatEntity>> fetchCat(
    @Query('page') int? since,
    @Query('limit') int? perPage,
  );
}
