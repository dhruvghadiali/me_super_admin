import 'package:flutter/material.dart';
import 'package:tab_container/tab_container.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/screen/school/school_form/school_form_widget.dart';
import 'package:me_super_admin/widget/screen/school/school_list/school_list_widget.dart';
import 'package:me_super_admin/widget/common/tab/tab_container/tab_container_widget.dart';

class SchoolWidget extends StatefulWidget {
  const SchoolWidget({super.key});

  @override
  State<SchoolWidget> createState() => _SchoolWidgetState();
}

class _SchoolWidgetState extends State<SchoolWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;

    return TabContainer(
      controller: _tabController,
      color: themeData.calPolyPomonaGreen,
      tabEdge: TabEdge.bottom,
      tabBorderRadius: BorderRadius.circular(0),
      tabs: [
        Text(
          'Active Schools',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color:
                _currentIndex == 0 ? themeData.offWhite : themeData.eerieBlack,
            fontWeight:
                _currentIndex == 0 ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          'Inactive Schools',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color:
                _currentIndex == 1 ? themeData.offWhite : themeData.eerieBlack,
            fontWeight:
                _currentIndex == 1 ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          'Add New Schools',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color:
                _currentIndex == 2 ? themeData.offWhite : themeData.eerieBlack,
            fontWeight:
                _currentIndex == 2 ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
      children: [
        TabContainerWidget(child: SchoolListWidget(isActive: true)),
        TabContainerWidget(child: SchoolListWidget(isActive: false)),
        TabContainerWidget(child: SchoolFormWidget()),
      ],
    );
  }
}
