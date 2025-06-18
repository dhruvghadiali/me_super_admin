import 'package:flutter/material.dart';
import 'package:me_super_admin/model/school_address/school_address.dart';
import 'package:me_super_admin/widget/common/school/content_strip_widget.dart';

class SchoolAddressOverviewWidget extends StatelessWidget {
  const SchoolAddressOverviewWidget({super.key, required this.schoolAddress});

  final SchoolAddress schoolAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContentStripWidget(header: 'Address', content: schoolAddress.address.isNotEmpty ? schoolAddress.address : 'N/A'),
        ContentStripWidget(header: 'State', content: schoolAddress.state.name.isNotEmpty ? schoolAddress.state.name : 'N/A'),
        ContentStripWidget(header: 'District', content: schoolAddress.district.name.isNotEmpty ? schoolAddress.district.name : 'N/A'),
        ContentStripWidget(header: 'City', content: schoolAddress.city.name.isNotEmpty ? schoolAddress.city.name : 'N/A'),
        ContentStripWidget(header: 'Area Name', content: schoolAddress.areaName.name.isNotEmpty ? schoolAddress.areaName.name : 'N/A'),
        ContentStripWidget(header: 'Zipcode', content: schoolAddress.zipcode.zipcode.isNotEmpty ? schoolAddress.zipcode.zipcode : 'N/A'),
      ],
    );
  }
}
