import 'package:logger/logger.dart';

class AppLogger {
  Logger logger(Type type) =>
      Logger(printer: _CustomPrinter(type.toString()), level: Level.trace);
}

final class _CustomPrinter extends LogPrinter {

  _CustomPrinter(this.className);
  final String className;

  @override
  List<String> log(LogEvent event) {
    final color =
        PrettyPrinter.defaultLevelColors[event.level] ?? const AnsiColor.none();
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    final message = event.message;
    return [color('$emoji: $className - $message')];
  }
}
