import 'package:casino_test/src/core/network/network_info.dart';
import 'package:casino_test/src/data/data_sources/remote_data_source/character_remote_data_source.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/data/repository/characters_repository_impl.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/snapshot_cache/character_snapshot_cache.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getIt = GetIt.I;

class MainDIModule {
  void configure() {
//  snapshot cache
    getIt.registerFactory<CharacterSnapshotCache>(
        () => CharacterSnapshotCache());

    // blocs
    getIt.registerFactory<MainPageBloc>(
      () => MainPageBloc(snapshotCache: getIt(), charactersRepository: getIt()),
    );

    // repositories
    getIt.registerLazySingleton<CharactersRepository>(
      () => CharactersRepositoryImpl(
          networkInfo: getIt(), remoteDataSource: getIt()),
    );

    // data-sources
    getIt.registerLazySingleton<CharacterRemoteDataSource>(
      () => CharacterRemoteDataSourceImpl(client: getIt()),
    );

    // network
    getIt.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(connectionChecker: getIt()));

    // external
    getIt.registerLazySingleton<Client>(() => Client());
    getIt.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker());
  }
}
