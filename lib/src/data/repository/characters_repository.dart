import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:casino_test/src/core/exceptions/exceptions.dart';
import 'package:casino_test/src/data/models/character.dart';

abstract class CharactersRepository {
  Future<Either<Failure<ExceptionMessage>, CharacterList>> getCharacters(
    GetCharactersFormParams getCharactersFormParams,
  );
}

class GetCharactersFormParams extends Equatable {
  final int page;

  const GetCharactersFormParams({required this.page});

  @override
  List<Object> get props => [page];

  @override
  String toString() => 'GetCharactersFormParams(page: $page)';
}
