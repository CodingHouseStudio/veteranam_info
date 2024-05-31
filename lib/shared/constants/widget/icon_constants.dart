// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class _KIcon extends Icon {
  // ignore: unused_element
  const _KIcon(super.icon, {super.weight = 200, super.fill});
}

extension IconExtension on Icon {
  Icon copyWith({
    Key? key,
    IconData? icon,
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
    bool? applyTextScaling,
  }) {
    return Icon(
      icon ?? this.icon,
      key: key ?? this.key,
      size: size ?? this.size,
      fill: fill ?? this.fill,
      weight: weight ?? this.weight,
      grade: grade ?? this.grade,
      opticalSize: opticalSize ?? this.opticalSize,
      color: color ?? this.color,
      shadows: shadows ?? this.shadows,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      textDirection: textDirection ?? this.textDirection,
      applyTextScaling: applyTextScaling ?? this.applyTextScaling,
    );
  }
}

abstract class KIcon {
  static const _KIcon arrowLeft = _KIcon(Symbols.arrow_left);
  static const _KIcon arrowRight = _KIcon(Symbols.arrow_right);
  // static const Icon mic = Icon(Icons.mic_none_outlined);
  static const _KIcon person = _KIcon(Symbols.person_outline);
  static const _KIcon search = _KIcon(Symbols.search);
  static const _KIcon plus = _KIcon(Symbols.add);
  static const _KIcon minus = _KIcon(Symbols.remove);
  static const _KIcon filter = _KIcon(Symbols.filter_alt);
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
  static const _KIcon check = _KIcon(
    Symbols.check,
  );
  static const _KIcon volum = _KIcon(Symbols.volume_up);
  static const _KIcon eye = _KIcon(Symbols.remove_red_eye);
  static const _KIcon eyeOff = _KIcon(Symbols.remove_red_eye_sharp);
  static const _KIcon refresh = _KIcon(Symbols.refresh);
  static const _KIcon message = _KIcon(Symbols.chat_bubble);
  static const _KIcon star = _KIcon(Symbols.star);
  static const _KIcon attachFile = _KIcon(Symbols.attach_file);
  static const _KIcon chevronLeft = _KIcon(Symbols.chevron_left);
  static const _KIcon addImage = _KIcon(Symbols.add_photo_alternate_sharp);
  static const _KIcon trash = _KIcon(Symbols.delete);
  static const _KIcon hello = _KIcon(Symbols.nest_hello_doorbell);
  static const _KIcon globe = _KIcon(Symbols.language);
  static const _KIcon tag = _KIcon(Symbols.local_offer);
  static const _KIcon messageSquare = _KIcon(Symbols.chat_bubble);
  static const _KIcon briefcase = _KIcon(Symbols.trip);
  static const _KIcon fileText = _KIcon(Symbols.text_snippet);
  static const _KIcon meil = _KIcon(Symbols.mail);
}
