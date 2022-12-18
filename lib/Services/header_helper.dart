class HeadersHelper {
  Map<String, String> getHeaders(token) {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    return headers;
  }
}
