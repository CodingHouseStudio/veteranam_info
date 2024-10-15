import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class UserPhotoWidget extends StatelessWidget {
  const UserPhotoWidget({
    required this.onPressed,
    required this.imageUrl,
    super.key,
    this.imageName,
    this.icon,
    // this.perimeter,
    // this.background,
    // this.iconColor,
    this.imageBytes,
  });
  final String? imageUrl;
  final VoidCallback? onPressed;
  final String? imageName;
  final Icon? icon;
  // final double? perimeter;
  // final Color? background;
  // final Color? iconColor;
  final Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    if (onPressed == null) {
      return CircleAvatar(
        // decoration: KWidgetTheme.boxDecorationCircular
        //     .copyWith(color: AppColors.materialThemeKeyColorsSecondary),
        // padding: EdgeInsets.all(_padding),
        radius: KSize.kUserPhoto / 2,
        backgroundColor: AppColors.materialThemeKeyColorsPrimary,
        child: _body,
      );
    } else {
      return InkWell(
        onTap: onPressed,
        child: CircleAvatar(
          radius: KSize.kUserPhoto / 2,
          backgroundColor: AppColors.materialThemeKeyColorsPrimary,
          child: _body,
        ),
      );
    }
  }

  Widget get _body => imageUrl != null || imageBytes != null
      ? ClipRRect(
          borderRadius: BorderRadius.circular(KSize.kUserPhoto),
          child: NetworkImageWidget(
            imageUrl: imageUrl,
            imageBytes: imageBytes,
            fit: BoxFit.contain,
            size: KSize.kUserPhoto,
            highQuality: true,
            imageName: imageName,
            // skeletonizerLoading: false,
          ),
        )
      : (icon ?? KIcon.user)
          .copyWith(color: AppColors.materialThemeKeyColorsSecondary);
}
