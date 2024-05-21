// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class _KIcon extends Icon {
  const _KIcon(super.icon);

  Icon setIconKey(Key key, {Color? changeColor}) {
    return Icon(
      icon,
      key: key,
      size: size,
      color: changeColor ?? color,
    );
  }

  Icon setIconSize(double iconSize) {
    return Icon(
      icon,
      key: key,
      size: iconSize,
      color: color,
    );
  }
}

abstract class KIcon {
  static const Image instagram =
      Image(image: AssetImage('assets/icons/instagram.png'));
  static const Image linkedIn =
      Image(image: AssetImage('assets/icons/linkedin.png'));
  static const Image facebook = Image(
    image: AssetImage('assets/icons/social_icons_f.png'),
  );
  static const Image apple =
      Image(image: AssetImage('assets/icons/social_icons.png'));
  static const Image google =
      Image(image: AssetImage('assets/icons/social_icons_g.png'));
  static const _KIcon arrowLeft = _KIcon(Icons.arrow_left);
  static const _KIcon arrowRight = _KIcon(Icons.arrow_right);
  static const _KIcon mic = _KIcon(Icons.mic_none_outlined);
  static const _KIcon person = _KIcon(Icons.person_outline);
  static const _KIcon search = _KIcon(Icons.search);
  static const _KIcon plus = _KIcon(Icons.add);
  static const _KIcon minus = _KIcon(Icons.remove);
  static const _KIcon filter = _KIcon(Icons.filter_alt_outlined);
  static const _KIcon edit = _KIcon(Icons.mode_edit_outline_outlined);
  static const _KIcon button = _KIcon(Icons.smart_button);
  static const _KIcon trailing = _KIcon(Icons.arrow_drop_down);
  static const _KIcon trailingUp = _KIcon(Icons.arrow_drop_up);
  static const _KIcon arrowUpRight = _KIcon(Icons.arrow_outward);
  static const _KIcon like = _KIcon(Icons.thumb_up_outlined);
  static const _KIcon activeLike = _KIcon(Icons.thumb_up);
  static const _KIcon smile = _KIcon(Icons.sentiment_dissatisfied);
  static const _KIcon happySmile = _KIcon(Icons.sentiment_very_satisfied);
  static const _KIcon dislike = _KIcon(Icons.thumb_down_outlined);
  static const _KIcon activeDislike = _KIcon(Icons.thumb_down);
  static const _KIcon share = _KIcon(Icons.file_upload_outlined);
  static const _KIcon error = _KIcon(Icons.error);
  static const _KIcon safe = _KIcon(Icons.bookmark_border_sharp);
  static const _KIcon check = _KIcon(Icons.check);
  static const _KIcon volum = _KIcon(Icons.volume_up);
  static const _KIcon eye = _KIcon(Icons.visibility_outlined);
  static const _KIcon eyeOff = _KIcon(Icons.visibility_off_outlined);
  static const _KIcon refresh = _KIcon(Icons.refresh);
  static const _KIcon message = _KIcon(Icons.message);
  static const _KIcon star = _KIcon(Icons.star);
  static const _KIcon attachFile = _KIcon(Icons.attach_file);
  static const _KIcon chevronLeft = _KIcon(Icons.chevron_left);
  static const _KIcon addImage = _KIcon(Icons.add_photo_alternate_sharp);
  static const _KIcon trash = _KIcon(Icons.restore_from_trash_rounded);
}
