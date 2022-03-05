import 'package:get/get.dart';
import 'package:league_butler/commons/interfaces/abstract_translations.dart';
import 'package:league_butler/screens/ban/ban_strings.dart';
import 'package:league_butler/screens/coming_soon/coming_soon_strings.dart';
import 'package:league_butler/screens/home/home_strings.dart';
import 'package:league_butler/screens/picks/picks_strings.dart';
import 'package:league_butler/screens/queue/queue_strings.dart';
import 'package:league_butler/screens/waiting/waiting_strings.dart';

class Strings extends Translations {
  List<AbstractTranslations> get _strings => [
        CommonTranslations(),
        HomeTranslations(),
        WaitingTranslations(),
        ComingSoonTranslations(),
        QueueTranslations(),
        PicksTranslations(),
        BanTranslations(),
      ];

  @override
  Map<String, Map<String, String>> get keys => _strings.fold<Map<String, Map<String, String>>>({}, (value, translations) => translations.keys.map((k, v) => MapEntry(k, {...value[k] ?? {}, ...v})));
}

enum CommonStrings {
  leagueButler,
  activated,
  deactivated,
}

extension CommonStringsExt on CommonStrings {
  String get tr => toString().tr;
}

class CommonTranslations extends AbstractTranslations {
  @override
  Map<Enum, String> get enUs => {
        CommonStrings.leagueButler: 'League Butler',
        CommonStrings.activated: 'Activated',
        CommonStrings.deactivated: 'Deactivated',
      };

  @override
  Map<Enum, String> get ptBr => {
        CommonStrings.leagueButler: 'League Butler',
        CommonStrings.activated: 'Ativado',
        CommonStrings.deactivated: 'Desativado',
      };
}
