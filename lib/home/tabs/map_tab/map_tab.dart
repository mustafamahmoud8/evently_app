import 'package:app_settings/app_settings.dart';
import 'package:evently/home/tabs/map_tab/widgets/event_card_map_tab.dart';
import 'package:evently/providers/map_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../../common/app_colors.dart';
import '../../../common/services/firebase_services.dart';
import '../../../models/event_data_model.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  List<EventDataModel> _events = [];

  @override
  void initState() {
    super.initState();
    FirebaseServices.getAllEventsStream().listen((eventList) {
      if (mounted) {
        setState(() {
          _events = eventList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MapTapProvider provider = Provider.of<MapTapProvider>(context);
    PermissionStatus? permissionStatus = provider.permissionStatus;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: GoogleMap(
                        initialCameraPosition: provider.cameraPosition,
                        onMapCreated: (controller) {
                          provider.googleMapController = controller;
                        },
                        mapType: MapType.normal,
                        markers: provider.markers,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                        height: MediaQuery.of(context).size.height * 0.19,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                              vertical: 32, horizontal: 16),
                          itemCount: _events.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                provider.goToEventLocation(
                                    LatLng(_events[index].latitude,
                                        _events[index].longitude),
                                    _events[index].title);
                              },
                              child: EventCardMapTab(
                                eventDataModel: _events[index],
                                provider: provider,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10),
                        ),
                      ),
              ],
            ),
          ),
          permissionStatus == PermissionStatus.deniedForever ||
                  permissionStatus == PermissionStatus.denied
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${context.watch<MapTapProvider>().locationMessage}\nclick on the button\nthen choose Application permissions\nthen choose Geographical location\nthen give the location permission',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await AppSettings.openAppSettings();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mainColor),
                          child: Text(
                            'open app settings',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Theme.of(context).splashColor),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        heroTag: Text("btn2"),
        onPressed: () {
          provider.getLocation();
        },
        backgroundColor: AppColors.mainColor,
        child: Icon(
          Icons.gps_fixed,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
