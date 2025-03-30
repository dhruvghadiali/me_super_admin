import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';

class GetHttpService {
  String endPoint;
  MockHttpAPIPropertyService mockHttpAPIProperty;
  Map<String, String>? headers;

  GetHttpService({
    required this.endPoint,
    required this.mockHttpAPIProperty,
    this.headers,
  });
}
