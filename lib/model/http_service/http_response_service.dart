import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';

class HttpResponseService {
  final List<dynamic> data;
  final String message;
  final AppHttpRequestStatus appHttpRequestStatus;

  HttpResponseService({
    required this.data,
    required this.message,
    required this.appHttpRequestStatus,
  });

  factory HttpResponseService.fromJson(Map<String, dynamic> json) {
    return HttpResponseService(
      data: setData(json),
      message: setMessage(json),
      appHttpRequestStatus: setAppHttpRequestStatus(json),
    );
  }

  static List<dynamic> setData(Map<String, dynamic> json) {
    if (json.containsKey('data')) {
      if (json['data'] is List ||
          json['data'] != null ||
          json['data'].length > 0) {
        return json['data'];
      }
    }

    return [];
  }

  static String setMessage(Map<String, dynamic> json) {
    if (json.containsKey('message')) {
      if (json['message'] is String ||
          json['message'] != null ||
          json['message'].toString().isNotEmpty) {
        return json['message'];
      }
    }

    return '';
  }

  static AppHttpRequestStatus setAppHttpRequestStatus(
      Map<String, dynamic> json) {
    if (json.containsKey('status')) {
      if (json['status'] != null) {
        if (json['status'] == 200 || json['status'] == 201) {
          return AppHttpRequestStatus.isSuccessfullyServiced;
        } else if (json['status'] == 401) {
          Utils.logout();
          return AppHttpRequestStatus.unAuthorizedUser;
        } else if (json['status'] == 500) {
          return AppHttpRequestStatus.error;
        } else {
          return AppHttpRequestStatus.notSuccessfullyServiced;
        }
      }
    }
    return AppHttpRequestStatus.error;
  }
}
