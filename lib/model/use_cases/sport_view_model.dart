import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../entities/sport_cat_entity.dart';
import '../repositories/sport_repository.dart';

final sportViewModelProvider = StateNotifierProvider.autoDispose<SportViewModel,
    AsyncValue<List<SportCatEntity>>>((ref) {
  return SportViewModel(ref);
});

class SportViewModel extends StateNotifier<AsyncValue<List<SportCatEntity>>> {
  SportViewModel(
    this._ref,
  ) : super(const AsyncValue.loading());

  final Ref _ref;
  int _lastUserId = 0;
  bool _loading = false;
  final _pageCount = 20;

  SportRepository get _githubApiRepository =>
      _ref.read(sportRepositoryProvider);

  Future<void> fetch() async {
    if (_loading) {
      return;
    }
    _loading = true;
    _lastUserId = 0;
    final result = await AsyncValue.guard(() async {
      final data = await _githubApiRepository.fetchCat(
        since: _lastUserId,
        perPage: _pageCount,
      );
      if (data.isNotEmpty) {
        _lastUserId++;
      }
      return data;
    });
    _loading = false;
    state = result;
  }

  Future<void> fetchMore() async {
    if (_loading) {
      return;
    }
    _loading = true;
    final result = await AsyncValue.guard(() async {
      final data = await _githubApiRepository.fetchCat(
        since: _lastUserId,
        perPage: _pageCount,
      );
      if (data.isNotEmpty) {
        _lastUserId++;
      }
      final value = state.value ?? [];
      return [...value, ...data];
    });
    _loading = false;
    state = result;
  }
}
