import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:revalesuva/utils/app_colors.dart';

class CustomImageViewer extends StatelessWidget {
  const CustomImageViewer({super.key, this.errorImage, this.imageUrl, this.imagePath});

  final Widget? errorImage;
  final String? imageUrl;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        filterQuality: FilterQuality.low,
        cacheKey: imageUrl,
        useOldImageOnUrlChange: true,
        placeholder: (context, url) =>
            errorImage ??
            const ColoredBox(
              color: AppColors.iconSecondary,
            ),
        errorWidget: (context, url, error) =>
            errorImage ??
            const ColoredBox(
              color: AppColors.iconSecondary,
            ),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      );
    } else if (imagePath?.isNotEmpty ?? false) {
      return Image.file(
        File(imagePath!),
        fit: BoxFit.cover,
        width: 90,
      );
    } else {
      return errorImage ??
          const ColoredBox(
            color: AppColors.iconSecondary,
          );
    }
  }
}
