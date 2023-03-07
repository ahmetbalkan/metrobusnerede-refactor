import 'package:flutter/material.dart';

extension TextStyleExtention on BuildContext {
  TextStyle fontStyleLed(Color color, double size) =>
      TextStyle(color: color, fontFamily: "Led", fontSize: size, height: 1.5);
}

extension ColorExtention on BuildContext {
  Color get backgroundColor => const Color(0xFFA31018);
}

extension BoolExtention on bool {
  bool invertBool() {
    return !this;
  }
}
