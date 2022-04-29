import 'package:flutter/material.dart';

class ColorUtil {
  static Color colorFromHex(String hexColor) {
    final _hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$_hexCode', radix: 16));
  }

  static MaterialColor toMaterialColor(String hexColor) {
    final _color = <int, Color>{
      50: const Color.fromRGBO(136, 14, 79, .1),
      100: const Color.fromRGBO(136, 14, 79, .2),
      200: const Color.fromRGBO(136, 14, 79, .3),
      300: const Color.fromRGBO(136, 14, 79, .4),
      400: const Color.fromRGBO(136, 14, 79, .5),
      500: const Color.fromRGBO(136, 14, 79, .6),
      600: const Color.fromRGBO(136, 14, 79, .7),
      700: const Color.fromRGBO(136, 14, 79, .8),
      800: const Color.fromRGBO(136, 14, 79, .9),
      900: const Color.fromRGBO(136, 14, 79, 1),
    };

    final _hexCode = hexColor.replaceAll('#', '');
    final _colorInt = int.parse('FF$_hexCode', radix: 16);

    return MaterialColor(_colorInt, _color);
  }
}
