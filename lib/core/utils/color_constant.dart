import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color gray600 = fromHex('#7c7f86');

  static Color gray700 = fromHex('#5d5d5d');

  static Color gray601 = fromHex('#7e7777');

  static Color gray500 = fromHex('#908f8f');

  static Color gray901 = fromHex('#1f1e1e');

  static Color gray900 = fromHex('#1c1b1b');

  static Color red200 = fromHex('#de8989');

  static Color red300 = fromHex('#c17e7e');

  static Color indigoA200 = fromHex('#6c70e5');

  static Color red201 = fromHex('#d0998d');

  static Color red301 = fromHex('#ca8884');

  static Color gray101 = fromHex('#f6f3f3');

  static Color gray100 = fromHex('#f5f2f2');

  static Color cyan200 = fromHex('#86f7dc');

  static Color indigo300 = fromHex('#808fc7');

  static Color black900 = fromHex('#000000');

  static Color bluegray400 = fromHex('#888888');

  static Color black901 = fromHex('#111010');

  static Color deepOrange200 = fromHex('#e3b488');

  static Color whiteA700 = fromHex('#ffffff');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
