import 'dart:io';
import 'dart:typed_data';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:league_butler/gateway/abstract_gateway.dart';
import 'package:league_butler/gateway/interceptor/local_token_interceptor.dart';
import 'package:league_butler/gateway/model/gateway_settings.dart';
import 'package:league_butler/utils/logger.dart';

class LocalClient extends AbstractGateway {
  LocalClient.init({required this.port}) {
    _shared = this;
  }

  factory LocalClient() => _shared;

  @override
  BaseOptions getBaseOptions() => BaseOptions(
        connectTimeout: 2000,
        receiveTimeout: 60000,
        baseUrl: settings.baseHost,
        sendTimeout: 5000,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {
          'accept': '*/*',
        },
      );

  String port;
  static late LocalClient _shared;

  @override
  List<Interceptor?> get additionalInterceptors => [LocalTokenInterceptor()];

  @override
  GatewaySettings get settings => GatewaySettings('https://127.0.0.1:$port', credentialsPath: 'assets/certificate/riotgames.pem');

  @override
  bool get isEnableEncrypt => false;

  @override
  void certificatesConfigure() async {
    final credentialsPath = settings.credentialsPath;
    if (credentialsPath == null) return;

    final certificateBytes = await getFileFromByteData(credentialsPath);
    httpClientAdapter = DefaultHttpClientAdapter()
      ..onHttpClientCreate = (client) => client = HttpClient(
            context: SecurityContext(withTrustedRoots: true)..useCertificateChainBytes(certificateBytes),
          )..badCertificateCallback = (cert, host, port) => true;
  }
}
