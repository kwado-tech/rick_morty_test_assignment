import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:casino_test/src/core/constants.dart';
import 'package:casino_test/src/core/exceptions/exceptions.dart';
import 'package:casino_test/src/core/network/network_info.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Client _client;
  final NetworkInfo _networkInfo;

  const CharactersRepositoryImpl({
    required Client client,
    required NetworkInfo networkInfo,
  })  : _client = client,
        _networkInfo = networkInfo;

  Future<Map<String, dynamic>> _fetchCharacterFromAPI(
      GetCharactersFormParams getCharactersFormParams) async {
    try {
      final _result = await _client.get(
        Uri.parse('$BASE_URL/character/?page=${getCharactersFormParams.page}'),
      );

      return json.decode(_result.body) as Map<String, dynamic>;
    } catch (e) {
      //* could be appropriately mapped to a return exception-type
      throw ExceptionType<ExceptionMessage>.serverException(
        code: ExceptionCode.UNDEFINED,
        message:
            ExceptionMessage.parse((e as HttpException).message.toString()),
      );
    }
  }

  @override
  Future<Either<Failure<ExceptionMessage>, CharacterList>> getCharacters(
      GetCharactersFormParams getCharactersFormParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final _characters =
            await _fetchCharacterFromAPI(getCharactersFormParams);

        return right(CharacterList.fromJson(_characters));
      } on ExceptionType<ExceptionMessage> catch (e) {
        return left(Failure.serverFailure(exception: e));
      }
    }

    return left(const Failure.serverFailure(
        exception: ExceptionMessages.NO_INTERNET_CONNECTION));
  }
}
