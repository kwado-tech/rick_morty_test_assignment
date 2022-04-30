import 'package:casino_test/src/core/constants.dart';
import 'package:casino_test/src/core/util/width_constraints.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/presentation/widgets/shared/cache_network_image.dart';
import 'package:casino_test/src/presentation/widgets/shared/custom_chip.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget _buildTags() {
    return Row(
      children: [
        CustomChip(
          color: ColorTheme.kIndicatorColor,
          label: 'Alive',
        ),
        SizedBox(width: Sizing.kItemSpacerUnit),
        CustomChip(
          color: ColorTheme.kAccentColor,
          label: 'Human',
        ),
        SizedBox(width: Sizing.kItemSpacerUnit),
        CustomChip(
          color: ColorTheme.kPrimaryColor,
          label: 'Male',
        ),
      ],
    );
  }

  Widget _buildInfoBox() {
    final _borderRadius = BorderRadius.circular(Sizing.kBorderRadius);

    return Builder(builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: WidthConstraint(context).contentPadding,
          right: WidthConstraint(context).contentPadding,
          bottom: Sizing.kItemSpacerUnit,
        ),
        child: Material(
          elevation: Sizing.kItemElevation * 2,
          borderRadius: _borderRadius,
          child: Container(
            height: Sizing.kItemSpacerUnit * 16,
            padding: EdgeInsets.all(Sizing.kItemSpacerUnit * 2),
            decoration: BoxDecoration(
              borderRadius: _borderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      character.location.name,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      timeago.format(character.created),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: ColorTheme.kSubtitleTextColor,
                          ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  character.origin.name,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: ColorTheme.kSubtitleTextColor,
                      ),
                ),
                SizedBox(height: Sizing.kItemSpacerUnit * .5),
                _buildTags(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      // pinned: true,
      backgroundColor: ColorTheme.kBackgroundColor,
      expandedHeight: Sizing.kItemSpacerUnit * 70,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Hero(
              tag: character.image,
              child: Container(
                color: ColorTheme.kGreyColor,
                height: Sizing.kItemSpacerUnit * 65,
                child: CacheNetworkImage(imageUrl: character.image),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildInfoBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEpisodeBuilder() {
    final _borderRadius = BorderRadius.circular(Sizing.kBorderRadius);

    return Wrap(
      spacing: Sizing.kItemSpacerUnit * 2,
      runSpacing: Sizing.kItemSpacerUnit * 2,
      // crossAxisAlignment: WrapCrossAlignment.center,

      children: character.episode.map((e) {
        final _parts = e.split('/');

        return Material(
          borderRadius: _borderRadius,
          elevation: Sizing.kItemElevation,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Sizing.kItemSpacerUnit * 2,
              vertical: Sizing.kItemSpacerUnit * 1.5,
            ),
            decoration: BoxDecoration(
              borderRadius: _borderRadius,
            ),
            child: Text('Episode ${_parts[_parts.length - 1]}'),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.kBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            _buildSliverAppBar(),
          ];
        },
        body: SingleChildScrollView(
          child: WidthConstraint(context).withHorizontalSymmetricalPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Sizing.kItemSpacerUnit * 2),
                Text('Episodes'),
                SizedBox(height: Sizing.kItemSpacerUnit * 2),
                _buildEpisodeBuilder(),
                SizedBox(height: Sizing.kItemSpacerUnit * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
