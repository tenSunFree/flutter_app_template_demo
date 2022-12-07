import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_app_template_demo/common/extensions/exception_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../common/exceptions/app_exception.dart';
import '../../../common/utils/logger.dart';
import '../entities/sport_cat_entity.dart';
import 'api_client.dart';

final sportRepositoryProvider = Provider<SportRepository>((ref) {
  return SportRepository(ref);
});

class SportRepository {
  SportRepository(
    Ref ref,
  ) : _client = ref.read(apiClientProvider);

  final ApiClient _client;

  Future<List<SportCatEntity>> fetchCat({
    int? since,
    int? perPage,
  }) async {
    try {
      final result = await _client.fetchCat(since, perPage);
      return result;
    } on DioError catch (e) {
      final response = e.response;
      logger.shout(
        'statusCode: ${response?.statusCode}, '
        'message: ${response?.statusMessage}',
      );
      throw AppException.error(e.message);
    } on Exception catch (e) {
      logger.shout(e);
      throw AppException.error(e.errorMessage);
    }
  }
}
