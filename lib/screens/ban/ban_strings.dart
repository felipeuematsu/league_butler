import 'package:get/get.dart';
import 'package:league_butler/commons/interfaces/abstract_translations.dart';

class BanTranslations extends AbstractTranslations {
  @override
  // TODO: implement enUs
  Map<Enum, String> get enUs => {
    BanStrings.bans: 'Bans',
  };

  @override
  // TODO: implement ptBr
  Map<Enum, String> get ptBr => {
    BanStrings.bans: 'Banimentos',
  };
}

enum BanStrings {
  bans,
}

extension BanStringsExtension on BanStrings {
  String get tr => toString().tr;
}