import 'package:get/get.dart';
import 'package:me_super_admin/app_enum.dart';

import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/school_type/school_type.dart';
import 'package:me_super_admin/model/http_service/get_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';

class SchoolTypeController extends GetxController {
  bool isLoader = false;
  List<SchoolType> schoolTypes = [];

  Future<void> getSchoolTypes() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    GetHttpService getHttpService = GetHttpService(
      endPoint: 'super-admin/school-types',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/school_types/school_types_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.getRequest(getHttpService);

    if (response.appHttpRequestStatus ==
        AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      for (var schoolTypeJson in response.data) {
        final SchoolType schoolTypeObj = SchoolType.fromJson(schoolTypeJson);
        schoolTypes.add(schoolTypeObj);
      }
    } else {
      isLoader = false;
      Snackbar.getSnackbar(
        title: 'School Types Issue',
        message: response.message,
        appSnackbarStatus: AppSnackbarStatus.error,
      );
    }

    update();
  }
}
