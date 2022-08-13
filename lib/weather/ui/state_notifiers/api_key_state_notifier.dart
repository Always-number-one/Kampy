import '../../core/failure.dart';
import '../../data/models/api_key_model.dart';
import '../../data/repos/api_key_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

@sealed
@immutable
abstract class ApiKeyState extends Equatable {
  const ApiKeyState();

  ApiKeyModel? get apiKey => null;

  @override
  List<Object?> get props => const [];
}

class Empty extends ApiKeyState {
  const Empty();
}

class Loading extends ApiKeyState {
  const Loading();
}

class Loaded extends ApiKeyState {
  const Loaded(this.apiKey);

  @override
  final ApiKeyModel apiKey;

  @override
  List<Object?> get props => [apiKey];
}

class Error extends ApiKeyState {
  const Error(this.failure, {this.apiKey});

  final Failure failure;

  @override
  final ApiKeyModel? apiKey;

  @override
  List<Object?> get props => [failure, apiKey];
}

class ApiKeyStateNotifier extends StateNotifier<ApiKeyState> {
  ApiKeyStateNotifier(this._apiKeyRepo) : super(const Empty());

  final ApiKeyRepo _apiKeyRepo;

  Future<void> loadApiKey() async {
    state = const Loading();
    final data = await _apiKeyRepo.getApiKey();
    state = data.fold(Error.new, Loaded.new);
  }

  Future<void> setApiKey(ApiKeyModel apiKey) async {
    (await _apiKeyRepo.setApiKey(apiKey)).fold((failure) {
      state = Error(failure, apiKey: state.apiKey);
    }, (_) {
      state = Loaded(apiKey);
    });
  }
}

final apiKeyStateNotifierProvider =
    StateNotifierProvider<ApiKeyStateNotifier, ApiKeyState>(
  (ref) => ApiKeyStateNotifier(ref.watch(apiKeyRepoProvider)),
);
