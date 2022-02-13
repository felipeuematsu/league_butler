import 'package:get/get.dart';
import 'package:league_butler/commons/interfaces/abstract_translations.dart';

class ComingSoonTranslations extends AbstractTranslations {
  @override
  Map<Enum, String> get enUs => {
        ComingSoonStrings.title: 'Coming Soon',
        ComingSoonStrings.description: 'This feature is still under development. Stay tuned!',
      };

  @override
  Map<Enum, String> get ptBr => {
        ComingSoonStrings.title: 'Em Breve',
        ComingSoonStrings.description: 'Esta funcionalidade ainda está em desenvolvimento. Fique de olho!',
      };
}

enum ComingSoonStrings {
  title,
  description,
}

extension ComingSoonStringsExt on ComingSoonStrings {
  String get tr => toString().tr;
}
