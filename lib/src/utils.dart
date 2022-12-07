

import 'dart:math';
import 'package:flutter/painting.dart';
bool useWhiteForeground(Color backgroundColor, {double bias = 0.0}) {
  int v = sqrt(pow(backgroundColor.red, 2) * 0.299 +
          pow(backgroundColor.green, 2) * 0.587 +
          pow(backgroundColor.blue, 2) * 0.114)
      .round();
  return v < 130 + bias ? true : false;
}

HSLColor hsvToHsl(HSVColor color) {
  double s = 0.0;
  double l = 0.0;
  l = (2 - color.saturation) * color.value / 2;
  if (l != 0) {
    if (l == 1) {
      s = 0.0;
    } else if (l < 0.5) {
      s = color.saturation * color.value / (l * 2);
    } else {
      s = color.saturation * color.value / (2 - l * 2);
    }
  }
  return HSLColor.fromAHSL(
    color.alpha,
    color.hue,
    s.clamp(0.0, 1.0),
    l.clamp(0.0, 1.0),
  );
}
HSVColor hslToHsv(HSLColor color) {
  double s = 0.0;
  double v = 0.0;

  v = color.lightness +
      color.saturation *
          (color.lightness < 0.5 ? color.lightness : 1 - color.lightness);
  if (v != 0) s = 2 - 2 * color.lightness / v;

  return HSVColor.fromAHSV(
    color.alpha,
    color.hue,
    s.clamp(0.0, 1.0),
    v.clamp(0.0, 1.0),
  );
}

const String kValidHexPattern = r'^#?[0-9a-fA-F]{1,8}';

const String kCompleteValidHexPattern =
    r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$';


Color? colorFromHex(String inputString, {bool enableAlpha = true}) {
  final RegExp hexValidator = RegExp(kCompleteValidHexPattern);
  if (!hexValidator.hasMatch(inputString)) return null;
  String hexToParse = inputString.replaceFirst('#', '').toUpperCase();
  if (!enableAlpha && hexToParse.length == 8) {
    hexToParse = 'FF${hexToParse.substring(2)}';
  }
  if (hexToParse.length == 3) {
    hexToParse = hexToParse.split('').expand((i) => [i * 2]).join();
  }
  if (hexToParse.length == 6) hexToParse = 'FF$hexToParse';
  final intColorValue = int.tryParse(hexToParse, radix: 16);
  if (intColorValue == null) return null;
  final color = Color(intColorValue);
  return enableAlpha ? color : color.withAlpha(255);
}


String colorToHex(
  Color color, {
  bool includeHashSign = false,
  bool enableAlpha = true,
  bool toUpperCase = true,
}) {
  final String hex = (includeHashSign ? '#' : '') +
      (enableAlpha ? _padRadix(color.alpha) : '') +
      _padRadix(color.red) +
      _padRadix(color.green) +
      _padRadix(color.blue);
  return toUpperCase ? hex.toUpperCase() : hex;
}

String _padRadix(int value) => value.toRadixString(16).padLeft(2, '0');
