import 'model/gateway_settings.dart';

class GatewayDefaultSettings {
  static GatewaySettings urlDigioWebHml = const GatewaySettings(
    'https://servhml.meudigio.com.br/',
    credentialsPath: 'assets/star_meudigio_com_br.pem'
  );

  static GatewaySettings urlDigioWebProd = const GatewaySettings(
    'https://services2.meudigio.com.br/',
    credentialsPath: 'assets/star_meudigio_com_br.pem'
  );

  static GatewaySettings urlDigioDevPlatform = const GatewaySettings(
    'https://dev-platform.digio.com.br/',
    credentialsPath: 'assets/star_platform_digio_com_br.pem'
  );

  static GatewaySettings urlDigioHmlPlatform = const GatewaySettings(
    'https://hml-platform.digio.com.br/',
    credentialsPath: 'assets/star_platform_digio_com_br.pem'
  );

  static GatewaySettings urlDigioProdPlatform = const GatewaySettings(
    'https://prd-platform.digio.com.br/',
    credentialsPath: 'assets/star_platform_digio_com_br.pem'
  );

  static GatewaySettings urlMobileDigioDevApi = const GatewaySettings(
    'https://dev-api-mobile.digio.com.br/',
    credentialsPath: 'assets/star_api_mobile_digio_com_br.pem'
  );

  static GatewaySettings urlMobileDigioHmlApi = const GatewaySettings(
    'https://hml-api-mobile.digio.com.br/',
    credentialsPath: 'assets/star_api_mobile_digio_com_br.pem'
  );

  static GatewaySettings urlMobileDigioProdApi = const GatewaySettings(
    'https://api-mobile.digio.com.br/',
    credentialsPath: 'assets/star_api_mobile_digio_com_br.pem'
  );
}
