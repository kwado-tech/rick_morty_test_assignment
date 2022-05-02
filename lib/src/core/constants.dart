import 'package:casino_test/src/core/util/color_util.dart';
import 'package:flutter/material.dart';

const BASE_URL = 'https://rickandmortyapi.com/api';
const INITIAL_PAGE = 1;

class Endpoints {
  static const kCharacters = 'character';
}

class Sizing {
  static const kItemElevation = 1.0;
  static const kMaxItemHeight = 150.0;
  static const kMaxSubItemPadding = 30.0;
  static const kBorderRadius = 4.0;
  static const kItemBorderRadius = 10.0;
  static const kItemSpacerUnit = 8.0;
  static const kDebounceDuration = 500;
  static const kScrollThreshold = 200;
  static const kProgressIndicatorSizeSmall = 20.0;
  static const kProgressIndicatorStrokeWidth = 2.0;
}

class CustomTypography {
  static const kHeadline5 = 20.0;
}

// creating a theme would be an overkill
class ColorTheme {
  static final kPrimaryColor = Colors.blue;
  static final kIndicatorColor = Colors.green;
  static final kAccentColor = Colors.amber[800];
  static final kErrorColor = Colors.red;
  static final kGreyColor = Colors.grey;
  static final kGreyColorLight = Colors.grey.withOpacity(.40);
  static final kSubtitleTextColor = Colors.grey;
  static final kBlackColor = Colors.black;
  static final kBlackColor_54 = Colors.black54;
  static final kTransparentColor = Colors.transparent;
  static final kBackgroundColor = ColorUtil.colorFromHex('#FFf2f5fb');
}
