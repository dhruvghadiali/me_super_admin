import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/model/admission_document/admission_document.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';
import 'package:me_super_admin/controller/admission_document/admission_document_controller.dart';
import 'package:me_super_admin/widget/screen/admission_document/admission_document_card_widget.dart';

class AdmissionDocumentListViewWidget extends StatelessWidget {
  const AdmissionDocumentListViewWidget({
    super.key,
    required this.onRefresh,
    required this.admissionDocuments,
  });

  final Function onRefresh;
  final List<AdmissionDocument> admissionDocuments;

  Future<void> deleteAdmissionDocument({
    required BuildContext context,
    required AdmissionDocument admissionDocument,
  }) async {
    final AdmissionDocumentController admissionDocumentController = Get.put(
      AdmissionDocumentController(),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            admissionDocumentController.deleteAdmissionDocument(
              admissionDocument.id,
            );
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> editAdmissionDocument({
    required BuildContext context,
    required AdmissionDocument admissionDocument,
  }) async {
    final AdmissionDocumentController admissionDocumentController = Get.put(
      AdmissionDocumentController(),
    );
    admissionDocumentController.setAdmissionDocumentForm(admissionDocument);
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;

    return Container(
      margin: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
      child: RefreshIndicator(
        onRefresh: () => onRefresh(),
        color: themeData.offWhite,
        child: ListView.builder(
          itemCount: admissionDocuments.length,
          padding: const EdgeInsets.all(0.0),
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: double.infinity,
              child: Slidable(
                key: ValueKey(UniqueKey()),
                endActionPane: ActionPane(
                  dragDismissible: false,
                  motion: const ScrollMotion(),
                  children: [
                    EditSlidableActionWidget(
                      onEdit:
                          () => editAdmissionDocument(
                            context: context,
                            admissionDocument: admissionDocuments[index],
                          ),
                    ),
                    DeleteSlidableActionWidget(
                      onDelete:
                          () => deleteAdmissionDocument(
                            context: context,
                            admissionDocument: admissionDocuments[index],
                          ),
                    ),
                  ],
                ),
                child: AdmissionDocumentCardWidget(
                  admissionDocument: admissionDocuments[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
