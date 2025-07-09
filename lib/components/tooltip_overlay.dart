import 'package:flutter/material.dart';

class TooltipOverlay {
  TooltipOverlay._();

  static OverlayEntry? _overlayEntry;

  static void showTooltip(BuildContext context, GlobalKey key, String message) {
    if (_overlayEntry != null) return;
    RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.black,
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
