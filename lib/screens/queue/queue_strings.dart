import 'package:get/get.dart';
import 'package:league_butler/commons/interfaces/abstract_translations.dart';

class QueueTranslations extends AbstractTranslations {
  @override
  Map<Enum, String> get enUs => {
        QueueStrings.queue: 'Queue',
        QueueStrings.ranked: 'Ranked',
        QueueStrings.casual: 'Casual',
        QueueStrings.others: 'Others',
      };

  @override
  Map<Enum, String> get ptBr => {
        QueueStrings.queue: 'Fila',
        QueueStrings.ranked: 'Ranqueada',
        QueueStrings.casual: 'Casual',
        QueueStrings.others: 'Outras',
      };
}

enum QueueStrings {
  queue,
  ranked,
  casual,
  others,
}

extension QueueStringsExt on QueueStrings {
  String get tr => toString().tr;
}
