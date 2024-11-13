import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tmdb/models/user.dart';

SessionStore sessionStore = SessionStore();

class SessionStore {
  static const String sessionIdKey = 'session_id';
  static const String userKey = 'user';

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> saveSession({
    required String sessionId,
    required User user,
  }) async {
    String userJson = jsonEncode(user.toJson());

    await storage.write(key: SessionStore.sessionIdKey, value: sessionId);
    await storage.write(key: SessionStore.userKey, value: userJson);
  }

  Future<RestoredSession?> restoreSession() async {
    String? sessionId = await storage.read(key: SessionStore.sessionIdKey);
    String? userJson = await storage.read(key: SessionStore.userKey);

    User? user;

    if (userJson != null) {
      user = User.fromJson(jsonDecode(userJson));
    }

    if (sessionId != null && user != null) {
      return RestoredSession(sessionId: sessionId, user: user);
    }

    return null;
  }
}

class RestoredSession {
  final String sessionId;
  final User user;

  const RestoredSession({required this.sessionId, required this.user});
}
