import 'package:get/get.dart';
import 'package:league_butler/commons/interfaces/abstract_translations.dart';

class QueueTranslations extends AbstractTranslations {
  @override
  Map<Enum, String> get enUs => {
    QueueStrings.queue: 'queue',
    QueueStrings.addQueueConfig: 'Add config',
  };

  @override
  Map<Enum, String> get ptBr => {
    QueueStrings.queue: 'fila',
    QueueStrings.addQueueConfig: 'Adicionar\nconfiguração',
  };

}

enum QueueStrings {
  queue,
  addQueueConfig,
}


extension QueueStringsExt on QueueStrings {
  String get tr => toString().tr;
}
