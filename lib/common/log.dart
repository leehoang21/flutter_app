import 'package:flutter_app/common/extension.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:http/http.dart';

class LoggerInfo<T> {
  final T data;
  final String message;

  LoggerInfo(this.data, this.message);

  String get dataToString {
    if (data.runtimeType == BaseResponse) {
      final t = data as BaseResponse;
      return t.string();
    }
    if (data.runtimeType == Response) {
      final t = data as Response;
      return t.string();
    }
    return data.toString();
  }

  @override
  String toString() {
    return 'LoggerInfo{data: $dataToString, message: $message}';
  }
}

Future<void> logInfo<T>(LoggerInfo<T> info) async {
  FlutterLogs.logInfo("${info.message}  info: ",
      info.data.runtimeType.toString(), info.dataToString);
  logger(info.toString());
}

Future<void> logError<T>(LoggerInfo<T> err) async {
  FlutterLogs.logError("${err.message}  error: ",
      err.data.runtimeType.toString(), err.data.toString());
  logger(err.toString());
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
