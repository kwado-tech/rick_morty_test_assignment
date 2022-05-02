import 'dart:convert';
import 'dart:io';

import 'package:casino_test/src/core/constants.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:http/http.dart';

import '../../../core/exceptions/exceptions.dart';

abstract class CharacterRemoteDataSource {
  Future<CharacterList> getCharacters(
      {required GetCharactersFormParams getCharactersFormParams});
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Client _client;

  const CharacterRemoteDataSourceImpl({required Client client})
      : _client = client;

  @override
  Future<CharacterList> getCharacters(
      {required GetCharactersFormParams getCharactersFormParams}) async {
    try {
      final _result = await _client.get(
        Uri.parse('$BASE_URL/character/?page=${getCharactersFormParams.page}'),
      );

      final _jsonMap = json.decode(_result.body) as Map<String, dynamic>;
      return CharacterList.fromJson(_jsonMap);
    } catch (e) {
      //* could be appropriately mapped to a return exception-type
      throw ExceptionType<ExceptionMessage>.serverException(
        code: ExceptionCode.UNDEFINED,
        message:
            ExceptionMessage.parse((e as HttpException).message.toString()),
      );
    }
  }
}
