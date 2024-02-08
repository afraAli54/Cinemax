class RequestTokenModel {
  final bool success;
  final String expiresAt;
  final String requestToken;
  RequestTokenModel({
    required this.success,
    required this.expiresAt,
    required this.requestToken,
  });

  factory RequestTokenModel.fromJson(Map<String, dynamic> json) {
    return RequestTokenModel(
        success: json['success'],
        expiresAt: json['expiresAt'],
        requestToken: json['requestToken']);
  }

  Map<String, dynamic> toJson() => {
        'request_token': requestToken,
      };
}
