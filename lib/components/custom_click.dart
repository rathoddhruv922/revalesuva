import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomClick extends StatelessWidget {
  const CustomClick({super.key, required this.child, required this.onTap, this.splashColor});

  final Function()? onTap;
  final Widget child;
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      splashColor: splashColor,
      onTap:onTap,
      child: child,
    );
  }
}
