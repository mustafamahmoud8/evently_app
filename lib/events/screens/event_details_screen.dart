import 'package:evently/common/app_colors.dart';
import 'package:evently/common/custom_text_styles.dart';
import 'package:evently/common/services/firebase_services.dart';
import 'package:evently/events/screens/edit_event_screen.dart';
import 'package:evently/home/screens/home_screen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:evently/providers/create_event_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class EventDetailsScreen extends StatefulWidget {
  static const String routeName = '/eventDetailsScreen';

  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    EventDataModel eventDataModel =
        ModalRoute.of(context)!.settings.arguments as EventDataModel;

    CreateEventScreenProvider provider =
        Provider.of<CreateEventScreenProvider>(context);

    provider.convertLatLngToAddress(
        LatLng(eventDataModel.latitude, eventDataModel.longitude));

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.eventDetails),
        actions: [
          SizedBox(
            width: 20,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditEventScreen.routeName,
                    arguments: eventDataModel);
              },
              icon: Icon(
                Icons.mode_edit_outline_outlined,
                size: 24,
              ),
              padding: EdgeInsets.zero,
              alignment: Alignment.centerRight,
            ),
          ),
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () async {
                  await FirebaseServices.deleteEvent(eventDataModel);
                  Navigator.of(context).pushNamed(HomeScreen.routeName);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!
                          .theEventIsDeletedSuccessfully,
                      style: CustomTextStyles.style18w500White
                          .copyWith(color: Colors.black),
                    ),
                    backgroundColor: Colors.yellow,
                    duration: Duration(seconds: 5),
                    showCloseIcon: true,
                    closeIconColor: Colors.black,
                  ));
                },
                icon: Icon(
                  Icons.delete_outline_rounded,
                  size: 24,
                  color: AppColors.red,
                ),
                alignment: Alignment.centerRight,
              );
            },
          ),
        ],
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  eventDataModel.categoryValues.getImage(
                      context.watch<ThemeProvider>().themeMode ==
                          ThemeMode.dark),
                  height: height * 0.24,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  eventDataModel.title,
                  style: CustomTextStyles.style18w500White
                      .copyWith(color: AppColors.mainColor, fontSize: 24),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.mainColor,
                    ),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.date_range_outlined,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('dd MMMM yyyy')
                                .format(eventDataModel.dateTime),
                            style: CustomTextStyles.style16w500Black
                                .copyWith(color: AppColors.mainColor),
                          ),
                          Text(
                            // '${eventDataModel.time.hour}',
                            DateFormat('hh:mm a')
                                .format(eventDataModel.dateTime),
                            style: Theme.of(context).textTheme.labelMedium,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mainColor),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.my_location,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '${provider.state}, ${provider.country}',
                            style: CustomTextStyles.style16w500Black
                                .copyWith(color: AppColors.mainColor),
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 22,
                        color: AppColors.mainColor,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.42,
                width: MediaQuery.of(context).size.width * 0.91,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.mainColor),
                      borderRadius: BorderRadius.circular(16)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: GoogleMap(
                      scrollGesturesEnabled: false,
                      rotateGesturesEnabled: false,
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: false,
                      mapToolbarEnabled: false,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(eventDataModel.latitude,
                              eventDataModel.longitude),
                          zoom: 14.4746),
                      mapType: MapType.normal,
                      markers: {
                        Marker(
                          markerId: MarkerId('2'),
                          position: LatLng(eventDataModel.latitude,
                              eventDataModel.longitude),
                          infoWindow: InfoWindow(title: eventDataModel.title),
                        )
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Text(
                eventDataModel.description,
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
        ),
      ]),
    );
  }
}
