import 'package:flutter_logs/flutter_logs.dart';

Future<void> logInfo<T>(T type) async {
  FlutterLogs.logInfo(type.runtimeType.toString(), 'info', type.toString());
}

Future<void> logError<T>(T type) async {
  FlutterLogs.logError(type.runtimeType.toString(), 'error', type.toString());
}

class Logger {
  static Future init() async {
    await FlutterLogs.initLogs(
        logLevelsEnabled: [
          LogLevel.INFO,
          LogLevel.WARNING,
          LogLevel.ERROR,
          LogLevel.SEVERE
        ],
        timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
        directoryStructure: DirectoryStructure.FOR_DATE,
        logTypesEnabled: ["device", "network", "errors"],
        logFileExtension: LogFileExtension.LOG,
        logsWriteDirectoryName: "MyLogs",
        logsExportDirectoryName: "MyLogs/Exported",
        debugFileOperations: false,
        isDebuggable: false,
        logsRetentionPeriodInDays: 14,
        zipsRetentionPeriodInDays: 3,
        autoDeleteZipOnExport: false,
        autoClearLogs: false,
        enabled: true);
    FlutterLogs.logThis(
        tag: "Logger", subTag: "Logger initialized", level: LogLevel.INFO);
  }
}
