abstract class AbstractRequest {
  Future<dynamic> sendGetRequest(String path, {dynamic queryParams});

  Future<dynamic> sendPostRequest(String path, {dynamic body, Map<String, dynamic>? param, bool sendHeader = true});

  Future<dynamic> sendPutRequest(String path, {Map<String, dynamic>? body, Map<String, dynamic>? param});

  Future<dynamic> sendDeleteRequest(String path, {Map<String, dynamic>? queryParams});

  Future<Map<String, dynamic>> getBaseHeader();
}
