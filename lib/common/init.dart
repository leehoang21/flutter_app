import 'package:flutter_app/common/local_storage.dart';
import 'package:flutter_app/common/log.dart';
import 'package:flutter_app/common/notification_config.dart';

import 'contant.dart';
import 'service.dart';

init() async {
  final client = await Service.getSSLPinningClient();
  final prefs = await LocalStorage.create;
  final localStorage = LocalStorage(prefs);
  await Logger.init();
  final notificationConfig = NotificationConfig();
  await notificationConfig.init();
  serviceApp = Service(client, localStorage, notificationConfig);
}
