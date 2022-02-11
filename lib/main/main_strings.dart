import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:league_butler/commons/interfaces/abstract_translations.dart';

class MainTranslations extends AbstractTranslations {

  @override
  final ptBr = {
    MainStrings.waitingForClient.name: 'Aguardando execução do Client...',
  };

  @override
  final enUs = {
    MainStrings.waitingForClient.name: 'Waiting for Client execution...',
  };

}

enum MainStrings {
  waitingForClient,
}

extension MainStringsExt on MainStrings {

  String get name => 'main_${describeEnum(this)}';
  String get tr => name.tr;

}