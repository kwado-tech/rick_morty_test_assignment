import 'package:casino_test/src/core/exceptions/exceptions.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_event.dart';
part 'main_bloc.freezed.dart';

class MainPageBloc extends Bloc<MainBlocEvent,
    BlocState<Failure<ExceptionMessage>, CharacterList>> {
  final CharactersRepository _charactersRepository;

  MainPageBloc({required CharactersRepository charactersRepository})
      : _charactersRepository = charactersRepository,
        super(const BlocState<Failure<ExceptionMessage>,
            CharacterList>.initial()) {
    on<MainBlocEvent>(
      (event, emitter) => _getDataOnMainPageCasino(event, emitter),
    );
  }

  Future<void> _getDataOnMainPageCasino(
    MainBlocEvent event,
    Emitter<BlocState<Failure<ExceptionMessage>, CharacterList>> emit,
  ) async {
    final _getCharactersEither = await _charactersRepository
        .getCharacters(event.getCharactersFormParams);

    final _state = _getCharactersEither.fold(
      (failure) => BlocState<Failure<ExceptionMessage>, CharacterList>.error(
          failure: failure),
      (characterList) =>
          BlocState<Failure<ExceptionMessage>, CharacterList>.success(
              data: characterList),
    );

    emit(_state);
  }
}
