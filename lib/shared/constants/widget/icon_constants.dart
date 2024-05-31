import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

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
  static const Icon arrowLeft = Icon(Symbols.arrow_left);
  static const Icon arrowRight = Icon(Symbols.arrow_right);
  // static const Icon mic = Icon(Icons.mic_none_outlined);
  static const Icon person = Icon(Symbols.person_outline);
  static const Icon search = Icon(Symbols.search);
  static const Icon plus = Icon(Symbols.add);
  static const Icon minus = Icon(Symbols.remove);
  static const Icon filter = Icon(Symbols.filter_alt);
  static const Icon edit = Icon(Symbols.edit);
  static const Icon button = Icon(Symbols.smart_button);
  static const Icon trailing = Icon(Symbols.arrow_drop_down);
  static const Icon trailingUp = Icon(Symbols.arrow_drop_up);
  static const Icon arrowUpRight = Icon(Symbols.arrow_outward);
  static const Icon like = Icon(Symbols.thumb_up);
  static const Icon activeLike = Icon(
    Symbols.thumb_up,
    fill: 1,
  );
  static const Icon smile = Icon(Symbols.sentiment_very_satisfied);
  static const Icon activeSmile = Icon(
    Symbols.sentiment_very_satisfied,
    fill: 1,
  );
  static const Icon dislike = Icon(Symbols.thumb_down);
  static const Icon activeDislike = Icon(
    Symbols.thumb_down,
    fill: 1,
  );
  static const Icon share = Icon(Symbols.file_upload);
  static const Icon error = Icon(Symbols.error);
  static const Icon safe = Icon(Symbols.bookmark_border_sharp);
  static const Icon saved = Icon(Symbols.bookmark_added_sharp);
  static const Icon check = Icon(
    Symbols.check,
  );
  static const Icon volum = Icon(Symbols.volume_up);
  static const Icon eye = Icon(Symbols.remove_red_eye);
  static const Icon eyeOff = Icon(Symbols.remove_red_eye_sharp);
  static const Icon refresh = Icon(Symbols.refresh);
  static const Icon message = Icon(Symbols.chat_bubble);
  static const Icon star = Icon(Symbols.star);
  static const Icon attachFile = Icon(Symbols.attach_file);
  static const Icon chevronLeft = Icon(Symbols.chevron_left);
  static const Icon addImage = Icon(Symbols.add_photo_alternate_sharp);
  static const Icon trash = Icon(Symbols.delete);
  static const Icon hello = Icon(Symbols.nest_hello_doorbell);
  static const Icon globe = Icon(Symbols.language);
  static const Icon tag = Icon(Symbols.local_offer);
  static const Icon messageSquare = Icon(Symbols.chat_bubble);
  static const Icon briefcase = Icon(Symbols.trip);
  static const Icon fileText = Icon(Symbols.text_snippet);
  static const Icon meil = Icon(Symbols.mail);
}
