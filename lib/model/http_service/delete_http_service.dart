import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';

class DeleteHttpService {
  String endPoint;
  MockHttpAPIPropertyService mockHttpAPIProperty;
  Map<String, String>? headers;

  DeleteHttpService({
    required this.endPoint,
    required this.mockHttpAPIProperty,
    this.headers,
  });
}
