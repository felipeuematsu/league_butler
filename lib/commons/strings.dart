import 'package:get/get.dart';

class Strings extends Translations {
  Map<String, String> get getMapsBr => {
        ...commonStringsBr,
      };

  static Map<String, String> get commonStringsBr => {
        StringsEnum.leagueButler.name: 'League Butler',
        StringsEnum.continueButton.name: 'Continuar',
        StringsEnum.sendButton.name: 'Enviar',
      };

  Map<String, String> get getMapsEn => {
        ...commonStringsEn,
      };

  static Map<String, String> get commonStringsEn => {
        StringsEnum.leagueButler.name: 'League Butler',
        StringsEnum.continueButton.name: 'Continue',
        StringsEnum.sendButton.name: 'Send',
      };

  @override
  Map<String, Map<String, String>> get keys => {'pt_BR': getMapsBr, 'en': getMapsEn};
}

enum StringsEnum {
  leagueButler,
  continueButton,
  sendButton,
}


extension StringsEnumExt on StringsEnum {
  String get tr => name.tr;
}
