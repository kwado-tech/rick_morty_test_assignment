import 'package:casino_test/src/core/constants.dart';
import 'package:casino_test/src/core/util/width_constraints.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ItemCard extends StatelessWidget {
  final VoidCallback onTap;
  final Character character;

  const ItemCard({Key? key, required this.onTap, required this.character})
      : super(key: key);

  Widget _buildLeftSection() {
    const _borderRadius = BorderRadius.only(
      topRight: Radius.circular(Sizing.kItemBorderRadius),
      bottomRight: Radius.circular(Sizing.kItemBorderRadius),
    );

    return LayoutBuilder(builder: (context, constraints) {
      return Material(
        borderRadius: _borderRadius,
        elevation: Sizing.kItemElevation * 2,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth * .40,
            decoration: BoxDecoration(
              borderRadius: _borderRadius,
              image: DecorationImage(
                image: NetworkImage(
                  character.image,
                ),
                fit: BoxFit.cover,
              ),
            ),
            // child: Image.network(
            //   character.image,
            //   fit: BoxFit.cover,
            // ),
          ),
        ),
      );
    });
  }

  Widget _buildRightSection() {
    const _borderRadius = BorderRadius.only(
      topRight: Radius.circular(Sizing.kBorderRadius),
      bottomRight: Radius.circular(Sizing.kBorderRadius),
    );

    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: Sizing.kMaxSubItemPadding * .5,
        ),
        child: Material(
          borderRadius: _borderRadius,
          elevation: Sizing.kItemElevation,
          child: InkWell(
            onTap: onTap,
            child: Container(
              alignment: Alignment(0.0, 0.0),
              margin: EdgeInsets.only(left: constraints.maxWidth * .38),
              padding: EdgeInsets.symmetric(
                vertical: Sizing.kItemSpacerUnit * 2,
                horizontal: Sizing.kItemSpacerUnit * 3,
              ),
              decoration: BoxDecoration(
                borderRadius: _borderRadius,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    character.location.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    character.origin.name,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: ColorTheme.kSubtitleTextColor,
                        ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        timeago.format(character.created),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: ColorTheme.kSubtitleTextColor,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WidthConstraint(context).withHorizontalSymmetricalPadding(
      child: Container(
        height: Sizing.kMaxItemHeight,
        child: Stack(
          children: [
            _buildRightSection(),
            _buildLeftSection(),
          ],
        ),
      ),
    );
  }
}
