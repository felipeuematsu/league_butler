import 'dart:io';
import 'dart:typed_data';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/services.dart';
import 'package:league_butler/gateway/interceptor/api_key_interceptor.dart';
import 'package:league_butler/gateway/interceptor/encrypt_interceptor.dart';
import 'package:league_butler/gateway/model/gateway_settings.dart';
import 'package:league_butler/gateway/util/const.dart';
import 'package:league_butler/gateway/util/environment_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class AbstractGateway extends DioForNative {
  AbstractGateway({this.isEnableEncrypt = false, this.apiKey}) : super() {
    if (isEnableEncrypt && apiKey == null) throw 'Encryption requires api key.';

    options = getBaseOptions();
    certificatesConfigure();
    interceptors.addAll(
      _getInterceptors().whereType(),
    );

    // (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) => client..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }

  abstract final GatewaySettings settings;
  final bool isEnableEncrypt;
  final String? apiKey;

  BaseOptions getBaseOptions() => BaseOptions(
        baseUrl: settings.baseHost,
        sendTimeout: sendTimeout,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
      );

  void certificatesConfigure() {
    httpClientAdapter = Http2Adapter(
      ConnectionManager(
        onClientCreate: (uri, config) async {
          if (EnvironmentConfig.isEnableSslPinning) {
            final credentialsPath = settings.credentialsPath;
            if (credentialsPath == null) return;

            config.context = SecurityContext(withTrustedRoots: true)
              ..useCertificateChainBytes(await getFileFromByteData(credentialsPath));

          } else {
            config.onBadCertificate = (_) => true;
          }
        },
      ),
    );
  }

  Future<Uint8List> getFileFromByteData(String certificatePem) async {
    var certificatePemByteData = await loadCertificate(certificatePem);
    var certificatePemData = certificatePemByteData.buffer.asUint8List(certificatePemByteData.offsetInBytes, certificatePemByteData.lengthInBytes);
    return certificatePemData;
  }

  ///
  /// If necessary, convert the certificate using the guide below:
  ///
  /// https://www.poftut.com/convert-der-pem-pem-der-certificate-format-openssl/
  ///
  Future<ByteData> loadCertificate(String certificate) => rootBundle.load(certificate);

  List<Interceptor?> _getInterceptors() => [
        getLogger(),
        if (isEnableEncrypt) EncryptInterceptor(),
        if (apiKey != null) ApiKeyInterceptor(apiKey ?? ''),
        ...additionalInterceptors,
      ];

  List<Interceptor?> get additionalInterceptors => [];

  Interceptor getLogger() => PrettyDioLogger(
        requestHeader: EnvironmentConfig.isLoggingEnable,
        error: EnvironmentConfig.isLoggingEnable,
        request: EnvironmentConfig.isLoggingEnable,
        requestBody: EnvironmentConfig.isLoggingEnable,
        responseBody: EnvironmentConfig.isLoggingEnable,
        responseHeader: EnvironmentConfig.isLoggingEnable,
        compact: EnvironmentConfig.isLoggingEnable,
      );
}
