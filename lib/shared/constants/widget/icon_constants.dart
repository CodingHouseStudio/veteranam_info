// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart'
    show Color, Icon, IconData, Key, Shadow, TextDirection;
import 'package:material_symbols_icons/symbols.dart' show Symbols;
import 'package:veteranam/shared/constants/constants_flutter.dart';

class _KIcon extends Icon {
  const _KIcon(
    super.icon, {
    // ignore: unused_element
    super.weight = 200,
    super.fill,
    // ignore: unused_element
    super.size = KSize.kIconSize,
    super.color,
    super.grade,
  });
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
  static const _KIcon arrowBack = _KIcon(Symbols.arrow_back);
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
  static const _KIcon keyboardArrowDown = _KIcon(Symbols.keyboard_arrow_down);
  static const _KIcon trailingUp = _KIcon(Symbols.keyboard_arrow_up);
  static const _KIcon arrowUpRight = _KIcon(Symbols.arrow_outward);
  static const _KIcon arrowDownRight = _KIcon(Symbols.south_east);
  static const _KIcon arrowDownLeft = _KIcon(Symbols.south_west);
  static const _KIcon like = _KIcon(Symbols.thumb_up);
  static const _KIcon activeLike = _KIcon(
    fill: 1,
    Symbols.thumb_up,
    color: AppColors.materialThemeKeyColorsPrimary,
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
  static const _KIcon error = _KIcon(
    Symbols.error,
    color: AppColors.materialThemeRefErrorError60,
  );
  static const _KIcon safe = _KIcon(Symbols.bookmark_border_sharp);
  static const _KIcon saved = _KIcon(Symbols.bookmark_added_sharp);
  static const _KIcon check = _KIcon(
    Symbols.check,
  );
  static const _KIcon checkSmall = _KIcon(
    Symbols.check,
    size: KSize.kSmallIconSize,
  );
  static const _KIcon website = _KIcon(Symbols.captive_portal);
  static const _KIcon volum = _KIcon(Symbols.volume_up);
  static const _KIcon eye = _KIcon(Symbols.remove_red_eye);
  static const _KIcon eyeOff = _KIcon(Symbols.visibility_off);
  static const _KIcon refresh = _KIcon(Symbols.cached);
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
  static const _KIcon fileText = _KIcon(Symbols.description);
  static const _KIcon meil = _KIcon(Symbols.mail);
  static const _KIcon close = _KIcon(Symbols.close);
  static const _KIcon tune = _KIcon(Symbols.tune);
  static const _KIcon brightnessAlert = _KIcon(
    Symbols.brightness_alert,
    color: AppColors.materialThemeRefErrorError50,
  );
  static const _KIcon report = _KIcon(Symbols.brightness_alert);
  static const _KIcon distance = _KIcon(Symbols.distance);
  static const _KIcon captivePortal = _KIcon(Symbols.captive_portal);
  static const _KIcon calendarClock = _KIcon(Symbols.calendar_clock);
  static const _KIcon user = _KIcon(Symbols.person);
  static const _KIcon link = _KIcon(Symbols.link);
  static const _KIcon settings = _KIcon(Symbols.settings);
  static const _KIcon investors = _KIcon(Symbols.business);
  static const _KIcon menu = _KIcon(Symbols.menu);
  static const _KIcon info = _KIcon(
    Symbols.info,
  );
  static const _KIcon favorite = _KIcon(Symbols.favorite);
  static const _KIcon moreVert = _KIcon(
    Symbols.more_vert,
    weight: 700,
    grade: 200,
  );
  static const _KIcon modeOffOn = _KIcon(
    Symbols.mode_off_on,
  );
  static const _KIcon arrowBackIOS = _KIcon(
    Symbols.arrow_back_ios,
  );

  static const _KIcon copy = _KIcon(Symbols.content_copy);
  static const _KIcon noInternet = _KIcon(
    Symbols.signal_cellular_connected_no_internet_0_bar,
    color: AppColors.materialThemeSysLightError,
  );
  static const _KIcon personEdit = _KIcon(Symbols.person_edit);
  static const _KIcon logOut = _KIcon(
    Symbols.logout,
    color: AppColors.materialThemeWhite,
  );
  static const _KIcon arrowDropDown = _KIcon(Symbols.arrow_drop_down);
  static const _KIcon arrowDropUp = _KIcon(Symbols.arrow_drop_up);
  static const _KIcon sort = _KIcon(
    Symbols.sort,
    grade: 200,
  );
  static const _KIcon call = _KIcon(Symbols.call);

  static const logo = _KIcon(
    IconData(0xe1, fontFamily: KAppText.veteranamFontName),
    size: KSize.kFont48,
  );
  static const google = _KIcon(
    IconData(0xe2, fontFamily: KAppText.veteranamFontName),
    color: AppColors.materialThemeKeyColorsNeutral,
  );
  static const myDiscountEmpty = _KIcon(
    IconData(0xe3, fontFamily: KAppText.veteranamFontName),
    size: KSize.kFont96,
    color: AppColors.materialThemeRefNeutralNeutral80,
  );
  static const facebook = _KIcon(
    IconData(0xe4, fontFamily: KAppText.veteranamFontName),
    color: AppColors.materialThemeKeyColorsSecondary,
  );
  static const found = _KIcon(
    IconData(0xe5, fontFamily: KAppText.veteranamFontName),
    size: KSize.kFont128,
    color: AppColors.materialThemeRefNeutralNeutral80,
  );
  static const instagram = _KIcon(
    IconData(0xe6, fontFamily: KAppText.veteranamFontName),
    color: AppColors.materialThemeKeyColorsSecondary,
  );
  static const linkedIn = _KIcon(
    IconData(0xe7, fontFamily: KAppText.veteranamFontName),
    color: AppColors.materialThemeKeyColorsSecondary,
  );
  static const apple = _KIcon(
    IconData(0xe8, fontFamily: KAppText.veteranamFontName),
    color: AppColors.materialThemeKeyColorsNeutral,
  );

  static const veteransIcon = _KIcon(
    IconData(0xe10, fontFamily: KAppText.veteranamFontName),
    color: AppColors.materialThemeKeyColorsSecondary,
  );
  static const dsns = _KIcon(
    IconData(0xe11, fontFamily: KAppText.veteranamFontName),
    color: AppColors.materialThemeKeyColorsSecondary,
  );
  static const familyMembers = _KIcon(
    IconData(0xe12, fontFamily: KAppText.veteranamFontName),
    color: AppColors.materialThemeKeyColorsSecondary,
  );
  static const military = _KIcon(
    IconData(0xe13, fontFamily: KAppText.veteranamFontName),
    color: AppColors.materialThemeKeyColorsSecondary,
  );
  static const personsWithDisabilities = _KIcon(
    IconData(0xe14, fontFamily: KAppText.veteranamFontName),
    color: AppColors.materialThemeKeyColorsSecondary,
  );
  static const police = _KIcon(
    IconData(0xe15, fontFamily: KAppText.veteranamFontName),
    color: AppColors.materialThemeKeyColorsSecondary,
  );
  static const ubd = _KIcon(
    IconData(0xe16, fontFamily: KAppText.veteranamFontName),
    color: AppColors.materialThemeKeyColorsSecondary,
  );

  static const _KIcon location = _KIcon(Symbols.location_on);

  static const _KIcon date = _KIcon(Symbols.date_range);

  static const _KIcon gridView = _KIcon(Symbols.grid_view);

  static const _KIcon viewAgenda = _KIcon(Symbols.view_agenda);

  static List<Icon> get pagesIcons => [
        KIcon.tag,
        KIcon.briefcase,
        KIcon.settings,
        KIcon.person,
      ];
}
