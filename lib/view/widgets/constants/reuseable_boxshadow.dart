import 'package:flutter/material.dart';

List<BoxShadow> reuseAbleShadow = [
  BoxShadow(
      color: Colors.black.withOpacity(0.025),
      blurRadius: 2,
      offset: const Offset(0, 4)),
  BoxShadow(
      color: Colors.black.withOpacity(0.025),
      blurRadius: 2,
      offset: const Offset(0, -4)),
  BoxShadow(
      color: Colors.black.withOpacity(0.025),
      blurRadius: 2,
      offset: const Offset(4, 0)),
  BoxShadow(
      color: Colors.black.withOpacity(0.025),
      blurRadius: 2,
      offset: const Offset(-4, 0))
];
