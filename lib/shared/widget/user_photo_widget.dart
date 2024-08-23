import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class UserPhotoWidget extends StatelessWidget {
  const UserPhotoWidget({
    required this.onPressed,
    required this.imageUrl,
    super.key,
  });
  final String? imageUrl;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (onPressed == null) {
      return CircleAvatar(
        // decoration: KWidgetTheme.boxDecorationCircular
        //     .copyWith(color: AppColors.materialThemeKeyColorsSecondary),
        // padding: EdgeInsets.all(_padding),
        radius: KSize.kUserPhoto / 2,
        child: _body,
      );
    } else {
      return IconButtonWidget(
        icon: _body,
        onPressed: onPressed,
        background: AppColors.materialThemeKeyColorsSecondary,
        padding: _padding,
      );
    }
  }

  Widget get _body => imageUrl != null
      ? ClipRRect(
          borderRadius: BorderRadius.circular(KSize.kUserPhoto),
          child: NetworkImageWidget(
            imageUrl: imageUrl!,
            fit: BoxFit.contain,
            size: KSize.kUserPhoto,
            highQuality: true,
            // skeletonizerLoading: false,
          ),
        )
      : KIcon.user.copyWith(color: AppColors.materialThemeWhite);
  double get _padding => imageUrl != null ? 0 : KPadding.kPaddingSize12;
}
