import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/widget/common/loader/loader_widget.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/common/container/no_data_found_widget.dart';
import 'package:me_super_admin/controller/admission_document/admission_document_controller.dart';
import 'package:me_super_admin/widget/screen/admission_document/admission_document_list_view_widget.dart';

class AdmissionDocumentScreen extends StatefulWidget {
  const AdmissionDocumentScreen({super.key});

  @override
  State<AdmissionDocumentScreen> createState() => _AdmissionDocumentScreenState();
}

class _AdmissionDocumentScreenState extends State<AdmissionDocumentScreen> {
  final AdmissionDocumentController admissionDocumentController = Get.put(
    AdmissionDocumentController(),
  );

  @override
  void initState() {
    getAdmissionDocuments();
    super.initState();
  }

  Future<void> getAdmissionDocuments() async {
    await Future.delayed(Duration.zero);
    admissionDocumentController.getAdmissionDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdmissionDocumentController>(
      builder: (admissionDocumentControllerContext) {
        return ScaffoldWidget(
          title: 'Admission Documents',
          child:
              admissionDocumentControllerContext.isLoader
                  ? LoaderWidget(appColorScheme: AppColorScheme.primary)
                  : admissionDocumentControllerContext.admissionDocuments.isEmpty
                  ? NoDataFoundWidget()
                  :AdmissionDocumentListViewWidget(
                    onRefresh: () => getAdmissionDocuments(),
                    admissionDocuments: admissionDocumentControllerContext.admissionDocuments,
                  ),
        );
      },
    );
  }
}
