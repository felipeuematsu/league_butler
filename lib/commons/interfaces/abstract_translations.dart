abstract class AbstractTranslations {
  Map<Enum, String> get ptBr;

  Map<Enum, String> get enUs;

  Map<String, String> _convertTranslationsMaps(Map<Enum, String> map) => map.map((k, v) => MapEntry(k.toString(), v));

  Map<String, Map<String,String>> get keys => {
        'pt_BR': _convertTranslationsMaps(ptBr),
        'en_US': _convertTranslationsMaps(enUs),
      };
}
