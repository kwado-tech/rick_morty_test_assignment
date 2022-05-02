import 'package:casino_test/src/core/constants.dart';
import 'package:casino_test/src/core/exceptions/exceptions.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/bloc_state.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/ui/characted_details_screen.dart';
import 'package:casino_test/src/presentation/widgets/item_card.dart';
import 'package:casino_test/src/presentation/widgets/shared/response_indicators/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final _scrollController = ScrollController();
  final _scrollThreshold = Sizing.kScrollThreshold;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollView);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScrollView)
      ..dispose();
    super.dispose();
  }

  void _onScrollView() {
    if (!_scrollController.hasClients) return;
    final _maxScroll = _scrollController.position.maxScrollExtent;
    final _currentScroll = _scrollController.position.pixels;
    if (_maxScroll - _currentScroll <= _scrollThreshold) {
      final _nextPage = context.read<MainPageBloc>().state.maybeMap(
            orElse: () => null,
            success: (state) => state.data.info.nextPage,
          );

      if (_nextPage != null) {
        final _getCharactersFormParams =
            GetCharactersFormParams(page: _nextPage);

        context.read<MainPageBloc>().add(
              MainBlocEvent.getCharacters(
                  getCharactersFormParams: _getCharactersFormParams),
            );
      }
    }
  }

  Widget _buildLoadingIndicator({bool isSmallSizedLoadingIndicator = false}) {
    return Center(
      child: LoadingIndicator(
        type: LoadingIndicatorType.circularProgressIndicator(
            isSmallSize: isSmallSizedLoadingIndicator),
      ),
    );
  }

  Widget _buildCharacterListBuilder(
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
      controller: _scrollController,
      itemCount:
          state.hasReachedMax ? _characters.length : _characters.length + 1,
      padding: EdgeInsets.symmetric(
        vertical: Sizing.kItemSpacerUnit * 2,
      ),
      separatorBuilder: (_, __) {
        return SizedBox(height: Sizing.kItemSpacerUnit * 3);
      },
      itemBuilder: (context, index) {
        if (index >= _characters.length) {
          return SizedBox(
            height: Sizing.kItemSpacerUnit * 5,
            child: _buildLoadingIndicator(isSmallSizedLoadingIndicator: true),
          );
        }

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
            orElse: () => _buildLoadingIndicator(),
            success: (state) => _buildCharacterListBuilder(state),
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
