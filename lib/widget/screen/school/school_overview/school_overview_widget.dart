import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/model/school/school.dart';
import 'package:me_super_admin/controller/school/school_controller.dart';
import 'package:me_super_admin/widget/common/school/content_strip_widget.dart';

class SchoolOverviewWidget extends StatelessWidget {
  const SchoolOverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchoolController>(
      builder: (schoolControllerContext) {
        School school = schoolControllerContext.school;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContentStripWidget(header: 'Affiliate Number', content: school.affiliateNumber.isNotEmpty ? school.affiliateNumber : 'N/A'),
            ContentStripWidget(header: 'Name', content: school.name.isNotEmpty ? school.name : 'N/A'),
            ContentStripWidget(header: 'Short Name', content: school.shortName.isNotEmpty ? school.shortName : 'N/A'),
            ContentStripWidget(header: 'Email', content: school.email.isNotEmpty ? school.email : 'N/A'),
            ContentStripWidget(header: 'Phone', content: school.phoneNumber.isNotEmpty ? school.phoneNumber : 'N/A'),
            ContentStripWidget(header: 'Established Year', content: school.establishedYear.toString()),
            ContentStripWidget(header: 'School Type', content: school.schoolType.schoolType.isNotEmpty ? school.schoolType.schoolType : 'N/A'),
            ContentStripWidget(
              header: 'Education Board',
              content: school.educationBoards.isNotEmpty ? school.educationBoards.map((educationBoard) => educationBoard.educationBoard).join(', ') : 'N/A',
            ),
          ],
        );
      },
    );
  }
}
