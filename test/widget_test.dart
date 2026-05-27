import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vroom/core/network/backend_discovery_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('stores normalized backend base URL', () async {
    SharedPreferences.setMockInitialValues({});
    final sharedPreferences = await SharedPreferences.getInstance();
    final service = BackendDiscoveryService(
      sharedPreferences: sharedPreferences,
    );

    await service.saveResolvedBaseUrl('http://192.168.43.10:8000/');

    expect(
      await service.getSavedBaseUrl(),
      equals('http://192.168.43.10:8000'),
    );
  });

  test('keeps backend lookup error nontechnical', () {
    expect(
      backendServerNotFoundMessage,
      equals(
        'Сервер не найден. Проверьте, что телефон подключён к корректной сети, и попробуйте ещё раз.',
      ),
    );
  });
}
