import 'package:casino_test/src/core/constants.dart';
import 'package:casino_test/src/core/exceptions/exceptions.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/presentation/bloc/bloc_state.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/ui/characted_details_screen.dart';
import 'package:casino_test/src/presentation/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CharactersScreen extends StatelessWidget {
  Widget _loadingWidget(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _successfulWidget(BuildContext context,
      Success<Failure<ExceptionMessage>, CharacterList> state) {
    final _characters = state.data.characters;

    if (_characters.isEmpty) {
      // TODO: implement properly
      return Center(
        child: Text('No character to display at the moment!'),
      );
    }

    return ListView.separated(
      cacheExtent: double.maxFinite,
      itemCount: _characters.length,
      padding: EdgeInsets.symmetric(
        vertical: Sizing.kItemSpacerUnit * 2,
      ),
      separatorBuilder: (_, __) {
        return SizedBox(height: Sizing.kItemSpacerUnit * 3);
      },
      itemBuilder: (context, index) {
        final _character = _characters[index];

        return ItemCard(
          onTap: () {
            HapticFeedback.vibrate();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CharacterDetailsScreen(
                  character: _character,
                ),
              ),
            );
          },
          character: _character,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.kBackgroundColor,
      appBar: AppBar(
        title: Text('Rick & Morty'),
      ),
      body: BlocConsumer<MainPageBloc,
          BlocState<Failure<ExceptionMessage>, CharacterList>>(
        listener: (context, state) {
          // TODO:
        },
        builder: (blocContext, state) {
          return state.maybeMap(
            orElse: () => _loadingWidget(context),
            success: (state) => _successfulWidget(context, state),
            error: (state) {
              // TODO: implement properly
              return Center(child: const Text("error"));
            },
          );
        },
      ),
    );
  }
}
