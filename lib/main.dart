import 'package:casino_test/src/core/constants.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/core/di/main_di_module.dart';
import 'package:casino_test/src/presentation/ui/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/presentation/bloc/main_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize DI
  MainDIModule().configure();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test app',
      debugShowCheckedModeBanner: false,
      home: BlocProvider<MainPageBloc>(
        create: (context) {
          final _params = GetCharactersFormParams(page: INITIAL_PAGE);
          return getIt<MainPageBloc>()
            ..add(
              MainBlocEvent.getCharacters(getCharactersFormParams: _params),
            );
        },
        child: CharactersScreen(),
      ),
    );
  }
}
