import 'package:get/get.dart';
import 'package:league_butler/gateway/client/data_dragon_client.dart';

class DataDragonService extends GetxService {
  static final _client = DataDragonClient();

  String getVersion() => _client.version;

  Future<String> getProfileIcon(int profileIconId) async => await _client.getCdn('/img/profileicon/$profileIconId.png');

  String getProfileIconUrl(int profileIconId) => _client.cdnUrl('/img/profileicon/$profileIconId.png');
}
