class RequestTokenModel {
  late bool success;
  late String requestToken;
  late String expiresAt;

  RequestTokenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    requestToken = json['request_token'];
    expiresAt = json['expires_at'];
  }
  Map<String, dynamic> toJson() => {
        'request_token': requestToken,
      };
}
