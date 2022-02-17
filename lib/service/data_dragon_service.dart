import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/gateway/client/data_dragon_client.dart';

class DataDragonService extends GetxService {
  static final _client = DataDragonClient();

  String getVersion() => _client.version;

  Future<String> getProfileIcon(int profileIconId) async => await _client.getCdn('/img/profileicon/$profileIconId.png');

  Future<String> getChampions() async => await _client.getCdn('/data/${await Database().read<Locale>(DatabaseKeys.locale, persistent: true) ?? 'en_US'}/champion.json');

  String getSquareImageUrl(String champion) => _client.cdnUrl('/img/champion/$champion.json');

  String getProfileIconUrl(int profileIconId) => _client.cdnUrl('/img/profileicon/$profileIconId.png');
}
