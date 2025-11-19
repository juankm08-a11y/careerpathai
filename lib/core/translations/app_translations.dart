import 'package:get/get.dart';
import 'en.dart';
import 'es.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          ...RegisterEn.map,
          ...LoginEn.map,
          ...HomeEn.map,
          ...ProfileEn.map,
          ...ResultsEn.map,
          ...TestEn.map,
        },
        'es': {
          ...RegisterEs.map,
          ...LoginEs.map,
          ...HomeEs.map,
          ...AboutEs.map,
          ...ProfileEs.map,
          ...ResultsEs.map,
          ...TestEs.map,
        }
      };
}
