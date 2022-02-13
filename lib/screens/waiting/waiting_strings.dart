import 'package:get/get.dart';
import 'package:league_butler/commons/interfaces/abstract_translations.dart';

class WaitingTranslations extends AbstractTranslations {

  @override
  final ptBr = {
    WaitingStrings.waitingForClient: 'Aguardando execução do Cliente...',
    WaitingStrings.clientFound: 'Cliente foi encontrado.',
  };

  @override
  final enUs = {
    WaitingStrings.waitingForClient: 'Waiting for Client execution...',
    WaitingStrings.clientFound: 'League Client was found.',
  };

}

enum WaitingStrings {
  waitingForClient,
  clientFound,
}

extension WaitingStringsExt on WaitingStrings {

  String get tr => toString().tr;

}