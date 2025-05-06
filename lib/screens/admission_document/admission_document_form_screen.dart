import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/admission_document/admission_document_form_widget.dart';

class AdmissionDocumentFormScreen extends StatefulWidget {
  const AdmissionDocumentFormScreen({super.key});

  @override
  State<AdmissionDocumentFormScreen> createState() =>
      _AdmissionDocumentFormScreenState();
}

class _AdmissionDocumentFormScreenState extends State<AdmissionDocumentFormScreen> {

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'Admission Document', child: AdmissionDocumentFormWidget());
  }
}
