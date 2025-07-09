import 'package:flutter/material.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HeartSliderWidget extends StatefulWidget {
  const HeartSliderWidget({
    super.key,
    this.value = 5,
    required this.onChanged,
    required this.enable,
  });

  final double min = 1.0;
  final double max = 9.0;
  final double? value;
  final bool enable;
  final Function(dynamic) onChanged;

  @override
  State<HeartSliderWidget> createState() => _HeartSliderWidgetState();
}

class _HeartSliderWidgetState extends State<HeartSliderWidget> {
  double onValue = 5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Future.delayed(const Duration(milliseconds: 200));
        setState(() {
          if ((widget.value ?? 1.0) > 0 && (widget.value ?? 1.0) < 10) {
            onValue = widget.value ?? 5.0;
          } else {
            onValue = 5;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SfSliderTheme(
        data: const SfSliderThemeData(
          overlayRadius: 0,
          activeTrackHeight: 1,
          inactiveTrackHeight: 1,
          tickSize: Size(1, 35),
          tickOffset: Offset(0, -17.5),
          activeTickColor: Colors.black,
          inactiveTickColor: Colors.black,
        ),
        child: SfSlider(
          min: widget.min,
          max: widget.max,
          value: onValue,
          stepSize: 1,
          thumbShape: CustomThumbShape(
            imageProvider: const AssetImage(
              Assets.iconsIcHeartSlider,
            ),
            thumbRadius: 10,
            bottomPadding: 20,
          ),
          onChanged: (value) {
            if (widget.enable) {
              setState(() {
                onValue = value;
              });
              widget.onChanged(value);
            }
          },
          showTicks: true,
          showLabels: false,
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          interval: 1,
          minorTicksPerInterval: 0,
          showDividers: true,
        ),
      ),
    );
  }
}

class CustomThumbShape extends SfThumbShape {
  final double thumbRadius;
  final ImageProvider imageProvider;
  final double bottomPadding;
  ImageStream? _imageStream;
  ImageInfo? _imageInfo;

  CustomThumbShape({
    this.thumbRadius = 16.0,
    required this.imageProvider,
    this.bottomPadding = 20.0,
  });

  void _handleImageLoaded(ImageInfo imageInfo, bool synchronousCall) {
    _imageInfo = imageInfo;
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required RenderBox? child,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Paint? paint,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required SfThumb? thumb}) {
    final canvas = context.canvas;
    final adjustedCenter = Offset(center.dx, center.dy - bottomPadding);

    if (_imageStream == null) {
      _imageStream = imageProvider.resolve(ImageConfiguration(
        size: Size(thumbRadius * 2, thumbRadius * 2),
      ));
      _imageStream!.addListener(
        ImageStreamListener(_handleImageLoaded),
      );
    }

    if (_imageInfo != null) {
      paintImage(
        canvas: canvas,
        rect: Rect.fromCenter(
          center: adjustedCenter,
          width: thumbRadius * 2,
          height: thumbRadius * 2,
        ),
        image: _imageInfo!.image,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        colorFilter: null,
        // Remove any color filtering
        alignment: Alignment.center,
      );
    } else {
      final Paint circlePaint = Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.fill;
      canvas.drawCircle(adjustedCenter, thumbRadius, circlePaint);
    }
  }

  void dispose() {
    _imageStream?.removeListener(ImageStreamListener(_handleImageLoaded));
  }
}
