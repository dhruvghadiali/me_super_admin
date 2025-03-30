import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';

class PostHttpService {
  String endPoint;
  MockHttpAPIPropertyService mockHttpAPIProperty;
  Map<String, dynamic> body;
  Map<String, String>? headers;

  PostHttpService({
    required this.endPoint,
    required this.mockHttpAPIProperty,
    required this.body,
    this.headers,
  });
}
