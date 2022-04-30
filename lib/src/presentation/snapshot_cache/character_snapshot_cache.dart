import 'package:casino_test/src/core/exceptions/exceptions.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/presentation/bloc/bloc_state.dart';
import 'package:flutter/material.dart';

class CharacterSnapshotCache with ChangeNotifier {
  static Success<Failure<ExceptionMessage>, CharacterList>?
      _successCharacterState;

  Success<Failure<ExceptionMessage>, CharacterList>?
      get successCharacterState => _successCharacterState;
  set successCharacterState(
      Success<Failure<ExceptionMessage>, CharacterList>? state) {
    _successCharacterState = state;
    notifyListeners();
  }

  notifyAllListeners() {
    notifyListeners();
  }
}
