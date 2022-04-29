import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/data/repository/characters_repository_impl.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getIt = GetIt.I;

class MainDIModule {
  void configure() {
    // blocs
    getIt.registerFactory<MainPageBloc>(
        () => MainPageBloc(charactersRepository: getIt()));

    // repositories
    final _client = Client();
    getIt.registerLazySingleton<CharactersRepository>(
        () => CharactersRepositoryImpl(client: _client));
  }
}
