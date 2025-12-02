import 'package:evently/models/event_data_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../common/app_colors.dart';
import '../../common/custom_text_styles.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/create_event_screen_provider.dart';

class PickLocationScreenForEditEvent extends StatefulWidget {
  static const String routeName = '/pickLocationScreenForEditEvent';
  final CreateEventScreenProvider provider;
  final EventDataModel eventDataModel;

  const PickLocationScreenForEditEvent(
      {super.key, required this.provider, required this.eventDataModel});

  @override
  State<PickLocationScreenForEditEvent> createState() =>
      _PickLocationScreenForEditEventState();
}

class _PickLocationScreenForEditEventState
    extends State<PickLocationScreenForEditEvent> {
  bool isMapInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.provider.goToEventLocation(
          LatLng(
              widget.provider.eventLocation?.latitude ??
                  widget.eventDataModel.latitude,
            widget.provider.eventLocation?.longitude ??
                widget.eventDataModel.longitude,),
          widget.eventDataModel.title);
      isMapInitialized = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isMapInitialized
          ? Column(
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
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
