import 'package:flutter/cupertino.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/user.dart';
import 'package:tmdb/services/session_store.dart';


class AuthorizationNotifier extends ChangeNotifier {
  final SessionStore sessionStore = SessionStore();

  bool get authenticated => sessionId != null && user != null;

  String? sessionId;
  User? user;

  AuthorizationNotifier({
    required this.sessionId,
    required this.user,
  });

  Future<void> authenticateUser({required String token}) async {
    sessionId = await tmdbApi.createSessionId(requestToken: token);
    user = await tmdbApi.getUser(sessionId: sessionId!);

    await sessionStore.saveSession(
      sessionId: sessionId!,
      user: user!,
    );

    notifyListeners();
  }
}
