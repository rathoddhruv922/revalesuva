import 'package:flutter/material.dart';

class CustomScroll extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return GlowingOverscrollIndicator(
      axisDirection: details.direction,
      color: Colors.transparent,
      showLeading: false,
      showTrailing: false,
      child: child,
    );
  }
}
