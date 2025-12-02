import 'package:evently/common/app_colors.dart';
import 'package:evently/common/custom_text_styles.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:evently/providers/map_tab_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class EventCardMapTab extends StatefulWidget {
  final EventDataModel eventDataModel;
  final MapTapProvider provider;

  const EventCardMapTab(
      {super.key, required this.eventDataModel, required this.provider});

  @override
  State<EventCardMapTab> createState() => _EventCardMapTabState();
}

class _EventCardMapTabState extends State<EventCardMapTab> {
  @override
  void initState() {
    super.initState();
    widget.provider.convertLatLngToAddress(LatLng(
        widget.eventDataModel.latitude, widget.eventDataModel.longitude));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.81,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(
              color: AppColors.mainColor,
            ),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(widget.eventDataModel.categoryValues.getImage(
                  context.watch<ThemeProvider>().themeMode == ThemeMode.dark)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 0.39,
                    child: Text(
                      widget.eventDataModel.title,
                      style: CustomTextStyles.style14w700White
                          .copyWith(color: AppColors.mainColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Theme.of(context).textTheme.labelMedium?.color,
                      ),
                      SizedBox(
                        width: width * 0.31,
                        child: Text(
                          '${widget.eventDataModel.state}, ${widget.eventDataModel.country}',
                          style: Theme.of(context).textTheme.labelSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
