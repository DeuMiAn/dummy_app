import 'package:dummy_app/translations/ko_KR/ko_kr.translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'ko_KR': koKr,
  };
}
