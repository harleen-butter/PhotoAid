
import 'package:PhotoAid/localization/ar_sa.dart';
import 'package:PhotoAid/localization/de_de.dart';
import 'package:PhotoAid/localization/en_us.dart';
import 'package:PhotoAid/localization/fr_fr.dart';
import 'package:PhotoAid/localization/zn_ch.dart';

import 'hi_in.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translationsKeys = {
    "en": enUS,
    "hi": hiIN,
    "ar": arSA,
    "de": deDE,
    "fr": frFR,
    "zh": zhCN
  };
}
