import 'package:flutter/foundation.dart' show kIsWeb;

import 'api_platform.dart' as platform;

String apiBaseUrl() {
  const fromDefine = String.fromEnvironment('API_BASE_URL');
  final value = fromDefine.isNotEmpty ? fromDefine : _defaultBaseUrl();
  return _normalizeBaseUrl(value);
}

String _defaultBaseUrl() {
  if (kIsWeb) {
    return 'http://localhost:3000/api_v1';
  }
  if (platform.isAndroid) {
    // Android Emulator: "localhost" apunta al emulador, no a tu PC.
    return 'http://10.0.2.2:3000/api_v1';
  }
  // iOS Simulator y desktop suelen poder usar localhost.
  return 'http://localhost:3000/api_v1';
}

String _normalizeBaseUrl(String value) {
  return value.replaceFirst(RegExp(r'/+$'), '');
}
