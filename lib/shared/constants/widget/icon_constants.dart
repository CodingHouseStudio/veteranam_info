// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_symbols_icons/symbols.dart';

class _KIcon extends Icon {
  const _KIcon(super.icon, {super.fill});

  Icon setIconKey(Key key, {Color? changeColor}) {
    return Icon(
      icon,
      key: key,
      size: size,
      color: changeColor ?? color,
      fill: fill,
    );
  }

  Icon setIconSize(double iconSize) {
    return Icon(
      icon,
      key: key,
      size: iconSize,
      color: color,
      fill: fill,
    );
  }
}

abstract class KIcon {
  static final SvgPicture instagram =
      SvgPicture.asset('assets/icons/instagram.svg');
  static final SvgPicture linkedIn =
      SvgPicture.asset('assets/icons/linkedin.svg');
  static final SvgPicture facebook =
      SvgPicture.asset('assets/icons/social_icons_f.svg');
  static final SvgPicture apple =
      SvgPicture.asset('assets/icons/social_icons.svg');
  static final SvgPicture google =
      SvgPicture.asset('assets/icons/social_icons_g.svg');
  static const _KIcon arrowLeft = _KIcon(Symbols.arrow_left);
  static const _KIcon arrowRight = _KIcon(Symbols.arrow_right);
  // static const _KIcon mic = _KIcon(Icons.mic_none_outlined);
  static const _KIcon person = _KIcon(Symbols.person_outline);
  static const _KIcon search = _KIcon(Symbols.search);
  static const _KIcon plus = _KIcon(Symbols.add);
  static const _KIcon minus = _KIcon(Symbols.remove);
  static const _KIcon filter = _KIcon(Symbols.filter_list);
  static const _KIcon edit = _KIcon(Symbols.edit);
  static const _KIcon button = _KIcon(Symbols.smart_button);
  static const _KIcon trailing = _KIcon(Symbols.arrow_drop_down);
  static const _KIcon trailingUp = _KIcon(Symbols.arrow_drop_up);
  static const _KIcon arrowUpRight = _KIcon(Symbols.arrow_outward);
  static const _KIcon like = _KIcon(Symbols.thumb_up);
  static const _KIcon activeLike = _KIcon(
    Symbols.thumb_up,
    fill: 1,
  );
  static const _KIcon smile = _KIcon(Symbols.sentiment_very_satisfied);
  static const _KIcon activeSmile = _KIcon(
    Symbols.sentiment_very_satisfied,
    fill: 1,
  );
  static const _KIcon dislike = _KIcon(Symbols.thumb_down);
  static const _KIcon activeDislike = _KIcon(
    Symbols.thumb_down,
    fill: 1,
  );
  static const _KIcon share = _KIcon(Symbols.file_upload);
  static const _KIcon error = _KIcon(Symbols.error);
  static const _KIcon safe = _KIcon(Symbols.bookmark_border_sharp);
  static const _KIcon saved = _KIcon(Symbols.bookmark_added_sharp);
  static const _KIcon check = _KIcon(Symbols.check);
  static const _KIcon volum = _KIcon(Symbols.volume_up);
  static const _KIcon eye = _KIcon(Symbols.remove_red_eye);
  static const _KIcon eyeOff = _KIcon(Symbols.remove_red_eye_sharp);
  static const _KIcon refresh = _KIcon(Symbols.refresh);
  static const _KIcon message = _KIcon(Symbols.message);
  static const _KIcon star = _KIcon(Symbols.star);
  static const _KIcon attachFile = _KIcon(Symbols.attach_file);
  static const _KIcon chevronLeft = _KIcon(Symbols.chevron_left);
  static const _KIcon addImage = _KIcon(Symbols.add_photo_alternate_sharp);
  static const _KIcon trash = _KIcon(Symbols.restore_from_trash_rounded);
}
