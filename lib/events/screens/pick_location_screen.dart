import 'package:evently/common/app_colors.dart';
import 'package:evently/common/custom_text_styles.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/create_event_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationScreen extends StatefulWidget {
  static const String routeName = '/pickLocationScreen';
  final CreateEventScreenProvider provider;

  const PickLocationScreen({super.key, required this.provider});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: widget.provider.cameraPosition,
              onMapCreated: (controller) {
                widget.provider.googleMapController = controller;
              },
              mapType: MapType.normal,
              markers: widget.provider.markers,
              onTap: (latLng) {
                widget.provider.chooseEventLocation(latLng);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.mainColor),
            alignment: Alignment.center,
            child: Text(
              AppLocalizations.of(context)!.tapOnLocationToSelect,
              style: CustomTextStyles.style18w500White
                  .copyWith(color: AppColors.secLightColor, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
