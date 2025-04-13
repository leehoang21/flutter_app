import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_app/common/local_storage.dart';
import 'package:flutter_app/service/tracsaction_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../service/auth_service.dart';
import 'notification_config.dart';

class Service {
  late final AuthService authService;
  late final TransactionService transactionService;
  final NotificationConfig notificationConfig;

  final LocalStorage localStorage;

  Service(http.Client client, this.localStorage, this.notificationConfig) {
    authService = AuthService(client, localStorage);
    transactionService = TransactionService(client, localStorage);
  }

  static Future<SecurityContext> get _globalContext async {
    final sslCert = await rootBundle.load('assets/certificate.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  static Future<http.Client> getSSLPinningClient() async {
    HttpClient client = HttpClient(context: await _globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    IOClient ioClient = IOClient(client);
    return ioClient;
  }
}
