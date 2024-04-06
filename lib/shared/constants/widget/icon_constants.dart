// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class _KIcon extends Icon {
  const _KIcon(super.icon);

  Icon setIconKey(Key key) {
    return Icon(
      icon,
      key: key,
    );
  }
}

abstract class KIcon {
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
  static const _KIcon linkedIn = _KIcon(FontAwesomeIcons.linkedinIn);
  static const _KIcon instagram = _KIcon(FontAwesomeIcons.instagram);
  static const _KIcon facebook = _KIcon(FontAwesomeIcons.facebookF);
  static const _KIcon arrowUpRight = _KIcon(Icons.arrow_outward);
  static const _KIcon like = _KIcon(Icons.thumb_up_outlined);
  static const _KIcon activeLike = _KIcon(Icons.thumb_up);
  static const _KIcon smile = _KIcon(Icons.sentiment_very_satisfied);
  static const _KIcon dislike = _KIcon(Icons.thumb_down_outlined);
  static const _KIcon activeDislike = _KIcon(Icons.thumb_down);
  static const _KIcon share = _KIcon(Icons.file_upload_outlined);
  static const _KIcon error = _KIcon(Icons.error);
  static const _KIcon safe = _KIcon(Icons.bookmark_border_sharp);
  static const _KIcon check = _KIcon(Icons.check);
  static const _KIcon google = _KIcon(FontAwesomeIcons.google);
  static const _KIcon volum = _KIcon(FontAwesomeIcons.volumeHigh);
  static const _KIcon eye = _KIcon(Icons.visibility_outlined);
  static const _KIcon eyeOff = _KIcon(Icons.visibility_off_outlined);
  static const _KIcon refresh = _KIcon(FontAwesomeIcons.rotate);
  static const _KIcon apple = _KIcon(FontAwesomeIcons.apple);
}
