import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:me_super_admin/app_enum.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:me_super_admin/model/http_service/get_http_service.dart';
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/post_http_service.dart';
import 'package:me_super_admin/model/http_service/patch_http_service.dart';
import 'package:me_super_admin/model/http_service/delete_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';

class HttpService {
  static Future<HttpResponseService> mockData({
    required String endpoint,
    required int statusCode,
  }) async {
    try {
      final String response = await rootBundle.loadString(endpoint);
      final Map<String, dynamic> responseData = json.decode(response);

      await Future.delayed(const Duration(seconds: 10), () {});

      return HttpResponseService.fromJson({
        "data": responseData['data'],
        "message": responseData['message'],
        "status": statusCode,
      });
    } catch (error) {
      print("Mock API call error $error");
      return HttpResponseService.fromJson({
        "data": [],
        "message": "something went wrong",
        "status": 500,
      });
    }
  }

  static Future<HttpResponseService> getRequest(
    GetHttpService getHttpService,
  ) async {
    print("API_END_POINT ${dotenv.env['API_END_POINT']}");
    print("API Endpoint ${getHttpService.endPoint}");
    print("Request headers${getHttpService.headers}");

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
    };

    if (getHttpService.headers != null) {
      headers = headers..addAll(getHttpService.headers!);
    }

    if (AppEnvironment.demo.name == dotenv.env['ENVIRONMENT']) {
      return await mockData(
        endpoint: getHttpService.mockHttpAPIProperty.endPoint,
        statusCode: getHttpService.mockHttpAPIProperty.statusCode,
      );
    } else {
      try {
        final response = await http.get(
          Uri.parse(
              '${dotenv.env['API_END_POINT']}/${getHttpService.endPoint}'),
          headers: headers,
        );

        Map<String, dynamic> responseData = json.decode(response.body);

        return HttpResponseService.fromJson({
          "data": responseData['data'],
          "message": responseData['message'],
          "status": response.statusCode,
        });
      } catch (error) {
        print("GET API Error: $error");
        return HttpResponseService.fromJson({
          "data": [],
          "message": "something went wrong please try again later.",
          "status": 500,
        });
      }
    }
  }

  static Future<HttpResponseService> postRequest(
    PostHttpService postHttpService,
  ) async {
    print("API_END_POINT ${dotenv.env['API_END_POINT']}");
    print("API Endpoint ${postHttpService.endPoint}");
    print("Request Body${postHttpService.body}");
    print("Request headers${postHttpService.headers}");

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
    };

    if (postHttpService.headers != null) {
      headers = headers..addAll(postHttpService.headers!);
    }

    if (AppEnvironment.demo.name == dotenv.env['ENVIRONMENT']) {
      return await mockData(
        endpoint: postHttpService.mockHttpAPIProperty.endPoint,
        statusCode: postHttpService.mockHttpAPIProperty.statusCode,
      );
    } else {
      try {
        final response = await http.post(
          Uri.parse(
              '${dotenv.env['API_END_POINT']}/${postHttpService.endPoint}'),
          headers: headers,
          body: jsonEncode(postHttpService.body),
        );

        Map<String, dynamic> responseData = json.decode(response.body);

        return HttpResponseService.fromJson({
          "data": responseData['data'],
          "message": responseData['message'],
          "status": response.statusCode,
        });
      } catch (error) {
        return HttpResponseService.fromJson({
          "data": [],
          "message": "something went wrong",
          "status": 500,
        });
      }
    }
  }

  static Future<HttpResponseService> putRequest(
    PutHttpService putHttpService,
  ) async {
    print("API_END_POINT ${dotenv.env['API_END_POINT']}");
    print("API Endpoint ${putHttpService.endPoint}");
    print("Request Body${putHttpService.body}");
    print("Request headers${putHttpService.headers}");

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
    };

    if (putHttpService.headers != null) {
      headers = headers..addAll(putHttpService.headers!);
    }

    if (AppEnvironment.demo.name == dotenv.env['ENVIRONMENT']) {
      return await mockData(
        endpoint: putHttpService.mockHttpAPIProperty.endPoint,
        statusCode: putHttpService.mockHttpAPIProperty.statusCode,
      );
    } else {
      try {
        final response = await http.put(
          Uri.parse(
              '${dotenv.env['API_END_POINT']}/${putHttpService.endPoint}'),
          headers: headers,
          body: jsonEncode(putHttpService.body),
        );

        Map<String, dynamic> responseData = json.decode(response.body);

        return HttpResponseService.fromJson({
          "data": responseData['data'],
          "message": responseData['message'],
          "status": response.statusCode,
        });
      } catch (error) {
        return HttpResponseService.fromJson({
          "data": [],
          "message": "something went wrong",
          "status": 500,
        });
      }
    }
  }

  static Future<HttpResponseService> patchRequest(
    PatchHttpService patchHttpService,
  ) async {
    print("API_END_POINT ${dotenv.env['API_END_POINT']}");
    print("API Endpoint ${patchHttpService.endPoint}");
    print("Request headers${patchHttpService.headers}");
    print("Request body${patchHttpService.body}");

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
    };

    if (patchHttpService.headers != null) {
      headers = headers..addAll(patchHttpService.headers!);
    }

    if (AppEnvironment.demo.name == dotenv.env['ENVIRONMENT']) {
      return await mockData(
        endpoint: patchHttpService.mockHttpAPIProperty.endPoint,
        statusCode: patchHttpService.mockHttpAPIProperty.statusCode,
      );
    } else {
      try {
        final response = await http.patch(
          Uri.parse(
              '${dotenv.env['API_END_POINT']}/${patchHttpService.endPoint}'),
          headers: headers,
          body: jsonEncode(patchHttpService.body),
        );

        Map<String, dynamic> responseData = json.decode(response.body);

        return HttpResponseService.fromJson({
          "data": responseData['data'],
          "message": responseData['message'],
          "status": response.statusCode,
        });
      } catch (error) {
        return HttpResponseService.fromJson({
          "data": [],
          "message": "something went wrong",
          "status": 500,
        });
      }
    }
  }

  static Future<HttpResponseService> deleteRequest(
    DeleteHttpService deleteHttpService,
  ) async {
    print("API_END_POINT ${dotenv.env['API_END_POINT']}");
    print("API Endpoint ${deleteHttpService.endPoint}");
    print("Request headers${deleteHttpService.headers}");

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
    };

    if (deleteHttpService.headers != null) {
      headers = headers..addAll(deleteHttpService.headers!);
    }

    if (AppEnvironment.demo.name == dotenv.env['ENVIRONMENT']) {
      return await mockData(
        endpoint: deleteHttpService.mockHttpAPIProperty.endPoint,
        statusCode: deleteHttpService.mockHttpAPIProperty.statusCode,
      );
    } else {
      try {
        final response = await http.delete(
          Uri.parse(
              '${dotenv.env['API_END_POINT']}/${deleteHttpService.endPoint}'),
          headers: headers,
        );

        Map<String, dynamic> responseData = json.decode(response.body);

        return HttpResponseService.fromJson({
          "data": responseData['data'],
          "message": responseData['message'],
          "status": response.statusCode,
        });
      } catch (error) {
        return HttpResponseService.fromJson({
          "data": [],
          "message": "something went wrong",
          "status": 500,
        });
      }
    }
  }
}
