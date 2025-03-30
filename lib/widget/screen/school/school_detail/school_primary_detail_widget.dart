import 'package:flutter/material.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class SchoolPrimaryDetailWidget extends StatelessWidget {
  const SchoolPrimaryDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'RMPS Flying Kids Pre School ssf sf dsf'.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(color: themeData.offWhite),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            'Ankleshwar, Gujarat'.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(color: themeData.offWhite),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(Icons.phone, color: themeData.offWhite, size: 15,),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '+91 9876543210'.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                context,
              ).textTheme.labelSmall!.copyWith(color: themeData.offWhite),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(Icons.email, color: themeData.offWhite, size: 15,),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'rmpsflyingkids@gmail.com'.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: themeData.offWhite),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(Icons.location_on, color: themeData.offWhite, size: 15,),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'JXQP+W3M, Ompuri -2 Society, Jalaram Nagar, Ankleshwar, Gujarat 393001 '
                      .toUpperCase(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: themeData.offWhite),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
