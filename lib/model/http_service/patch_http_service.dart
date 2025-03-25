import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';

class PatchHttpService {
  String endPoint;
  MockHttpAPIPropertyService mockHttpAPIProperty;
  Map<String, dynamic> body;
  Map<String, String>? headers;

  PatchHttpService({
    required this.endPoint,
    required this.body,
    required this.mockHttpAPIProperty,
    this.headers,
  });
}
