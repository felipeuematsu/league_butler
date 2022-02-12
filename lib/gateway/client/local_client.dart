import 'package:league_butler/gateway/abstract_gateway.dart';
import 'package:league_butler/gateway/model/gateway_settings.dart';

class LocalClient extends AbstractGateway {
  LocalClient._internal();
  factory LocalClient() => _shared;

  static late final LocalClient _shared = LocalClient._internal();

  @override
  GatewaySettings get settings => const GatewaySettings('https://127.0.0.1', credentialsPath: 'assets/certificate/riotgames.pem');

  @override
  bool get isEnableEncrypt => false;
}
