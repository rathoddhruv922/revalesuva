import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/fonts_constants.dart';

class TextDisplayLarge extends StatelessWidget {
  const TextDisplayLarge({
    super.key,
    required this.text,
    this.color = AppColors.textPrimary,
    this.size = 0,
    this.textAlign = TextAlign.start,
    this.weight = 0,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 1,
  });

  final double letterSpacing;

  final int? maxLine;
  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final int weight;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      style: GoogleFonts.getFont(
        fontFamily,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.displayLarge?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
            ),
      ),
    );
  }
}

class TextDisplayMedium extends StatelessWidget {
  const TextDisplayMedium({
    super.key,
    required this.text,
    this.color = AppColors.textPrimary,
    this.size = 0,
    this.textAlign = TextAlign.start,
    this.weight = 0,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 1,
  });

  final double letterSpacing;

  final int? maxLine;

  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final String fontFamily;
  final int weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      style: GoogleFonts.getFont(
        fontFamily,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.displayMedium?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
            ),
      ),
    );
  }
}

class TextDisplaySmall extends StatelessWidget {
  const TextDisplaySmall({
    super.key,
    required this.text,
    this.color = AppColors.textPrimary,
    this.size = 0,
    this.textAlign = TextAlign.start,
    this.weight = 0,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 1,
  });

  final double letterSpacing;

  final int? maxLine;

  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final String fontFamily;
  final int weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
      style: GoogleFonts.getFont(
        fontFamily,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.displaySmall?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
            ),
      ),
    );
  }
}

class TextHeadlineLarge extends StatelessWidget {
  const TextHeadlineLarge({
    super.key,
    required this.text,
    this.color = AppColors.textPrimary,
    this.size = 0,
    this.textAlign = TextAlign.start,
    this.weight = 0,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 1,
  });

  final double letterSpacing;

  final int? maxLine;

  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final int weight;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
      style: GoogleFonts.getFont(
        fontFamily,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.headlineLarge?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
            ),
      ),
    );
  }
}

class TextHeadlineMedium extends StatelessWidget {
  const TextHeadlineMedium({
    super.key,
    required this.text,
    this.color = AppColors.textPrimary,
    this.size = 0,
    this.textAlign = TextAlign.start,
    this.weight = 0,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 0,
  });

  final double letterSpacing;

  final int? maxLine;

  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final String fontFamily;
  final int weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      style: GoogleFonts.getFont(
        fontFamily,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.headlineMedium?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
            ),
      ),
    );
  }
}

class TextHeadlineSmall extends StatelessWidget {
  const TextHeadlineSmall({
    super.key,
    required this.text,
    this.color = AppColors.textPrimary,
    this.size = 0,
    this.textAlign = TextAlign.start,
    this.weight = 0,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 0,
  });

  final double letterSpacing;

  final int? maxLine;

  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final String fontFamily;
  final int weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
      style: GoogleFonts.getFont(
        fontFamily,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.headlineSmall?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
            ),
      ),
    );
  }
}

class TextTitleSmall extends StatelessWidget {
  const TextTitleSmall({
    super.key,
    required this.text,
    this.color = AppColors.textPrimary,
    this.size = 0,
    this.textAlign = TextAlign.start,
    this.weight = 0,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 0,
  });

  final double letterSpacing;

  final int? maxLine;
  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final int weight;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
      style: GoogleFonts.getFont(
        fontFamily,
        height: 1,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.titleSmall?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
            ),
      ),
    );
  }
}

class TextTitleMedium extends StatelessWidget {
  const TextTitleMedium({
    super.key,
    required this.text,
    this.color = AppColors.textPrimary,
    this.size = 0,
    this.textAlign = TextAlign.start,
    this.weight = 0,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 0,
  });

  final double letterSpacing;
  final int? maxLine;
  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final int weight;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
      style: GoogleFonts.getFont(
        fontFamily,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.titleMedium?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
            ),
      ),
    );
  }
}

class TextTitleLarge extends StatelessWidget {
  const TextTitleLarge({
    super.key,
    required this.text,
    this.color = AppColors.textPrimary,
    this.size = 0,
    this.textAlign = TextAlign.start,
    this.weight = 0,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 0,
  });

  final double letterSpacing;

  final int? maxLine;
  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final int weight;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      style: GoogleFonts.getFont(
        fontFamily,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.titleLarge?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
            ),
      ),
    );
  }
}

class TextLabelSmall extends StatelessWidget {
  const TextLabelSmall({
    super.key,
    required this.text,
    this.color = AppColors.textSecondary,
    this.size = 0,
    this.textAlign = TextAlign.start,
    this.weight = 0,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 0,
  });

  final double letterSpacing;

  final int? maxLine;
  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final int weight;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
      style: GoogleFonts.getFont(
        fontFamily,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.labelSmall?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
            ),
      ),
    );
  }
}

class TextLabelMedium extends StatelessWidget {
  const TextLabelMedium({
    super.key,
    required this.text,
    this.color = AppColors.textSecondary,
    this.size = 0,
    this.textAlign = TextAlign.start,
    this.weight = 0,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 0,
  });

  final double letterSpacing;

  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final int weight;
  final String fontFamily;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      style: GoogleFonts.getFont(
        fontFamily,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.labelMedium?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
            ),
      ),
    );
  }
}

class TextLabelLarge extends StatelessWidget {
  const TextLabelLarge({
    super.key,
    required this.text,
    this.color = AppColors.textSecondary,
    this.size = 0,
    this.textAlign = TextAlign.start,
    this.weight = 0,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 0,
  });

  final double letterSpacing;

  final int? maxLine;
  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final int weight;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
      style: GoogleFonts.getFont(
        fontFamily,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.labelLarge?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
            ),
      ),
    );
  }
}

class TextBodyLarge extends StatelessWidget {
  const TextBodyLarge({
    super.key,
    required this.text,
    this.color = AppColors.textTertiary,
    this.size = 0,
    this.weight = 0,
    this.textAlign = TextAlign.start,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 0,
  });

  final double letterSpacing;

  final int? maxLine;
  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final int weight;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
      style: GoogleFonts.getFont(
        fontFamily,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.bodyLarge?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
            ),
      ),
    );
  }
}

class TextBodyMedium extends StatelessWidget {
  const TextBodyMedium({
    super.key,
    required this.text,
    this.color = AppColors.textTertiary,
    this.size = 0,
    this.textAlign = TextAlign.start,
    this.weight = 0,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 0,
  });

  final double letterSpacing;

  final int? maxLine;
  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final int weight;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
      style: GoogleFonts.getFont(
        fontFamily,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.bodyMedium?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
            ),
      ),
    );
  }
}

class TextBodySmall extends StatelessWidget {
  const TextBodySmall({
    super.key,
    required this.text,
    this.color = AppColors.textTertiary,
    this.size = 0,
    this.textAlign = TextAlign.start,
    this.weight = 0,
    this.fontFamily = FontsConstants.roboto,
    this.maxLine,
    this.letterSpacing = 0,
    this.decoration,
    this.decorationStyle,
    this.decorationThicknessDelta = 0.0
  });

  final double letterSpacing;

  final int? maxLine;
  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;
  final int weight;
  final String fontFamily;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final double decorationThicknessDelta;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
      style: GoogleFonts.getFont(
        fontFamily,
        letterSpacing: letterSpacing,
        textStyle: Theme.of(context).textTheme.bodySmall?.apply(
              color: color,
              fontSizeDelta: size,
              fontWeightDelta: weight,
              decoration: decoration,
              decorationStyle: decorationStyle,
              decorationThicknessDelta: decorationThicknessDelta,
            ),
      ),
    );
  }
}
