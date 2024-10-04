import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class UserPhotoWidget extends StatelessWidget {
  const UserPhotoWidget({
    required this.onPressed,
    required this.imageUrl,
    super.key,
    this.imageName,
    this.icon,
    this.perimeter,
    this.background,
    this.iconColor,
  });
  final String? imageUrl;
  final VoidCallback? onPressed;
  final String? imageName;
  final Icon? icon;
  final double? perimeter;
  final Color? background;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    if (onPressed == null) {
      return CircleAvatar(
        // decoration: KWidgetTheme.boxDecorationCircular
        //     .copyWith(color: AppColors.materialThemeKeyColorsSecondary),
        // padding: EdgeInsets.all(_padding),
        radius: (perimeter ?? KSize.kUserPhoto) / 2,
        backgroundColor: background,
        child: _body,
      );
    } else {
      return IconButtonWidget(
        icon: _body,
        onPressed: onPressed,
        background: background ?? AppColors.materialThemeKeyColorsSecondary,
        padding: _padding,
      );
    }
  }

  Widget get _body => imageUrl != null
      ? ClipRRect(
          borderRadius: BorderRadius.circular(perimeter ?? KSize.kUserPhoto),
          child: NetworkImageWidget(
            imageUrl: imageUrl!,
            fit: BoxFit.contain,
            size: perimeter ?? KSize.kUserPhoto,
            highQuality: true,
            imageName: imageName,
            // skeletonizerLoading: false,
          ),
        )
      : (icon ?? KIcon.user)
          .copyWith(color: iconColor ?? AppColors.materialThemeWhite);
  double get _padding => imageUrl != null ? 0 : KPadding.kPaddingSize12;
}
