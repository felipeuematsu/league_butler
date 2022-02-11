import 'package:get/get.dart';
import 'package:league_butler/commons/interfaces/abstract_translations.dart';
import 'package:league_butler/main/main_strings.dart';

class Strings extends Translations {
  List<AbstractTranslations> get _strings => [
        CommonTranslations(),
        MainTranslations(),
      ];

  @override
  Map<String, Map<String, String>> get keys => {
      'pt_BR': _strings.map((e) => e.ptBr).reduce((v, e) => {...v, ...e}),
      'en_US': _strings.map((e) => e.enUs).reduce((v, e) => {...v, ...e}),
    };
}

enum CommonStrings {
  leagueButler,
  continueButton,
  sendButton,
}

extension CommonStringsExt on CommonStrings {
  String get tr => name.tr;
}

class CommonTranslations extends AbstractTranslations {
  @override
  final enUs = {
    CommonStrings.leagueButler.name: 'League Butler',
    CommonStrings.continueButton.name: 'Continue',
    CommonStrings.sendButton.name: 'Send',
  };

  @override
  final ptBr = {
    CommonStrings.leagueButler.name: 'League Butler',
    CommonStrings.continueButton.name: 'Continuar',
    CommonStrings.sendButton.name: 'Enviar',
  };
}
