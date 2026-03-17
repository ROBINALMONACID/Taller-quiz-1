import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_config.dart';

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => message;
}

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  static const Map<String, int> _statusNameToId = {
    'Active': 1,
    'Inactive': 2,
    'Blocked': 3,
    'Delete': 4,
  };

  static const Map<String, int> _roleNameToId = {
    'Admin': 1,
    'Test': 2,
  };

  // URL unica del backend.
  static String get baseUrl {
    return apiBaseUrl();
  }

  static const String _tokenKey = 'auth_token';

  Future<void> registerUser({
    required String email,
    required String password,
    required String statusName,
    required String roleName,
  }) async {
    final statusId = _mapStatusId(statusName);
    final roleId = _mapRoleId(roleName);
    final url = Uri.parse('$baseUrl/apiUser');
    final body = {
      // En BD esto es un correo (Api_user), pero el endpoint espera el campo "user".
      'user': email.trim(),
      'password': password,
      'status': statusId,
      'role': roleId,
    };

    final response = await http.post(
      url,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw AuthException(_extractError(response));
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/apiUserLogin');
    final body = {
      'api_user': email.trim(),
      'api_password': password,
    };

    final response = await http.post(
      url,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw AuthException(_extractError(response));
    }

    final payload = jsonDecode(response.body);
    if (payload is! Map<String, dynamic>) {
      throw AuthException('Respuesta inesperada del servidor');
    }

    final token = payload['token'];
    if (token is! String || token.isEmpty) {
      throw AuthException('Token invalido en la respuesta');
    }

    await saveToken(token);
    return token;
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<Map<String, String>> buildAuthHeaders() async {
    final token = await getToken();
    if (token == null || token.isEmpty) {
      return {};
    }
    return {'Authorization': 'Bearer $token'};
  }

  int _mapStatusId(String statusName) {
    final key = statusName.trim();
    final id = _statusNameToId[key];
    if (id == null) {
      throw AuthException('Estado invalido: $statusName');
    }
    return id;
  }

  int _mapRoleId(String roleName) {
    final key = roleName.trim();
    final id = _roleNameToId[key];
    if (id == null) {
      throw AuthException('Rol invalido: $roleName');
    }
    return id;
  }

  String _extractError(http.Response response) {
    try {
      final payload = jsonDecode(response.body);
      if (payload is Map<String, dynamic>) {
        final error = payload['error'];
        if (error != null && error.toString().isNotEmpty) {
          return error.toString();
        }
        final message = payload['message'];
        if (message != null && message.toString().isNotEmpty) {
          return message.toString();
        }
      }
    } catch (_) {
      // Ignorar errores de parsing.
    }
    return 'Error ${response.statusCode}';
  }
}
