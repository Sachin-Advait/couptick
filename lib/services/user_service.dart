// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SessionManager {
  SessionManager._();

  static final GetStorage _storage = GetStorage();

  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserName = 'username';
  static const String _keyUserId = 'user_id';

  // ───────────────────────────────────────────────────────────
  // Save Full Session
  // ───────────────────────────────────────────────────────────

  static Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userId,
    required String fullName,
    required String email,
  }) async {
    await Future.wait([
      _storage.write(_keyAccessToken, accessToken),
      _storage.write(_keyRefreshToken, refreshToken),
      _storage.write(_keyUserName, fullName),
      _storage.write(_keyUserId, userId),
    ]);

    debugPrint('Session saved.');
  }

  // ───────────────────────────────────────────────────────────
  // Auth Getters
  // ───────────────────────────────────────────────────────────

  static String get accessToken => _storage.read<String>(_keyAccessToken) ?? '';

  static String get refreshToken =>
      _storage.read<String>(_keyRefreshToken) ?? '';

  static String get displayName => _storage.read<String>(_keyUserName) ?? '';

  static String get userId => _storage.read<String>(_keyUserId) ?? '';

  // ───────────────────────────────────────────────────────────
  // Clear Session

  static Future<void> clearSession() async {
    await _storage.erase();
    debugPrint('Session cleared.');
  }
}
