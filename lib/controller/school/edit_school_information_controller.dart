import 'package:get/get.dart';
import 'package:me_super_admin/app_enum.dart';

class EditSchoolInformationController extends GetxController {
  EditSchoolInformationHeader currentHeader = EditSchoolInformationHeader.organization;

  setCurrentHeader(EditSchoolInformationHeader header) {
    currentHeader = header;
    update();
  }
}
