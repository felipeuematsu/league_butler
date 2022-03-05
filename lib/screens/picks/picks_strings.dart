import 'package:get/get.dart';
import 'package:league_butler/commons/interfaces/abstract_translations.dart';
import 'package:league_butler/screens/components/scaffolds/horizontal_status_bar/controller/status_bar_controller.dart';

class PicksTranslations extends AbstractTranslations {
  @override
  Map<Enum, String> get enUs => {
    PicksStrings.picks: 'Picks',
  };

  @override
  Map<Enum, String> get ptBr => {
    StatusBarItemType.pick: 'Seleção',
  };
}

enum PicksStrings {
  picks,
}

extension PicksStringsExtension on PicksStrings {
  String get tr => toString().tr;
}
