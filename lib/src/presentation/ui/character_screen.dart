import 'package:casino_test/src/core/constants.dart';
import 'package:casino_test/src/core/exceptions/exceptions.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/presentation/bloc/bloc_state.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
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

  Widget _characterWidget(BuildContext context, Character character) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Color.fromARGB(120, 204, 255, 255),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(character.name),
            ),
            Image.network(
              character.image,
              width: 50,
              height: 50,
            ),
          ],
        ),
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
        return ItemCard(
          onTap: () {
            HapticFeedback.vibrate();
          },
          character: _characters[index],
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
