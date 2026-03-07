import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:vroom/core/logger/logger.dart';

class AppBlocObserver extends BlocObserver {

  AppBlocObserver(AppLogger logger) : _logger = logger.logger(AppBlocObserver);
  late final Logger _logger;

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    _logger.d('Bloc create: $bloc');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    _logger.d('Bloc event: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    _logger.d('Bloc change: $change');
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _logger.d('Bloc error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    _logger.d('Bloc close: $bloc');
    super.onClose(bloc);
  }
}
