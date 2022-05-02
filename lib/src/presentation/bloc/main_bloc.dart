import 'package:casino_test/src/core/constants.dart';
import 'package:casino_test/src/core/exceptions/exceptions.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stream_transform/stream_transform.dart';

part 'main_event.dart';
part 'main_bloc.freezed.dart';

const _duration = Duration(milliseconds: Sizing.kDebounceDuration);

EventTransformer<Event> _debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class MainPageBloc extends Bloc<MainBlocEvent,
    BlocState<Failure<ExceptionMessage>, CharacterList>> {
  final CharactersRepository _charactersRepository;

  MainPageBloc({required CharactersRepository charactersRepository})
      : _charactersRepository = charactersRepository,
        super(const BlocState<Failure<ExceptionMessage>,
            CharacterList>.initial()) {
    on<MainBlocEvent>(
      (event, emitter) => _getDataOnMainPageCasino(event, emitter),
      transformer: _debounce(_duration),
    );
  }

  BlocState<Failure<ExceptionMessage>, CharacterList> get _currentBlocState =>
      super.state;

  bool _hasReachedMax(
          BlocState<Failure<ExceptionMessage>, CharacterList> state) =>
      state is Success<Failure<ExceptionMessage>, CharacterList> &&
      state.hasReachedMax;

  Future<void> _getDataOnMainPageCasino(
    MainBlocEvent event,
    Emitter<BlocState<Failure<ExceptionMessage>, CharacterList>> emit,
  ) async {
    if (_hasReachedMax(_currentBlocState)) return;

    if (_currentBlocState
        is Initial<Failure<ExceptionMessage>, CharacterList>) {
      final _getCharactersEither = await _charactersRepository
          .getCharacters(event.getCharactersFormParams);

      final _state = _getCharactersEither.fold(
        (failure) => BlocState<Failure<ExceptionMessage>, CharacterList>.error(
            failure: failure),
        (characterList) =>
            BlocState<Failure<ExceptionMessage>, CharacterList>.success(
          hasReachedMax: false,
          data: characterList,
        ),
      );

      return emit(_state);
    }

    // else case
    final _getCharactersEither = await _charactersRepository
        .getCharacters(event.getCharactersFormParams);

    final _state = _getCharactersEither.fold(
      (failure) => BlocState<Failure<ExceptionMessage>, CharacterList>.error(
          failure: failure),
      (characterList) {
        if (characterList.isEmpty) {
          return (_currentBlocState
                  as Success<Failure<ExceptionMessage>, CharacterList>)
              .copyWith(hasReachedMax: true);
        }

        // merge newly fetched character-list with existing success-state character-list (copied to a new object so no mutation)
        final _previousCharacterList = (_currentBlocState
                as Success<Failure<ExceptionMessage>, CharacterList>)
            .data;

        final _newCharacterList = characterList.copyWith(
          characters: [
            ..._previousCharacterList.characters,
            ...characterList.characters
          ],
        );

        return (_currentBlocState
                as Success<Failure<ExceptionMessage>, CharacterList>)
            .copyWith(hasReachedMax: false, data: _newCharacterList);
      },
    );

    emit(_state);
  }
}
