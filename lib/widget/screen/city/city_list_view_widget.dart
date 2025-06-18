import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/controller/city/city_controller.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/widget/screen/city/city_card_widget.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';

class CityListViewWidget extends StatelessWidget {
  const CityListViewWidget({super.key, required this.onRefresh, required this.cities});

  final Function onRefresh;
  final List<City> cities;

  Future<void> deleteCity({required BuildContext context, required City city}) async {
    final CityController cityController = Get.put(CityController());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            cityController.deleteCity(city.id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> editCity({required BuildContext context, required City city}) async {
    final CityController cityController = Get.put(CityController());
    cityController.setCityForm(city);
  }

  void onAddCityClicked(BuildContext context) {
    final CityController cityController = Get.put(CityController());
    cityController.resetCityForm();
    Navigator.pushNamed(context, RoutePaths.cityForm);
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;

    return Container(
      margin: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
      child: RefreshIndicator(
        onRefresh: () => onRefresh(),
        color: themeData.offWhite,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                itemCount: cities.length,
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
                            onEdit: () => editCity(context: context, city: cities[index]),
                          ),
                          DeleteSlidableActionWidget(
                            onDelete: () => deleteCity(context: context, city: cities[index]),
                          ),
                        ],
                      ),
                      child: CityCardWidget(city: cities[index]),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () => onAddCityClicked(context),
                shape: const CircleBorder(),
                elevation: 10,
                backgroundColor: themeData.calPolyPomonaGreen,
                foregroundColor: themeData.offWhite,
                focusElevation: 10,
                hoverElevation: 12,
                highlightElevation: 14,
                tooltip: 'Add',
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
