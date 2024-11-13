class AuthorizationToken {
  final bool success;
  final String expiresAt;
  final String requestToken;

  AuthorizationToken({
    required this.success,
    required this.expiresAt,
    required this.requestToken,
  });

  AuthorizationToken.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        expiresAt = json['expires_at'],
        requestToken = json['request_token'];
}
