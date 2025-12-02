import 'package:evently/common/app_constants.dart';
import 'package:evently/common/app_prefs.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_slider_model.dart';
import 'package:evently/providers/home_tab_provider.dart';
import 'package:evently/providers/localization_provider.dart';
import 'package:evently/providers/map_tab_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/categories_slider.dart';

class HomeTabHeader extends StatefulWidget {
  const HomeTabHeader({super.key});

  @override
  State<HomeTabHeader> createState() => _HomeTabHeaderState();
}

class _HomeTabHeaderState extends State<HomeTabHeader> {
  @override
  Widget build(BuildContext context) {
    MapTapProvider provider = Provider.of<MapTapProvider>(context);
    provider.convertUserLatLngToAddress(userLocation());

    CategoryValues? selectedId =
        context.watch<HomeTabProvider>().selectedCategory;
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.welcomeBack,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Theme.of(context).splashColor),
                        ),
                        Text(
                          context.read<UserAuthProvider>().userModel?.name ??
                              'User',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Theme.of(context).splashColor,
                                  fontSize: 24),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<ThemeProvider>().changeAppTheme();
                          },
                          padding: EdgeInsets.zero,
                          color: Theme.of(context).splashColor,
                          highlightColor: Theme.of(context).splashColor,
                          icon: Icon(
                            context.watch<ThemeProvider>().themeMode ==
                                    ThemeMode.dark
                                ? Icons.dark_mode_outlined
                                : Icons.light_mode_outlined,
                            size: 28,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          height: 35,
                          width: 35,
                          child: FilledButton(
                            onPressed: () {
                              context
                                  .read<LocalizationProvider>()
                                  .changeLocalization();
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(context).splashColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              padding: EdgeInsets.zero,
                              overlayColor: Theme.of(context).splashColor,
                            ),
                            child: Text(
                              context
                                  .watch<LocalizationProvider>()
                                  .getAppLocaleString()
                                  .toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: Theme.of(context).highlightColor),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Theme.of(context).splashColor,
                    ),
                    Text(
                      '${provider.userState}, ${provider.userCountry}',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Theme.of(context).splashColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16),
                child: CategoriesSlider(
                  isHomeTabCategory: true,
                  categoryValues: selectedId,
                  onSelect: (p0) {
                    context.read<HomeTabProvider>().editSelectedCategory(p0);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  LatLng userLocation() {
    double userLocationLatitude = AppPrefs.userLocationLatitudeGetDouble(
            AppConstants.userLocationLatitudeKey) ??
        37.43296265331129;
    double userLocationLongitude = AppPrefs.userLocationLongitudeGetDouble(
            AppConstants.userLocationLongitudeKey) ??
        -122.08832357078792;
    LatLng latLng = LatLng(userLocationLatitude, userLocationLongitude);
    return latLng;
  }
}
